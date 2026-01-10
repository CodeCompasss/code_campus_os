#!/bin/bash
set -e

# ==============================
# Plymouth cleanup & custom theme
# ==============================

PLYMOUTH_DIR="/usr/share/plymouth"
THEMES_DIR="$PLYMOUTH_DIR/themes"

# 1️⃣ Backup existing default.plymouth
if [ -e "$THEMES_DIR/default.plymouth" ]; then
    mv "$THEMES_DIR/default.plymouth" "$THEMES_DIR/default.plymouth.bak"
    echo "[+] Backed up old default.plymouth"
fi

# 2️⃣ Remove Ubuntu/OEM logos
rm -f "$PLYMOUTH_DIR/ubuntu-logo.png"
rm -rf "$THEMES_DIR/ubuntu-text"
rm -rf "$THEMES_DIR/bgrt"
echo "[+] Removed Ubuntu and OEM logos"

# 3️⃣ Create custom text.plymouth theme if it doesn't exist
CUSTOM_THEME_DIR="$THEMES_DIR/text"
mkdir -p "$CUSTOM_THEME_DIR"

cat > "$CUSTOM_THEME_DIR/text.plymouth" << 'EOF'
[Plymouth Theme]
Name=CodeCampusOS Text
Description=Text mode theme with custom title
ModuleName=script

[script]
title=CodeCampusOS 24.04
black=0x2c001e
white=0xffffff
brown=0xff4012
blue=0x988592
EOF

echo "[+] Created custom text-only Plymouth theme"

# 4️⃣ Set it as default
ln -sf "$CUSTOM_THEME_DIR/text.plymouth" "$THEMES_DIR/default.plymouth"
echo "[+] Switched default.plymouth to custom text theme"

# 5️⃣ Update initramfs
update-initramfs -u
echo "[+] Regenerated initramfs"

echo "[✅] Plymouth theme updated! Boot will now show text-only with custom title."
