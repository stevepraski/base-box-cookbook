default['base-box']['update']['upgrade'] = true
default['base-box']['firewall']['tcp_ports'] = [] # note SSH is always included

default['base-box']['root_ssh_login_enabled'] = false
default['base-box']['admin_user'] = 'sysop'
default['base-box']['admin_auth_keys'] = [] # public ssh keys of admin users

# Login Privilages
sudo_users = [ default['base-box']['admin_user'] ]
sudo_users.push('vagrant') unless default['etc']['passwd']['vagrant'].nil?
default['authorization']['sudo']['users'] = sudo_users
default['authorization']['sudo']['passwordless'] = true
