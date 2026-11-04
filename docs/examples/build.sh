#!/bin/sh
# Compiles every example in this folder to the PNG shown in the README.
cd "$(dirname "$0")/../.." || exit 1
for file in docs/examples/*.typ; do
  typst compile --root . --ignore-system-fonts --ppi 200 "$file" "${file%.typ}.png" || exit 1
done
