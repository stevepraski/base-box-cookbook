name 'base-box-cookbook'
maintainer 'Steven Praski'
maintainer_email 'stevepraski@users.noreply.github.com'
license 'MIT'
description 'Basic server preparation cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.6'
chef_version '>= 13.2.20' if respond_to?(:chef_version)
supports 'centos'

depends 'simple_iptables'
depends 'sudo'
