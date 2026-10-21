# Testing

Run the repository checks in an environment with GNU Make and Bash: `make install`, `make test`, and `make build`.

The test script verifies that the main page, stylesheet, JavaScript, and image directory exist. It checks that root HTML stylesheet paths use the correct `CSS/` directory casing for Linux containers.

The extended checks verify the Dockerfile, Docker Compose configuration, Nginx configuration template, Prometheus configuration, Grafana dashboard JSON, and Kubernetes Deployment and Service manifests.

GitHub Actions runs the repository hygiene checks and build-and-test jobs on pushes and pull requests.

On Windows PowerShell without GNU Make, run `bash tests/test_site.sh` to execute the website and DevOps configuration checks.
