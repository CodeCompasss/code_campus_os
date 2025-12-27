# Fix the DNS resolver to use Google's DNS (to avoid internet problems during install)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Ensure hostname mapping is present (adjust if your hostname differs)
echo "127.0.1.1 $(hostname)" | sudo tee -a /etc/hosts


find "install" -type f -name "*.sh" -exec bash "{}" \;

bash "custom root/shell.sh"

bash "custom root/test.sh"

# Update icon cache
sudo gtk-update-icon-cache /usr/share/icons/hicolor
# Or for GNOME-based DEs 
sudo update-desktop-database