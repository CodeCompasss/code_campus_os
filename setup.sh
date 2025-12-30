# Fix the DNS resolver to use Google's DNS (to avoid internet problems during install)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Ensure hostname mapping is present (adjust if your hostname differs)
echo "127.0.1.1 $(hostname)" | sudo tee -a /etc/hosts


find "install" -type f -name "*.sh" -exec bash "{}" \;

bash "custom_root/shell.sh"

bash "custom_root/test.sh"

bash "custom_root/launch.sh"

bash "custom_root/gnome.sh"


# Update icon cache
sudo gtk-update-icon-cache /usr/share/icons/hicolor
# Or for GNOME-based DEs 
sudo update-desktop-database

sudo apt autoremove --purge -y
sudo apt clean           # removes downloaded .deb packages
sudo rm -rf /var/lib/apt/lists/*  # removes apt package lists

rm -rf ~/.cache/*
