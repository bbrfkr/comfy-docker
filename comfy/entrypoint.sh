#!/bin/bash
if [ ! -d "$PYENV_ROOT" ]; then
    cd /home/ubuntu/lib
    sudo chown ubuntu:ubuntu .
    curl https://pyenv.run | bash
    pyenv install 3.11
    pyenv global 3.11
fi

if ! pip show torch > /dev/null 2&>1; then
    pip install --no-cache-dir \
    torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu130
fi

if ! which comfy-cli > /dev/null 2&>1; then
    pip install --no-cache-dir comfy-cli
fi

comfy-cli --skip-prompt install --restore --nvidia
exec "$@"