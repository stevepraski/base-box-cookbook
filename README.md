# base-box-cookbook

---
## Purpose:
Prepare a minimum base server box.

Included recipes:
 - software updates
 - firewall with ban failure (Fail2Ban)
 - SSH server configuration
 - admin user creation (add your own public key for non-vagrant access)

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

---
## Other

### Credit and Thanks
 - partially inspired by
   - https://github.com/teohm/appbox-cookbook
 - thanks to opscode

### Licensing
The MIT License (MIT)

Copyright (c) 2015 Steven Praski

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

