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
# Read the actual version from the current HTML rather than checking an obsolete build.
BUILD=$(sed -n 's/.*BUILD \(0\.[0-9][0-9.]*\).*/\1/p' "$DIR/index.html" | head -n 1)
if [ -n "$BUILD" ]; then
  echo "BloomForge build $BUILD"
else
  echo "BloomForge version not found in index.html" >&2
fi
exec "$BROWSER" --app="file://$DIR/index.html" --start-maximized
