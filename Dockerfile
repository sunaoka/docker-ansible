# syntax=docker/dockerfile:1.4
ARG PYTHON
FROM python:${PYTHON}-slim

ARG ANSIBLE

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOT sh -ex
  apt-get update
  apt-get upgrade -y

  apt-get install -y --no-install-recommends \
      ssh \
      sshpass

  pip install --no-cache-dir --upgrade pip

  pip install --no-cache-dir \
      ansible \
      ansible-core==${ANSIBLE} \
      passlib

  apt-get purge --auto-remove -y
  apt-get autoremove
  apt-get clean

  rm -rf /var/lib/apt/lists/*
  rm -rf /tmp/*
EOT
