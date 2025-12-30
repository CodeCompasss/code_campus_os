#!/usr/bin/env bash
set -e

SCHEMA_DIR="/usr/share/glib-2.0/schemas"
OVERRIDE_FILE="$SCHEMA_DIR/99-extensions.gschema.override"

sudo tee "$OVERRIDE_FILE" > /dev/null <<'EOF'
[org.gnome.shell]
disable-user-extensions=false
enabled-extensions=['add-to-desktop@tommimon.github.com','arcmenu@arcmenu.com','caffeine@patapon.info','clipboard-indicator@tudmotu.com','dash-to-panel@jderose9.github.com','screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com','tiling-assistant@ubuntu.com','Vitals@CoreCoding.com','blur-my-shell@aunetx']
EOF

sudo glib-compile-schemas "$SCHEMA_DIR"
