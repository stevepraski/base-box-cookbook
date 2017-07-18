default['base-box']['update']['upgrade'] = true
default['base-box']['root_ssh_login_enabled'] = false
default['base-box']['permit_password_auth'] = !default['etc']['passwd']['vagrant'].nil? # support for multi-stage packer scripts
default['base-box']['admin_user'] = 'sysop'
default['base-box']['admin_auth_keys'] = [] # public ssh keys of admin users

# Login Privilages
sudo_users = [default['base-box']['admin_user']]
sudo_users.push('vagrant') unless default['etc']['passwd']['vagrant'].nil?
default['authorization']['sudo']['users'] = sudo_users
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
