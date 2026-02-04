#!/bin/bash

# This will become a proper script. I'm just getting things written down.

sudo apt update && sudo apt upgrade -y
sudo apt install samba rclone -y
sudo chown -R buddy:buddy /usr/local/local
sudo chmod -R 755 /usr/local/local
sudo chown -R buddy:buddy /usr/local/remote
sudo chmod -R 755 /usr/local/remote
echo -e "[buddy]\\ncomment = Local Share\\npath = /usr/local/local\\nread only = no\\nbrowsable = yes\\nwritable = yes\\nguest ok = no\\nvalid users = buddy\\n\\n[remote]\\ncomment = Local Share\\npath = /usr/local/remote\\nread only = no\\nbrowsable = no\\nwritable = yes\\nguest ok = no\\nvalid users = buddy" | sudo tee -a /etc/samba/smb.conf
sudo systemctl restart samba
echo "..."
echo "Enter a new SMB Password"
echo "..."
sudo smbpasswd -a buddy
