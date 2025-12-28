#!/bin/bash
# Cubic verification script
# Run INSIDE Cubic chroot after customization

set -euo pipefail

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

fail=0

check_file() {
  if [ -f "$1" ]; then
    echo -e "${GREEN}[OK]${RESET} $1"
  else
    echo -e "${RED}[MISSING]${RESET} $1"
    fail=1
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    echo -e "${GREEN}[OK]${RESET} $1"
  else
    echo -e "${RED}[MISSING]${RESET} $1"
    fail=1
  fi
}

echo "========================================"
echo " Cubic customization verification"
echo "========================================"

# 1. GNOME applications menu
check_file /etc/xdg/menus/gnome-applications.menu

# 2. GNOME applications menu
check_file  /usr/share/desktop-directories/

# 2. Icons
check_dir /usr/share/icons/hicolor/48x48/apps

# 3. .desktop files
check_dir /usr/share/applications

# 4. Default user dotfiles
check_dir /etc/skel

# 5. GNOME Shell extensions
check_dir /usr/share/gnome-shell/extensions

# Ubuntu Dock should NOT exist
if [ -d /usr/share/gnome-shell/extensions/ubuntu-dock ]; then
  echo -e "${RED}[FAIL]${RESET} ubuntu-dock still present"
  fail=1
else
  echo -e "${GREEN}[OK]${RESET} ubuntu-dock removed"
fi

# 6. Backgrounds
check_dir /usr/share/backgrounds

# 7. Plymouth assets
check_file /usr/share/plymouth/ubuntu-logo.png
check_dir /usr/share/plymouth/spinner

echo "----------------------------------------"

if [ "$fail" -eq 0 ]; then
  echo -e "${GREEN}All checks passed ✔${RESET}"
  exit 0
else
  echo -e "${RED}Some checks FAILED ✘${RESET}"
  exit 1
fi
