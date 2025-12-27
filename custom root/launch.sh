apps=(
  "codecompass.desktop"
  "code_compus_userguide.desktop"
  "cse-starter-guide.desktop"
  "RayyanCodingSchool.desktop"
)

desktop_dirs=(
  "/var/lib/flatpak/exports/share/applications"
  "/usr/share/applications"
  "/usr/local/share/applications"
  "$HOME/.local/share/applications"
)

DESKTOP="$HOME/Desktop"
mkdir -p "$DESKTOP"

for app in "${apps[@]}"; do
  found=false
  for dir in "${desktop_dirs[@]}"; do
    if [ -f "$dir/$app" ]; then
      echo "▶ Processing $app"

      cp -f "$dir/$app" "$DESKTOP/$app"
      chmod +x "$DESKTOP/$app"
      gio set "$DESKTOP/$app" metadata::trusted true

      found=true
      break
    fi
  done

  if [ "$found" = false ]; then
    echo "⚠ $app not found in application directories"
  fi
done

echo "✅ Done. If icons don’t appear, enable Desktop Icons in GNOME."
