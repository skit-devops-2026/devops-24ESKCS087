#!/usr/bin/env bash
set -euo pipefail

echo "Running PUPIL website and DevOps configuration tests..."

test -f index.html
echo "PASS: index.html exists"
grep -qi "<html" index.html
echo "PASS: HTML structure found"
grep -qi "<title" index.html
echo "PASS: page title found"

test -f CSS/style.css
echo "PASS: CSS/style.css exists"
test -f js/script.js
echo "PASS: js/script.js exists"
test -d images
echo "PASS: images directory exists"

# Linux containers are case-sensitive: the repository directory is CSS/, not css/.
if grep -E '(href|src)="css/' ./*.html; then
  echo "FAIL: found lowercase css/ asset paths in root HTML pages"
  exit 1
fi
echo "PASS: root HTML stylesheet paths match CSS/ directory casing"

test -f Dockerfile
echo "PASS: Dockerfile exists"
test -f docker-compose.yml
echo "PASS: docker-compose.yml exists"
test -f nginx/default.conf.template
echo "PASS: Nginx config template exists"

test -f monitoring/prometheus.yml
test -f monitoring/grafana/dashboards/pupil-nginx-overview.json
python3 -m json.tool monitoring/grafana/dashboards/pupil-nginx-overview.json >/dev/null
echo "PASS: Prometheus config and valid Grafana dashboard JSON exist"

test -f k8s/deployment.yaml
echo "PASS: Kubernetes Deployment manifest exists"
test -f k8s/service.yaml
echo "PASS: Kubernetes Service manifest exists"

echo "All website and DevOps configuration tests passed."