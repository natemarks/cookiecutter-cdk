#!/usr/bin/env bash
set -Eeuo pipefail
find . -type f -name "*.py" \
-not -path "*/.venv/*" \
-not -path "*/tests/unit/*" \
-not -path "*/app.py" \
-print0 \
| xargs -0 pylint --max-line-length=90
