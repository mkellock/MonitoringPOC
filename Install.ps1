# Get items with potential dependencies
$dependantObjs = Get-ChildItem -Include *.yaml -Recurse | Select-String -Pattern "^\s*kind\:\s*(AlertmanagerConfig|PrometheusRule|Alertmanager|PrometheusRuleList|PrometheusList|ServiceMonitorList|PrometheusRule|Prometheus|ServiceMonitor)" | %{$_.FullName}

# Get the CRDs
$crds = Get-ChildItem -Include *.yaml -Recurse | Select-String -Pattern "^\s*kind\:\s*(CustomResourceDefinition)" | %{$_.FullName}

# Remove the CRDs from the potential dependants
$dependantObjs = $dependantObjs | Where-Object { $crds -notcontains $_ }

# Get all files
$allFiles = Get-ChildItem -Include *.yaml -Recurse | Foreach {"$($_.FullName)"}

# Remove dependant objects
$allFiles = $allFiles | Where-Object { $dependantObjs -notcontains $_ }

# Apply all non-dependant objects
$allFiles | %{kubectl apply -f $_}

# Install the monitoring stack, wait for the monitoring.coreos.com stack if still provisioning
$crd = & kubectl get crd 2>&1

while (
    ($null -eq $($crd | Where-Object { $_ -match 'alertmanagers.monitoring.coreos.com' })) -and
    ($null -eq $($crd | Where-Object { $_ -match 'prometheuses.monitoring.coreos.com' })) -and
    ($null -eq $($crd | Where-Object { $_ -match 'servicemonitors.monitoring.coreos.com' }))
    ) {
    Write-Output "Waiting for custom resources to be provisioned..."

    Start-Sleep -s 1

    $crd = & kubectl get crd 2>&1
}

# Apply the dependant objects
$dependantObjs | %{kubectl apply -f $_}