# base-box-cookbook

---
## Purpose:
Prepare a minimum base server box.

Included recipes:
 - software updates
 - firewall with ban failure (Fail2Ban)
 - SSH server configuration
 - admin user creation (add your own public key for non-vagrant access)
 - iSCSI target service

---
## Usage

### Pre-Requisites
 - VirtualBox (https://www.virtualbox.org/wiki/Downloads)
 - Vagrant (https://www.vagrantup.com/)
 - Chef Development Kit (chefdk): https://downloads.chef.io/chef-dk/
  - the Chef Development Kit includes a number of useful dependancies (but see below)

### A note about Chef Dev Kit and other development tools
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

### Currently tested with Chef 13 on
 - centos-7.3
 - ubuntu-16.04

### iSCSI NAT Traversal
iSCSI should be used in a local area network (LAN) and is designed with this assumption.  Due to how target discovery works with iSCSI, the target host will report the IP address of the LUN device.  Since this is the target's internal IP address, not its external IP, NAT traversal is problematic:
```sh
iscsiadm -m discovery -t sendtargets -p 192.168.1.117
10.0.2.15:3260,1 iqn.2001-04.local.lan:storage01
```
If you try to login to this target, it will attempt to connect to 10.0.2.15 rather than 192.168.1.117 and fail.  Although iSCSI over a non-local network is not recommended, there is an easy workaround for NAT traversal involving SSH port forwarding (demonstated here with two vagrant boxes):
```sh
ssh -L 3260:localhost:3260 vagrant@192.168.1.117 -p 2222 -N &
iscsiadm -m discovery -t sendtargets -p localhost:3260
[::1]:3260,1 iqn.2001-04.local.lan:storage01
iscsiadm -m node --login -p localhost:3260
Logging in to [iface: default, target: iqn.2001-04.local.lan:storage01, portal: ::1,3260] (multiple)
Login to [iface: default, target: iqn.2001-04.local.lan:storage01, portal: ::1,3260] successful.
```
Note that I've glossed over a few details, so your experience may vary.

### Packer
When re-packing, allow the vagrant user SSH access via override in a wrapper recipe:
```
node.override['base-box']['permit_password_auth'] = true
node.override['authorization']['sudo']['users'] = [node['base-box']['admin_user']].push('vagrant')
```
Or with JSON alterations:
```
"json": {
  "authorization": {
    "sudo": {
      "users": ["sysop", "vagrant"]
    }
  },
  "base-box": {
    "permit_password_auth": true
  }
}

```

---
## Other

### Credit and Thanks
 - partially inspired by
   - https://github.com/teohm/appbox-cookbook
 - thanks to opscode

### Licensing
The MIT License (MIT)

Copyright (c) 2015 - 2017 Steven Praski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

