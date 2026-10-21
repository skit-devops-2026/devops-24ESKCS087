# Project structure

PUPIL is a static educational website.

- `index.html` is the main entry page; root HTML files provide the other site pages.
- `CSS/` stores the stylesheets, `js/` stores browser JavaScript, and `images/` stores website images. Path casing matters on Linux.
- `Dockerfile` and `docker-compose.yml` build and run the Nginx website.
- `monitoring/prometheus.yml` configures Prometheus; Grafana provisioning and dashboards are stored under `monitoring/grafana/`.
- `k8s/deployment.yaml` and `k8s/service.yaml` define the Kubernetes workload and service.
- `.github/workflows/ci.yml` defines automated repository checks and the container-image publishing workflow.
- `.github/workflows/pages.yml` deploys the static site to GitHub Pages and captures deployment evidence.
- `tests/` contains shell-based validation checks for CI.
- `docs/` contains project documentation, testing instructions, and deployment notes.
