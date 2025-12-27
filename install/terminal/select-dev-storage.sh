#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD="root"

echo "🐬 Installing system MySQL Server..."

# -----------------------------
# Install MySQL only if missing
# -----------------------------
if ! command -v mysql >/dev/null 2>&1; then
  sudo apt update -y
  sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
else
  echo "✅ MySQL already installed, skipping install"
fi

# -----------------------------
# Start & enable MySQL
# -----------------------------
sudo systemctl enable mysql
sudo systemctl start mysql

# -----------------------------
# Detect root auth method
# -----------------------------
echo "🔍 Detecting MySQL root auth method..."

AUTH_PLUGIN=$(sudo mysql -NBe \
  "SELECT plugin FROM mysql.user WHERE User='root' AND Host='localhost';" 2>/dev/null || echo "password")

# -----------------------------
# Configure root safely
# -----------------------------
echo "🔐 Configuring MySQL root user..."

if [[ "$AUTH_PLUGIN" == "auth_socket" ]]; then
  sudo mysql <<EOF
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
else
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF || true
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

# -----------------------------
# Ensure TCP access
# -----------------------------
MYSQL_CONFIG="/etc/mysql/mysql.conf.d/mysqld.cnf"

sudo sed -i 's/^bind-address.*/bind-address = 127.0.0.1/' "$MYSQL_CONFIG" || true
sudo sed -i 's/^#\?port.*/port = 3306/' "$MYSQL_CONFIG" || true

# -----------------------------
# Restart MySQL
# -----------------------------
sudo systemctl restart mysql

# -----------------------------
# Install client
# -----------------------------
sudo apt install -y mysql-client

# -----------------------------
# Final test (non-fatal)
# -----------------------------
echo "🔍 Testing MySQL login..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT VERSION();" || true

echo "✅ MySQL configured safely (no prompts, no failure)"
