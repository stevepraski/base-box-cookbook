default['prep-box']['update']['upgrade'] = true
default['prep-box']['firewall']['tcp_ports'] = [] # note SSH is always included

default['prep-box']['root_ssh_login_enabled'] = false
default['prep-box']['admin_user'] = 'sysop'
default['prep-box']['admin_auth_keys'] = [] # public ssh keys of admin users

# Login Privilages
sudo_users = [ default['prep-box']['admin_user'] ]
sudo_users.push('vagrant') unless default['etc']['passwd']['vagrant'].nil?
default['authorization']['sudo']['users'] = sudo_users
default['authorization']['sudo']['passwordless'] = true
