# tailscale-asustor

ASUSTOR NAS build for Tailscale VPN client.

This repository packages the official Tailscale binaries into an ASUSTOR `.apk` layout using the same structure as the existing ASUSTOR packaging pattern.

## Build

```bash
chmod +x build.sh package.sh validate-package.sh
./build.sh
```

The build process:
1. Downloads the official Tailscale Linux release tarball.
2. Extracts the `tailscale` and `tailscaled` binaries into a staging directory.
3. Prepares the ASUSTOR package layout under `apkg/`.
4. Validates the expected files.

## Package layout

```text
.
├── apkg/
│   └── CONTROL/
│       ├── changelog.txt
│       ├── config.json
│       ├── description.txt
│       ├── post-install.sh
│       ├── post-uninstall.sh
│       ├── pre-install.sh
│       ├── pre-uninstall.sh
│       └── start-stop.sh
├── build.sh
├── package.sh
├── validate-package.sh
├── README.md
└── .gitignore
```

## Usage

After installation on the NAS:

```bash
/usr/local/bin/tailscale up
```

or, if the package is installed under the ASUSTOR AppCentral layout:

```bash
/usr/local/AppCentral/tailscale/bin/tailscale up
```

## Notes

- Tailscale builds are architecture-specific. Set `TARGET_ARCH=amd64` or `TARGET_ARCH=arm64` before running `build.sh` if needed.
- This package does not silently enable Tailscale; it only installs the daemon and client binaries.
- The user still needs to authenticate the NAS with `tailscale up`.
