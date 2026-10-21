# Monitoring

The local Compose stack includes Prometheus, the Nginx Prometheus Exporter, and Grafana.

## Start the stack

```sh
docker compose up --build
```

- PUPIL website: http://localhost:8080
- Health endpoint: http://localhost:8080/health
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

The Grafana datasource and PUPIL Nginx dashboard are provisioned from files in this directory. The exporter reads Nginx `stub_status` on the internal Docker network; port 8081 is not published to the host.

Grafana defaults are intended for local practice only: username `admin`, password `change-me-local-only`. Override them with `GRAFANA_ADMIN_USER` and `GRAFANA_ADMIN_PASSWORD` before using this stack on a shared machine.

To stop the containers, run `docker compose down`. Named volumes retain Prometheus and Grafana state. To remove that state too, run `docker compose down -v`.