FROM nvidia/cuda:13.0.2-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYENV_ROOT="/home/ubuntu/.pyenv"

RUN apt-get update && \
    apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ubuntu
WORKDIR /home/ubuntu

RUN curl https://pyenv.run | bash
ENV PATH="/home/ubuntu/.pyenv/bin:/home/ubuntu/.pyenv/shims:$PATH"

RUN pyenv install 3.13
RUN pyenv global 3.13

EXPOSE 8188
ENTRYPOINT ["entrypoint.sh"]
CMD ["comfy-cli", "--skip-prompt", "launch", "--", "--listen", "0.0.0.0"]