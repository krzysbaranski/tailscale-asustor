#!/bin/bash
set -e

TS_VERSION="${TS_VERSION:-1.78.2}"
TARGET_ARCH="${TARGET_ARCH:-amd64}"
PACKAGE_NAME="tailscale"
PREFIX="/usr/local/${PACKAGE_NAME}"
BUILD_DIR="$(pwd)/build"
STAGING_DIR="$(pwd)/staging"
PACKAGE_DIR="$(pwd)/apkg"
INSTALL_PREFIX="/usr/local/AppCentral/${PACKAGE_NAME}"

case "$TARGET_ARCH" in
  x86_64|amd64)
    TS_ARCH="amd64"
    ASUSTOR_ARCH="x86-64"
    ;;
  aarch64|arm64)
    TS_ARCH="arm64"
    ASUSTOR_ARCH="armv8"
    ;;
  *)
    echo "Unsupported TARGET_ARCH: ${TARGET_ARCH}. Use amd64 or arm64."
    exit 1
    ;;
esac

mkdir -p "$BUILD_DIR"
mkdir -p "$STAGING_DIR"
cd "$BUILD_DIR"

echo "================================================"
echo "Building Tailscale ${TS_VERSION} for ASUSTOR NAS (${ASUSTOR_ARCH})"
echo "================================================"

TARBALL="tailscale_${TS_VERSION}_${TS_ARCH}.tgz"
URL="https://pkgs.tailscale.com/stable/${TARBALL}"

echo "Downloading ${URL}"
curl -fsSL "$URL" -o "$TARBALL"

echo "Extracting Tailscale binaries"
tar -xzf "$TARBALL"

BIN_DIR="${STAGING_DIR}${PREFIX}/bin"
mkdir -p "$BIN_DIR"
cp -f tailscale "$BIN_DIR/"
cp -f tailscaled "$BIN_DIR/"

# Provide a convenience symlink path similar to a standard Linux install.
mkdir -p "${STAGING_DIR}/usr/local/bin"
ln -sf "${PREFIX}/bin/tailscale" "${STAGING_DIR}/usr/local/bin/tailscale"
ln -sf "${PREFIX}/bin/tailscaled" "${STAGING_DIR}/usr/local/bin/tailscaled"

echo ""
echo "================================================"
echo "Build completed successfully."
echo "================================================"
echo ""

echo "Running package.sh to prepare ASUSTOR package..."
"$(pwd)/../package.sh"

echo ""

echo "Running validate-package.sh to validate package contents..."
"$(pwd)/../validate-package.sh" || echo "Validation completed with warnings or errors."
