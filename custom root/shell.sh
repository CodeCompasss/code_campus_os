#!/bin/bash
# shell.sh
# Cubic ISO customizer script: install desktop, icons, extensions, backgrounds, and release files
# with temporary user access to $CUSTOM_ROOT

set -e  # Exit on any error
set -u  # Treat unset variables as error

CUSTOM_ROOT="/home/shadilrayyan/cubic/test7/custom-root"
USER="shadilrayyan"

echo "Starting custom setup inside $CUSTOM_ROOT..."

# Temporary: give full access to user for custom-root
echo "Granting temporary permissions to $USER on $CUSTOM_ROOT..."
sudo setfacl -R -m u:$USER:rwx "$CUSTOM_ROOT"

# 1. Replace GNOME applications menu
echo "Copying GNOME applications menu..."
sudo mkdir -p "$CUSTOM_ROOT/etc/xdg/menus"
sudo cp -r desktop/gnome-applications.menu "$CUSTOM_ROOT/etc/xdg/menus/"

# 2. Copy icons (*.png, *.jpg, *.jpeg)
echo "Copying icons..."
sudo mkdir -p "$CUSTOM_ROOT/usr/share/icons/hicolor/48x48/apps"
sudo find desktop/icon -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
    -exec cp {} "$CUSTOM_ROOT/usr/share/icons/hicolor/48x48/apps/" \;

# 3. Copy all .desktop files
echo "Copying .desktop files..."
sudo mkdir -p "$CUSTOM_ROOT/usr/share/applications"
sudo find desktop/folder -type f -name "*.desktop" -exec cp {} "$CUSTOM_ROOT/usr/share/applications/" \;
sudo find dotfile/Desktop -type f -name "*.desktop" -exec cp {} "$CUSTOM_ROOT/usr/share/applications/" \;

# 4. Copy dotfiles to /etc/skel
echo "Copying dotfiles..."
sudo mkdir -p "$CUSTOM_ROOT/etc/skel"
sudo cp -r dotfile/* "$CUSTOM_ROOT/etc/skel/"

# 5. Copy GNOME shell extensions
echo "Copying GNOME shell extensions..."
sudo mkdir -p "$CUSTOM_ROOT/usr/share/gnome-shell/extensions"
sudo cp -r extension/* "$CUSTOM_ROOT/usr/share/gnome-shell/extensions/"

# Remove Ubuntu Dock if present
if [ -d "$CUSTOM_ROOT/usr/share/gnome-shell/extensions/ubuntu-dock" ]; then
    echo "Removing Ubuntu Dock extension..."
    sudo rm -rf "$CUSTOM_ROOT/usr/share/gnome-shell/extensions/ubuntu-dock"
fi


nano /usr/share/glib-2.0/schemas/90_extensions.gschema.override
[org.gnome.shell]
enabled-extensions=['add-to-desktop@tommimon.github.com','arcmenu@arcmenu.com','caffeine@patapon.info','clipboard-indicator@tudmotu.com','dash-to-panel@jderose9.github.com','screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com','tiling-assistant@ubuntu.com','Vitals@CoreCoding.com']

glib-compile-schemas /usr/share/glib-2.0/schemas/


# 6. Copy background images
echo "Copying background images..."
sudo mkdir -p "$CUSTOM_ROOT/usr/share/backgrounds"
sudo cp -r image/background/* "$CUSTOM_ROOT/usr/share/backgrounds/"

# 7. Copy Plymouth themes
echo "Copying Plymouth themes..."
sudo mkdir -p "$CUSTOM_ROOT/usr/share/plymouth"
sudo cp image/plymouth/ubuntu-logo.png "$CUSTOM_ROOT/usr/share/plymouth/"
sudo cp -r image/plymouth/spinner "$CUSTOM_ROOT/usr/share/plymouth/"


# # 8. Replace release files
# echo "Replacing release files..."
# sudo cp release/lsb-release "$CUSTOM_ROOT/etc/lsb-release"
# sudo cp release/os-release "$CUSTOM_ROOT/etc/os-release"

# Revert temporary ACL and set root as owner only
echo "Reverting permissions on $CUSTOM_ROOT to root only..."
sudo setfacl -R -b "$CUSTOM_ROOT"
sudo chown -R root:root "$CUSTOM_ROOT"

echo "Custom setup completed successfully inside $CUSTOM_ROOT!"
