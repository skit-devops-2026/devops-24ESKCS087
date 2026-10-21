# PUPIL

## Author

| Roll No. | Name | GitHub username |
|---|---|---|
| 24ESKCS087 | Bhavya Gupta | PRITHVIBO |

## About

PUPIL is an educational platform that provides students with a centralized place to explore learning resources and technology-related topics. The application includes sections covering areas such as AI/ML, Cloud, DevOps, DSA, System Design, and Web Development.

## Tech stack

- Frontend: HTML5, CSS3, JavaScript
- Web server/container: Nginx and Docker
- Local orchestration: Docker Compose
- Monitoring: Prometheus, Nginx Prometheus Exporter, Grafana
- Deployment manifests: Kubernetes Deployment and NodePort Service
- Backend/database: None; PUPIL is a static website

## Live URL

[Open PUPIL on GitHub Pages](https://skit-devops-2026.github.io/devops-24ESKCS087/)

This URL becomes live after GitHub Pages has been enabled and the Pages workflow succeeds. See [deployment notes](docs/deployment.md).

## Health endpoint

`GET /health` returns JSON with `status: ok` and the deployed commit SHA in the Nginx container. GitHub Pages receives a static health file containing the commit used for that deployment.

## Running locally

Run the static-site checks:

```sh
make install
make test
make build
make run
```

Run the container and monitoring stack:

```sh
docker compose up --build
```

- Website: http://localhost:8080
- Health endpoint: http://localhost:8080/health
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

For Grafana credentials, see [monitoring/README.md](monitoring/README.md). Defaults are for local practice only; set `GRAFANA_ADMIN_USER` and `GRAFANA_ADMIN_PASSWORD` before sharing the stack.

## Container registry

The CI workflow publishes `ghcr.io/skit-devops-2026/devops-24eskcs087:latest` and a commit-specific image tag after a successful push to `main`.

## Kubernetes

Apply the resources with `kubectl apply -f k8s/`. The Deployment runs two web replicas and the Service exposes port 30080 on supported clusters. On a local cluster, use `kubectl port-forward service/pupil-web 8080:80`. See [deployment notes](docs/deployment.md).

The GitHub Pages workflow automatically captures a screenshot of the live site under `docs/deployment-screenshot.png` after a successful deployment. The course's Kubernetes-cluster screenshot, if separately required, should also be saved under `docs/`.