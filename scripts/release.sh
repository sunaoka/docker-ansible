#!/bin/bash

versions=()
while IFS='' read -r line; do
    versions+=("${line}")
done < <(git diff Makefile | grep '+ANSIBLE' | awk '{ print $3 }')

message="v${versions[0]}"
for ((i = 1; i < ${#versions[@]}; i++)); do
    message+=", v${versions[i]}"
done

git checkout develop
git add .
git commit -m "Bump to ${message}"
git checkout main
git merge develop --no-ff -m "Merge develop into main for ${message}"

for ((i = 0; i < ${#versions[@]}; i++)); do
    git tag -a "v${versions[i]}" -m "Release v${versions[i]}"
done

git checkout develop
git push origin main develop --tags
