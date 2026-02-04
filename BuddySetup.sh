#!/bin/bash

# This will be cleaned up, labeled, and become a proper script. I'm just getting things written down.

sudo apt update && apt upgrade -y
sudo apt install samba rclone -y
sudo chown -R buddy:buddy /usr/local/local
sudo chmod -R 755 /usr/local/local
sudo chown -R buddy:buddy /usr/local/remote
sudo chmod -R 755 /usr/local/remote
sudo echo -e "[buddy]\\ncomment = Local Share\\npath = /usr/local/local\\nread only = no\\nbrowsable = yes\\nwritable = yes\\nguest ok = no\\nvalid users = buddy\\n\\n[remote]\\ncomment = Local Share\\npath = /usr/local/remote\\nread only = no\\nbrowsable = no\\nwritable = yes\\nguest ok = no\\nvalid users = buddy" >> /etc/samba/smb.conf
