# Sample Prometheus and Grafana stack

This is a sample stack for deploying Prometheus and Grafana to work with the Prometheus Operator located here: <https://github.com/prometheus-operator/prometheus-operator>

## Installation instrustions

- Go to <https://github.com/prometheus-operator/prometheus-operator#quickstart> and run the Quickstart guide
- After that run ```kubectl apply -f .``` to run the yaml in this repo against your Kubernetes instance

## Note

- To get a copy of kubectl, follow this guide: <https://kubernetes.io/docs/tasks/tools/install-kubectl>
- Lens is a great GUI tool in seeing how Kubernetes instances are running: <https://k8slens.dev>
- I recommend using Kind to spin up your Kubernetes clusters locally, Kind will create a disposable Kubernetes cluster in Docker which is nicer than a long lived one: <https://kind.sigs.k8s.io>
- Kind users on Windows users may want to follow this guide: <https://blog.nillsf.com/index.php/2020/08/28/running-kind-in-windows>
