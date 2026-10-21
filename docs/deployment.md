# Deployment and evidence (M5â€“M7)

PUPIL is a static HTML/CSS/JavaScript website. These files deploy this repository's site; the separate To-Do app used in the Docker practice worksheet is not part of PUPIL.

## Local container and monitoring stack

```sh
docker compose up --build
```

- Website: http://localhost:8080
- Health check: http://localhost:8080/health (JSON includes the image commit)
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

Use `docker compose ps` to verify services and Prometheus Targets to check the `nginx-exporter` target.

## GitHub Pages

The workflow in `.github/workflows/pages.yml` deploys the static site on pushes to `main`. The intended project URL is:

https://skit-devops-2026.github.io/devops-24ESKCS087/

Enable GitHub Pages once in repository Settings â†’ Pages â†’ Build and deployment â†’ Source: GitHub Actions. The workflow verifies the live page and health endpoint, captures a Playwright screenshot, and commits it to `docs/deployment-screenshot.png` after deployment succeeds.

## Container registry

The CI workflow builds and pushes:

- `ghcr.io/skit-devops-2026/devops-24eskcs087:latest`
- `ghcr.io/skit-devops-2026/devops-24eskcs087:sha-COMMIT`

For a cluster that cannot authenticate to GHCR, set this demonstration package to Public or create a Kubernetes image-pull Secret and add it to the Deployment. Never put registry tokens in committed YAML.

## Kubernetes

After the image has been published and the cluster can pull it:

```sh
kubectl apply -f k8s/
kubectl get deployments,pods,services
kubectl rollout status deployment/pupil-web
kubectl port-forward service/pupil-web 8080:80
```

Open http://localhost:8080. Save any course-required Kubernetes-cluster screenshot under `docs/`; the Pages workflow separately captures the live website.

To remove resources:

```sh
kubectl delete -f k8s/
```