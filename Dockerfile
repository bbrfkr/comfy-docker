FROM nvidia/cuda:13.0.0-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYENV_ROOT="/opt/pyenv"

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN curl https://pyenv.run | bash

RUN pyenv install 3.13
RUN pyenv global 3.13

ENV PATH="/opt/pyenv/bin:/opt/pyenv/shims:$PATH"

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME ["/venv"]

WORKDIR /home/ubuntu
EXPOSE 8188

USER ubuntu
ENTRYPOINT ["entrypoint.sh"]
CMD ["comfy-cli", "launch", "--", "--listen", "0.0.0.0"]