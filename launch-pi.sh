#!/bin/sh
# BloomForge: Raspberry Pi desktop launcher (Chromium app window).
set -eu
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if command -v chromium >/dev/null 2>&1; then
  BROWSER=chromium
elif command -v chromium-browser >/dev/null 2>&1; then
  BROWSER=chromium-browser
else
  echo "Chromium was not found. Install Chromium or open index.html in your Pi browser." >&2
  exit 1
fi
echo "BloomForge launcher: $DIR/index.html"
if grep -q 'BUILD 0.1.3' "$DIR/index.html"; then
  echo "BloomForge build 0.1.3 found (zoom diagnostic)."
else
  echo "WARNING: local index.html does not contain build 0.1.3; run git pull in this directory." >&2
fi
exec "$BROWSER" --app="file://$DIR/index.html?build=0.1.3" --start-maximized
