#!/data/data/com.termux/files/usr/bin/bash
# install-mariadb.sh
# This script installs MariaDB on Termux, secures the installation,
# and then connects to MariaDB as the root user with the password "admin".

# Update and upgrade packages
echo "Updating and upgrading packages..."
pkg update && pkg upgrade -y

# Install MariaDB
echo "Installing MariaDB..."
pkg install mariadb -y

# Start the MariaDB daemon in the background
echo "Starting the MariaDB daemon..."
mysqld --unix-socket=off &
# Give the daemon a few seconds to initialize
sleep 5

# Install 'expect' if it is not already installed
if ! command -v expect >/dev/null 2>&1; then
    echo "Expect not found. Installing expect..."
    pkg install expect -y
fi

# Automate the secure installation using expect.
# The answers provided correspond to the following sequence:
# 1. "Enter current password for root:"           -> n
# 2. "Set root password? [Y/n]"                     -> y
# 3. "New password:"                                -> admin
# 4. "Re-enter new password:"                       -> admin
# 5. "Remove anonymous users? [Y/n]"                -> n
# 6. "Disallow root login remotely? [Y/n]"          -> n
# 7. "Remove test database and access to it? [Y/n]"   -> n
# 8. "Reload privilege tables now? [Y/n]"           -> y
echo "Securing the MariaDB installation..."
expect <<EOF
spawn mariadb-secure-installation
expect "Enter current password for root*" {send "\r"}
expect "Set root password*" {send "y\r"}
expect "New password*" {send "admin\r"}
expect "Re-enter new password*" {send "admin\r"}
expect "Remove anonymous users*" {send "n\r"}
expect "Disallow root login remotely*" {send "n\r"}
expect "Remove test database and access to it*" {send "n\r"}
expect "Reload privilege tables now*" {send "y\r"}
expect eof
EOF

# Connect to MariaDB as root using the password "admin"
echo "Connecting to MariaDB..."
mariadb --user=root -padmin
