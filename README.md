# prep-box-cookbook

---
## Purpose:
Prepare a vagrant box based on existing Opscode vagrant base boxes, with recipes applied.

### Pain Point
When authoring cookbook recipes I found myself manually making new base vagrant boxes with applied finished recipes to save the extra converge time in test kitchen (e.g., compiling ruby from scratch, operating system updates, build tools, etc).  Unfortunately, but not unreasonably, Packer does not come with a built in Vagrant builder plugin.  Fortuanely, the VirtualBox builder plugin is completely workable.

### Solution
The included scripts will apply some recipes to a base box and spit out a re-packaged vagrant box which can be imported as a new base box for development.

### Suggested Extension
This repo can easily be forked and modified to spit out a prepared AMI with your own recipes by starting with existing standard operating system AMIs, using the appropriate Packer modules.  In theory, this could be integrated into your build pipeline to avoid the VPN (Virtual Private Network) bootstrap problem, although I'd suggest you still build the capability to run against a chef server.

---
## Usage

### Pre-Requisites
 - VirtualBox (https://www.virtualbox.org/wiki/Downloads)
 - Vagrant (https://www.vagrantup.com/)
 - Chef Development Kit (chefdk): https://downloads.chef.io/chef-dk/
  - the Chef Development Kit includes a number of useful dependancies (but see below)
 - Packer (https://www.packer.io/downloads.html)

### PATHing Fun
 - DO NOT install rbenv, it will directly conflict with chefdk
   - https://github.com/chef/chef-dk/issues/16
 - personally, on Linux I've highly restricted the chefdk path, since I want to be able to do non-chef ruby development, although this is subtly imperfect, and possibly breaking:

```
export PATH="$/opt/chefdk/bin:$PATH"
export PATH=$PATH:~/packer/
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

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

### Using a repacked vagrant box
 - Add the box

```sh
vagrant box add <name-for-box> <prepped.box>
```
- Example:

```sh
vagrant box add centos-6.5-prepped opscode-centos-6.5-prepped.box
```
 - create a ".kitchen.local.yml" and add section such as:

```yaml
platforms:
  - name: ubuntu-12.04
    driver:
      box: ubuntu-12.04-prepped
  - name: centos-6.5
    driver:
      box: centos-6.5-prepped
```

### Currently Supported Base Boxes
 - centos-6.5
 - ubuntu-12.04

---
## Notes and Warnings
I take no responsibility for any damage caused by my code, and I'd suggest you review this cookbook before use, as you should for all code you randomly find on the Internet. This cookbook is very much in development.


### Known Issues
 -  Berkshelf cookbook resolution takes entirely too long


### TODO List
 - replace the aggressive cleanup scripts from bento with custom cleanup scripts
 - collapse the Packer json scripts, and workaround lack of curl on ubuntu-12.04
 - add a firewall recipe
 - zero-out space prior to packing
 - 

### Credit and Thanks
 - partially inspired by https://github.com/teohm/appbox-cookbook

---
