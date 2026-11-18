#!/bin/sh
# Renders the README images: docs/examples/<name>.typ -> docs/images/<name>.png
cd "$(dirname "$0")/.." || exit 1
for f in docs/examples/*.typ; do
  typst compile --root . --ppi 250 "$f" "docs/images/$(basename "$f" .typ).png"
done
