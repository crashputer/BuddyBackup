# BuddyBackup

*** This script is currently incomplete. ***

[What is BuddyBackup?]

BuddyBackup is a simple, secure two-way non-cloud offsite backup system. This project aims to automate the process of building a secure offsite two-way backup solution that does NOT rely on any cloud services, subscriptions, or any other external influences. This project is intended to run on two PCs with similar data storage capacities in separate physical locations. The two-way aspect allows users at both location to store files which will be securely backed up to the other PC. Files sent to the remote location for backup will be encrypted. BackupBuddy is a tool to be used as part of the standard 3-2-1 data backup process.

[Why?]

Your data is YOURS, and it deserves to be protected. Regardless of your opinion of various backup companies, you should have the option to safely back your data up without it leaving your control.

[What is needed?]

Two computers and as much storage space as you would like to throw at the project. Matched computers and matched storage is the most ideal setup, but any PC (and probably things like a Raspberry Pi) will work. Obviously, you need an internet connection. 

A static IP address, domain, or dynamic DNS address will be necessary to maintain constant reliable connections. Free services such as DuckDNS are available.

Network configuration 

[What is covered in this installation?]

- Update a base installation of Debian
- Install and configure Samba for both the local and remote folders
- Configure the connection to the remote server
- Generate settings for automatic backup.

[What is NOT covered?]

- IP address, domain, dynamic DNS configuration
- Local or remote router/firewall configuration
- Local machine network configuration (IP, subnet, gateway configurations)

[Example Use Cases]

- Friends A and B wish to back up their personal files. Each friend keeps a computer running BackupBuddy at their house.
- Small Business owner wishes to back up their data from their office to their house. Why not also have the ability to back up their home files to their office? 

[What does BuddyBackup NOT do?]

- File revisions. This project does not have any change logs or accidental file deletion protection.
- Cryptolocker protection, because there are no file revisions/version history files being generated.
