#!/bin/sh

# Best-effort cleanup for installed symlinks.
rm -f /usr/local/bin/tailscale /usr/local/bin/tailscaled 2>/dev/null || true

exit 0
