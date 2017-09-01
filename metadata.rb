name 'base-box-cookbook'
maintainer 'Steven Praski'
maintainer_email 'stevepraski@users.noreply.github.com'
license 'MIT'
description 'Basic server preparation cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.8'
chef_version '>= 13.2.20' if respond_to?(:chef_version)
supports 'centos', '= 7.3'
supports 'ubuntu', '= 16.04'

depends 'iptables', '~> 4.2.0'
depends 'fail2ban', '~> 4.0.1'
depends 'sudo'
depends 'build-essential'
