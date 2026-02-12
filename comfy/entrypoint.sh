#!/bin/bash

sudo chown -R ubuntu:ubuntu /home/ubuntu/venv

if [ ! -f "/home/ubuntu/venv/comfy/bin/python" ]; then
    echo "First run: setting up Python environment..."

    python -m venv /home/ubuntu/venv/comfy

    pip install --no-cache-dir \
        torch torchvision torchaudio \
        --index-url https://download.pytorch.org/whl/cu130

    pip install --no-cache-dir comfy-cli
fi

export PATH="/home/ubuntu/venv/comfy/bin:$PATH"
comfy-cli --skip-prompt install --restore --nvidia

exec "$@"