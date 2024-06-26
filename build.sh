#!/bin/bash

set -eu

matrix=(
    # Ansible   Python
    "2.13.13    3.10"
    "2.14.16    3.11"
    "2.15.12    3.11"
    "2.16.8     3.12"
    "2.17.1     3.12"
)

for ((i = 0; i < ${#matrix[@]}; i++)); do
    IFS=" " read -r -a row <<<"${matrix[i]}"
    make build ANSIBLE="${row[0]}" PYTHON="${row[1]}"
done
