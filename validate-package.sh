#!/bin/bash
set -e

PACKAGE_DIR="$(pwd)/apkg"
REQUIRED_FILES=(
  "bin/tailscale"
  "bin/tailscaled"
  "CONTROL/config.json"
  "CONTROL/description.txt"
  "CONTROL/changelog.txt"
  "CONTROL/start-stop.sh"
)

for item in "${REQUIRED_FILES[@]}"; do
  if [ ! -e "${PACKAGE_DIR}/${item}" ]; then
    echo "Missing required file: ${PACKAGE_DIR}/${item}"
    exit 1
  fi
done

# Check symlinks / binary presence.
for item in "${PACKAGE_DIR}/bin/tailscale" "${PACKAGE_DIR}/bin/tailscaled"; do
  if [ ! -f "$item" ] && [ ! -L "$item" ]; do
    echo "Expected binary missing: $item"
    exit 1
  fi
done

echo "Package validation passed."
