# prep-box-cookbook

---
## Purpose:
Prepare a vagrant box based on existing Opscode vagrant base boxes, with recipes applied.

### Pain Point
When authoring cookbook recipes I found myself manually making new base vagrant boxes with finished, but dependant, recipes to save the extra converge time in test kitchen (e.g., compiling ruby from scratch, operating system updates, build tools, etc).  Unfortunately, but not unreasonably, Packer does come with a built in Vagrant builder plugin.  Fortuanely, the VirtualBox builder plugin is completely workable.

### Solution
The included scripts will apply some recipes to a base box and spit out a re-packaged vagrant box which can be imported as a new base box for development.

### Suggested Extension
This repo can easily be forked and modified to spit out a prepared AMI with your own recipes by starting with existing standard operating system AMIs, using the appropriate Packer modules.  In theory, this could be integrated into your build pipeline to avoid the VPN (Virtual Private Network) bootstrap problem, although I'd suggest you still build the capability to run against a chef server.

---
## Usage

### Pre-Requisites
 - install the chef development kit: https://downloads.chef.io/chef-dk/
 - install VirtualBox
 - install vagrant
 - install packer (https://www.packer.io/downloads.html)

### Development
```sh
bundle install
kitchen converge
```

### Repackaging a base vagrant box
```sh
bundle install
cd scripts
./repack.sh <base-box-name>
```

### Currently Supported Base Boxes
 - centos-6.5
 - ubuntu-12.04

---
## Notes and Warnings
I take no responsibility for any damage caused by my code, and I'd suggest you review this cookbook before use, as you should for all code you randomly find on the Internet. This cookbook is very much in development.

### TODO List
 - replace the aggressive cleanup scripts from bento with custom cleanup scripts
 - collapse the Packer json scripts, and workaround lack of curl on ubuntu-12.04
 - add a firewall reciepe
 - 

---
