# prep-box-cookbook

---
## Purpose:
Apply operating system and software updates, and other TBD preparation work, on a base VM and perform final cleanup so that the VM can be re-packaged into a new base vagrant box.

---
## Benefits
Chef pre-installed
Updated packages

---
## Usage
kitchen converge


---
## Intended Side-Effects
Note that including the "vagrant" reciepe will stop the vagrant user from being able to login on reboot, since their SSH key has been reset.