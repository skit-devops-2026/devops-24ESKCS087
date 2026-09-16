# CI checks

The GitHub Actions workflow runs the same commands used for local validation:

```bash
make install
make test
make build
```

For this static website, `make test` executes `tests/test_site.sh` and checks
the required HTML, CSS, and JavaScript files.
