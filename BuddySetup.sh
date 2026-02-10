#!/bin/bash

# SUDO check
if [[ $UID != 0 ]]; then
    echo "This script must be run with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Start with a fully updated system
apt update
apt upgrade -y

# Check if reboot is necessary before continuing
if [ -f /var/run/reboot-required ]; then
    echo "--------------------------------------------------------------------"
    echo "Reboot required. Please reboot the computer then restart the script."
    echo "--------------------------------------------------------------------"
    exit 1
else
    echo "No reboot needed. Continuing..."
    exit 0
fi

# Install all necessary packages
apt install samba rclone openssh-server -y

# Variables
LOCAL_DIRECTORY="/usr/local/local"
REMOTE_DIRECTORY="/usr/local/remote"
USERNAME="buddy"

#User Inputs
read -e -p "Enter the SMB share username. (Default: $USERNAME) -i "$USERNAME" USERNAME

# This will become a proper script. I'm just getting things written down.

chown -R buddy:buddy /usr/local/local
chmod -R 755 /usr/local/local
chown -R buddy:buddy /usr/local/remote
chmod -R 755 /usr/local/remote
echo -e "[buddy]\\ncomment = Local Share\\npath = /usr/local/local\\nread only = no\\nbrowsable = yes\\nwritable = yes\\nguest ok = no\\nvalid users = buddy\\n\\n[remote]\\ncomment = Local Share\\npath = /usr/local/remote\\nread only = no\\nbrowsable = no\\nwritable = yes\\nguest ok = no\\nvalid users = buddy" | sudo tee -a /etc/samba/smb.conf
systemctl restart samba
echo "..."
echo "Enter a new SMB Password"
echo "..."
smbpasswd -a buddy
