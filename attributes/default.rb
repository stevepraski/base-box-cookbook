# System Maintenance
default['base-box']['update']['upgrade'] = true
default['apt']['cacher_client']['cacher_server'] = {
  host: '192.168.1.40',
  port: '3142',
  proxy_ssl: true,
  cache_bypass: {}
}

# User Management and Secure Shell Privilages
default['base-box']['root_ssh_login_enabled'] = false
default['base-box']['permit_password_auth'] = false # true for support for multi-stage packer scripts
default['base-box']['admin_user'] = 'sysop'
default['base-box']['admin_auth_keys'] = [] # public ssh keys of admin users
default['authorization']['sudo']['users'] = [default['base-box']['admin_user']]
default['authorization']['sudo']['passwordless'] = true

# Firewall
default['iptables']['rules']['loopback'] = '-A INPUT -i lo -j ACCEPT'
default['iptables']['rules']['established'] = '-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT'
default['iptables']['rules']['ssh_22'] = '-A INPUT -p tcp --dport 22 -j ACCEPT'
default['iptables']['rules']['policy'] = [
  '-P INPUT DROP',
  '-P FORWARD DROP',
  '-P OUTPUT ACCEPT'
]

# iSCSI target service
default['base-box']['iscsi']['drive_path'] = '/dev/sdb'
default['base-box']['iscsi']['max_sleep'] = 3
default['base-box']['iscsi']['iqn'] = 'iqn.2001-04.local.lan:storage01'
default['base-box']['iscsi']['max_connections'] = 1 # CAREFUL! Filesystem must support read-write concurrency
default['base-box']['iscsi']['username'] = 'joe'
default['base-box']['iscsi']['password'] = nil # nil disables CHAP access control, otherwise enabled
