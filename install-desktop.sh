#!/bin/sh
# Install a BloomForge desktop shortcut on Raspberry Pi OS / XDG desktops.
# Safe to rerun. No root permissions needed.
set -eu
APPDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
HOME_DIR=${HOME:?HOME must be set}
APPS="$HOME_DIR/.local/share/applications"
ICONS="$HOME_DIR/.local/share/icons"
DESKTOP="$HOME_DIR/Desktop"
mkdir -p "$APPS" "$ICONS"
ICON="$APPDIR/bloomforge-icon.svg"
# Prefer the artwork supplied by the user, if downloaded on this Pi.
for candidate in "$HOME_DIR/Downloads/BloomForge-icon.png" \
 "$HOME_DIR/Downloads/a_vibrant_glossy_neon_glow_high_contrast_app_ic.png" \
 "$APPDIR/BloomForge-icon.png"; do
 if [ -f "$candidate" ]; then
  cp "$candidate" "$ICONS/bloomforge.png"
  ICON="$ICONS/bloomforge.png"
  break
 fi
done
# Avoid interpreting percent characters as .desktop field-code markers.
case "$APPDIR" in *%*|*'
'*) echo "Unsupported percent/newline in app path: $APPDIR" >&2; exit 1;; esac
ENTRY="$APPS/bloomforge.desktop"
cat > "$ENTRY" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=BloomForge
Comment=Offline precision SVG and laser-cutting workbench
Exec=/bin/sh "$APPDIR/launch-pi.sh"
Path=$APPDIR
Icon=$ICON
Terminal=false
Categories=Graphics;Engineering;
StartupNotify=true
EOF
chmod 644 "$ENTRY"
if [ -d "$DESKTOP" ]; then
 cp "$ENTRY" "$DESKTOP/BloomForge.desktop"
 chmod +x "$DESKTOP/BloomForge.desktop"
 echo "Desktop shortcut installed: $DESKTOP/BloomForge.desktop"
 echo "If Raspberry Pi OS asks whether to trust or execute the launcher, choose Execute or Allow Launching."
else
 echo "Desktop directory not found; app menu shortcut installed only."
fi
echo "Menu shortcut installed: $ENTRY"
echo "Icon: $ICON"
echo "You can launch BloomForge from the desktop or application menu."
