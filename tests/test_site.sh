#!/usr/bin/env bash
set -euo pipefail

echo "Running PUPIL website tests..."

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

echo "All website tests passed."
