#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"

PYTHON=""
for candidate in python3.13 python3.12 python3.11 python3; do
    if command -v "$candidate" >/dev/null 2>&1 && "$candidate" -c 'import sys; raise SystemExit(sys.version_info < (3, 11))'; then
        PYTHON="$candidate"
        break
    fi
done

if [ -z "$PYTHON" ]; then
    printf '%s\n' 'Python 3.11 or newer is needed. Install it, then run start.sh again.'
    exit 1
fi

if [ ! -x .venv/bin/python ]; then
    printf '%s\n' 'First-time setup: preparing the app...'
    "$PYTHON" -m venv .venv
fi

printf '%s\n' 'Checking app files and installing any needed updates...'
.venv/bin/python -m pip install --disable-pip-version-check -r requirements.txt
printf '%s\n' 'Starting Local Chatbot...'
exec .venv/bin/python -m app.main
