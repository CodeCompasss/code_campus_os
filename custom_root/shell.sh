#!/bin/bash
# Cubic-safe customization script
# Must be run INSIDE Cubic terminal (chroot)

set -euo pipefail

# Absolute path to this script's directory (repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting Cubic customization..."
echo "Using assets from: $SCRIPT_DIR"

# -------------------------------
# 1. GNOME applications menu
# -------------------------------
echo "Installing GNOME applications menu..."
mkdir -p /etc/xdg/menus
cp "$SCRIPT_DIR/desktop/gnome-applications.menu" /etc/xdg/menus/
ls -l /etc/xdg/menus || true

# -------------------------------
# 2. GNOME desktop category directories
# -------------------------------
echo "Installing GNOME desktop category directories..."
mkdir -p /usr/share/desktop-directories
cp "$SCRIPT_DIR/desktop/category/"*.directory /usr/share/desktop-directories/
ls -l /usr/share/desktop-directories || true

# -------------------------------
# 3. Icons
# -------------------------------
echo "Installing application icons..."
mkdir -p /usr/share/icons/hicolor/48x48/apps
find "$SCRIPT_DIR/desktop/icon" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
  -exec cp {} /usr/share/icons/hicolor/48x48/apps/ \;
ls -l /usr/share/icons/hicolor/48x48/apps || true

# -------------------------------
# 4. .desktop files
# -------------------------------
echo "Installing .desktop launchers..."
mkdir -p /usr/share/applications
find "$SCRIPT_DIR/desktop/folder" -type f -name "*.desktop" -exec cp {} /usr/share/applications/ \;
chmod 644 /usr/share/applications/*.desktop || true
ls -l /usr/share/applications | tail || true

# -------------------------------
# 5. Dotfiles → /etc/skel
# -------------------------------
echo "Installing default user dotfiles..."
mkdir -p /etc/skel
cp -r "$SCRIPT_DIR/dotfile/." /etc/skel/
ls -la /etc/skel || true

# -------------------------------
# 6. GNOME Shell extensions
# -------------------------------
echo "Installing GNOME Shell extensions..."
mkdir -p /usr/share/gnome-shell/extensions
cp -r "$SCRIPT_DIR/extension/"* /usr/share/gnome-shell/extensions/
ls -l /usr/share/gnome-shell/extensions || true

# Remove Ubuntu GNOME extensions if present
for ext in ubuntu-dock@ubuntu.com ubuntu-appindicators@ubuntu.com; do
  EXT_PATH="/usr/share/gnome-shell/extensions/$ext"
  if [ -d "$EXT_PATH" ]; then
    echo "Removing $ext ..."
    rm -rf "$EXT_PATH"
  else
    echo "$ext not found, skipping."
  fi
done

# -------------------------------
# 7. Backgrounds
# -------------------------------
echo "Installing wallpapers..."
mkdir -p /usr/share/backgrounds
cp -r "$SCRIPT_DIR/image/background/"* /usr/share/backgrounds/
ls -l /usr/share/backgrounds || true

# -------------------------------
# 8. Plymouth assets
# -------------------------------
echo "Installing Plymouth assets..."
mkdir -p /usr/share/plymouth
cp "$SCRIPT_DIR/image/plymouth/ubuntu-logo.png" /usr/share/plymouth/
cp -r "$SCRIPT_DIR/image/plymouth/spinner" /usr/share/plymouth/
ls -l /usr/share/plymouth || true

echo "Customization completed successfully."
