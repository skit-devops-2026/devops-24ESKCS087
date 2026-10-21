# Testing

Run the repository checks with:

```sh
make install
make test
make build
```

The test script checks the main page, required website assets, Linux-sensitive stylesheet paths, Docker/Compose files, the Prometheus configuration, valid Grafana dashboard JSON, and Kubernetes Deployment/Service manifests. GitHub Actions runs these checks on pushes and pull requests.