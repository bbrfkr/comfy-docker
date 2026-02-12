#!/bin/bash

sudo chown -R ubuntu:ubuntu /venv
chmod -R 755 /venv

if [ ! -f "/venv/comfy/bin/python" ]; then
    echo "First run: setting up Python environment..."

    python -m venv /venv/comfy

    export PATH="/venv/comfy/bin:$PATH"

    pip install --no-cache-dir \
        torch torchvision torchaudio \
        --index-url https://download.pytorch.org/whl/cu130

    pip install --no-cache-dir comfy-cli

    comfy-cli install --restore
fi

export PATH="/venv/comfy/bin:$PATH"
exec "$@"