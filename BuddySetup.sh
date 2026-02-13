#!/bin/bash

set -e

# Ensure running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Either switch to root or use sudo."
    exit 1
fi

# Start with a fully updated system and install all dependencies
apt update
apt upgrade -y
apt install samba rclone openssh-server -y

# Check if reboot is necessary before continuing

if [[ -f /var/run/reboot-required ]]; then
    echo
    echo "--------------------------------------------------------------------"
    echo "Reboot required. Please reboot the computer then restart this script."
    echo "--------------------------------------------------------------------"
    exit 1
fi

echo "No reboot required. Continuing..."

#Default Variables

DEFAULTUSER="buddy"
DEFAULTLOCALSHARENAME="buddy"
DEFAULTLOCALDIRECTORY="/usr/local/local"
DEFAULTREMOTESHARENAME="remote"
DEFAULTREMOTEDIRECTORY="/usr/local/remote"

# User Inputs

read -e -p "Enter the SMB share username. (Default: $DEFAULTUSER): " -i "$DEFAULTUSER" USERNAME
read -e -p "Enter a password for the SMB shares." SMBPASSWORD
read -e -p "Enter the LOCAL share name. (Default: $DEFAULTLOCALSHARENAME): " -i "$DEFAULTLOCALSHARENAME" LOCALSHARENAME 
read -e -p "Enter the LOCAL share directory. (Default: $DEFAULTLOCALDIRECTORY): " -i "$DEFAULTLOCALDIRECTORY" LOCALDIRECTORY
read -e -p "Enter the REMOTE share name. (Default: $DEFAULTREMOTESHARENAME): " -i "$DEFAULTLOCALSHARENAME" REMOTESHARENAME
read -e -p "Enter the remote share directory. (Default: $DEFAULTREMOTEDIRECTORY): " -i "$DEFAULTREMOTEDIRECTORY" REMOTEDIRECTORY

# Create user accounts and folders
adduser --quiet --disabled-password --gecos "" "$USERNAME"
echo -e "$SMBPASSWD\n$SMBPASSWORD" | smbpasswd -s "$USERNAME"
mkdir -p $LOCALDIRECTORY
mkdir -p $REMOTEDIRECTORY
chown -R $USERNAME:$USERNAME $LOCALDIRECTORY
chown -R $USERNAME:$USERNAME $REMOTEDIRECTORY
chmod -R 755 $LOCALDIRECTORY
chmod -R 755 $REMOTEDIRECTORY

#Add shares to /etc/samba/smb.conf

echo -e "\\n\\n[$LOCALSHARENAME]\\ncomment = Local Share\\npath = $LOCALSHAREDIRECTORY\\nread only = no\\nbrowsable = yes\\nwritable = yes\\nguest ok = no\\nvalid users = $USERNAME\\n\\n[$REMOTESHARENAME]\\ncomment = Remote Share\\npath = $REMOTESHAREDIRECTORY\\nread only = no\\nbrowsable = no\\nwritable = yes\\nguest ok = no\\nvalid users = $USERNAME" >> /etc/samba/smb.conf
systemctl restart samba
