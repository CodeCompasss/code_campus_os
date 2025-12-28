#!/bin/bash

set -e

SCHEMA_DIR="/usr/share/glib-2.0/schemas"
OVERRIDE_FILE="$SCHEMA_DIR/90_extensions.gschema.override"

echo "Writing GNOME Shell extension overrides..."

sudo tee "$OVERRIDE_FILE" > /dev/null <<'EOF'
[org.gnome.shell]
enabled-extensions=[
  'add-to-desktop@tommimon.github.com',
  'arcmenu@arcmenu.com',
  'caffeine@patapon.info',
  'clipboard-indicator@tudmotu.com',
  'dash-to-panel@jderose9.github.com',
  'screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com',
  'tiling-assistant@ubuntu.com',
  'Vitals@CoreCoding.com',
  'blur-my-shell@aunetx'
]
EOF

echo "Compiling GLib schemas..."
sudo glib-compile-schemas "$SCHEMA_DIR"

echo "Done ✅"
