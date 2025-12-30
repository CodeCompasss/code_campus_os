#!/usr/bin/env bash
set -e

SCHEMA_DIR="/usr/share/glib-2.0/schemas"
OVERRIDE_FILE="$SCHEMA_DIR/90_extensions.gschema.override"

cat > "$OVERRIDE_FILE" <<'EOF'
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

# Compile schemas (required inside ISO)
glib-compile-schemas "$SCHEMA_DIR" || true
