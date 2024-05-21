# syntax=docker/dockerfile:1.4
ARG PYTHON
FROM python:${PYTHON}-slim

ARG ANSIBLE

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOT
  apt update
  apt upgrade -y

  apt install -y --no-install-recommends \
      ssh \
      sshpass

  pip install --no-cache-dir --upgrade pip

  pip install --no-cache-dir \
      ansible \
      ansible-core==${ANSIBLE} \
      passlib

  apt purge --auto-remove -y
  apt autoremove
  apt clean

  rm -rf /var/lib/apt/lists/*
  rm -rf /tmp/*
EOT
