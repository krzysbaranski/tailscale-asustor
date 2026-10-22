#!/bin/bash
set -e

STAGING_DIR="$(pwd)/staging"
PACKAGE_DIR="$(pwd)/apkg"
PREFIX="/usr/local/tailscale"

echo "================================================"
echo "Packaging Tailscale for ASUSTOR"
echo "================================================"

if [ ! -d "${STAGING_DIR}${PREFIX}" ]; then
  echo "Error: staging directory not found at ${STAGING_DIR}${PREFIX}"
  echo "Please run build.sh first."
  exit 1
fi

find "${PACKAGE_DIR}" -mindepth 1 -maxdepth 1 -type d ! -name "CONTROL" -exec rm -rf {} \; 2>/dev/null || true

mkdir -p "${PACKAGE_DIR}/bin"
cp -a "${STAGING_DIR}${PREFIX}/bin/"* "${PACKAGE_DIR}/bin/" 2>/dev/null || true

# The official Tailscale binaries are usually self-contained and do not require
# additional system libraries in a standard ASUSTOR package layout.

echo ""
echo "================================================"
echo "Package preparation completed successfully!"
echo "================================================"
echo ""
echo "Package structure:"
echo "  bin/: $(find "${PACKAGE_DIR}/bin" \( -type f -o -type l \) 2>/dev/null | wc -l) files"
