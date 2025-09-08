

#!/bin/bash
# EDITH Installer Script

echo "[*] Installing EDITH (Even Dead, I'm The Host)..."
echo "[*] A host-based intrusion detection system"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "[!] Please run as root or with sudo"
    exit 1
fi

# Copy the main script to /usr/local/bin
echo "[*] Installing main executable..."
cp src/edith /usr/local/bin/
chmod +x /usr/local/bin/edith

# Create the configuration directory
echo "[*] Creating configuration directory..."
mkdir -p /etc/edith/modules

# Copy the default configuration
echo "[*] Installing default configuration..."
cp configs/edith.conf /etc/edith/

# Copy the modules
echo "[*] Installing monitoring modules..."
cp src/modules/ssh.sh /etc/edith/modules/

# Create log file
echo "[*] Creating log file..."
touch /var/log/edith.log
chmod 644 /var/log/edith.log

echo "[+] Installation complete."
echo "[!] Please edit the configuration file: /etc/edith/edith.conf"
echo "[*] Review the alert command (ALERT_CMD) and thresholds for your environment."
echo "[*] Then, you can start EDITH with: sudo edith start"
echo "[*] Check status with: sudo edith status"
