# Termux MariaDB Installer

This project provides a Bash script that automates the installation and secure configuration of MariaDB on Termux.

## Features

- Updates and upgrades Termux packages.
- Installs MariaDB and its dependencies.
- Uses Expect to automate the `mariadb-secure-installation` process.
- Connects to MariaDB as the root user with the password `admin`.

## Prerequisites

- Termux installed on your Android device.
- An active internet connection.

## Installation and Usage

Clone the repository and run the installer script:

```bash
git clone https://github.com/AaronClaude/mariadb-termux-installation.git
cd mariadb-termux-installation
chmod +x install-mariadb.sh
./install-mariadb.sh
```

## Notes

- The script will install MariaDB and configure it with a secure password.
- The root password is set to `admin`.
