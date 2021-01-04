# Install CoreOS custom resources
kubectl apply -f .

# Install Prometheus
kubectl apply -f ClusterPrometheus/

# Install Grafana
kubectl apply -f Grafana/