# EDITH 🕶️

*A host-based intrusion detection system (HIDS) inspired by Marvel's EDITH. Written in pure Bash.*

**E**ven **D**ead, **I**'m **T**he **H**ost — EDITH continuously monitors system logs, establishes a baseline of normal activity, and alerts you to anomalous behavior that could indicate a brute-force attack, intrusion, or other malicious activity.

![Version](https://img.shields.io/badge/version-0.9.0-blue) ![License](https://img.shields.io/badge/license-GPLv3-green)

## Features

-   **Real-time Log Analysis:** Monitors logs like `/var/log/auth.log` in real-time.
-   **Anomaly Detection:** Flags deviations from learned baselines (e.g., SSH brute-force attacks).
-   **Modular Design:** Easy to add new modules for Apache, Nginx, MySQL, etc.
-   **Configurable Alerts:** Execute custom commands on alerts (e.g., send emails, Slack messages, block IPs with `iptables`).
-   **Lightweight:** No heavy dependencies, just Bash.

## Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/YOUR_GITHUB_USERNAME/edith.git
    cd edith
    ```

2.  Run the installer script:
    ```bash
    chmod +x install.sh
    sudo ./install.sh
    ```

3.  Configure EDITH by editing the config file:
    ```bash
    sudo nano /etc/edith/edith.conf
    ```

4.  Start the daemon:
    ```bash
    sudo edith start
    ```

## Usage

```bash
# Start the daemon
sudo edith start

# Stop the daemon
sudo edith stop

# Check status
sudo edith status

# Reload configuration (on-the-fly)
sudo edith reload

# Test configuration file syntax
sudo edith test-config

# Show help
edith --help
