#!/bin/bash

versions=()
while IFS='' read -r line; do
    versions+=("${line}")
done < <(git diff Makefile | grep '+ANSIBLE' | awk '{ print $3 }')

message="v${versions[0]}"
for ((i = 1; i < ${#versions[@]}; i++)); do
    if ((i == ${#versions[@]} - 1)); then
        message+=" and v${versions[i]}"
    else
        message+=", v${versions[i]}"
    fi
done

git add .
git commit -m "Bump to ${message}"

for ((i = 0; i < ${#versions[@]}; i++)); do
    git tag -a "v${versions[i]}" -m "Release v${versions[i]}"
done

git push origin main --tags
