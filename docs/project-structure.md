# Project structure

PUPIL is a static educational website.

- Root HTML files are the site pages.
- `CSS/`, `js/`, and `images/` contain website assets (path casing matters on Linux).
- `Dockerfile` and `docker-compose.yml` build and run the Nginx site.
- `monitoring/prometheus.yml` configures Prometheus; Grafana provisioning and a dashboard are committed below `monitoring/grafana/`.
- `k8s/deployment.yaml` and `k8s/service.yaml` define the Kubernetes workload and endpoint.
- `.github/workflows/ci.yml` tests the repository and publishes a GHCR image from `main`.
- `.github/workflows/pages.yml` deploys the site and captures live deployment evidence.
- `tests/` contains shell-based validation checks for CI.