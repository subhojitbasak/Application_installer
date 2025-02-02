# Winget Installation Script - User Guide

## Overview
This PowerShell script automates the installation and upgrade of essential development and productivity tools on Windows using Winget. It checks for each application's installation status, upgrades existing applications, installs missing ones, and logs the process while adding required applications to the system PATH.

## Prerequisites
1. Ensure Winget (Windows Package Manager) is installed on your system.
   - To check, run: `winget --version`
   - If not installed, update Windows or install the latest version from the Microsoft Store.
2. Run PowerShell as an administrator.
   - Right-click on the Start menu and select **Windows PowerShell (Admin)**.

## Applications Installed/Upgraded
The script handles the following applications:

### Development Tools
- Python (Latest Version, dynamically installed)
- Java 8, Java 17, Java 21
- Pip (Python package manager)
- IntelliJ IDEA Community Edition
- Visual Studio Code
- Docker Desktop
- Oracle VirtualBox
- AWS CLI
- Git

### General Utilities
- Google Chrome
- PotPlayer
- Zoom

## Installation Steps
1. **Download the Script**
   - Save the script file as `winget_install.ps1`.
2. **Edit the installation path**
   - Edit the log path to your existing folder [Line = 19]
4. **Run the Script**
   - Open PowerShell as an administrator.
   - Run below command to execute the script `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`.
   - Navigate to the script's location using `cd <path-to-script>`.
   - Execute the script with:
     ```powershell
     .\winget_install.ps1
     ```

## Features
- **Automatic Installation & Upgrade:**
  - Checks if each application is installed.
  - If installed, upgrades to the latest version.
  - If missing, installs the latest version.
- **Logging:**
  - A fresh log file is created at `C:\winget_install_log.txt` for every run.
  - Logs contain timestamped installation status.
- **Environment Path Updates:**
  - Adds Python, Java, Git, Docker, and AWS CLI to system PATH dynamically.

## Troubleshooting
1. **Winget Command Not Found**
   - Ensure your Windows is updated to the latest version.
   - Try running `winget --version` to verify installation.
2. **Script Execution Policy Restrictions**
   - If PowerShell blocks the script, run:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force
     ```
3. **Installation Fails for Some Applications**
   - Try installing the application manually using:
     ```powershell
     winget install <app-name>
     ```
   - Check logs at `C:\winget_install_log.txt` for errors.

## Future Enhancements
- Support for additional applications.
- More robust error handling and retry mechanisms.
- GUI version for easier installation management.

## License
This script is open-source and can be modified as per requirements.

---
Feel free to report issues or suggest improvements!

