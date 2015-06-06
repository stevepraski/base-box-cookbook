#
# Cookbook Name:: base-box-cookbook
# Recipe:: firewall
#
# Copyright (c) 2015 Steven Praski, refer to LICENSE

include_recipe 'simple_iptables::default'

# Drop unless allowed
simple_iptables_policy 'INPUT' do
  policy 'DROP'
end

# Allow loopback
simple_iptables_rule 'system' do
  rule '--in-interface lo'
  jump 'ACCEPT'
end

# Allow SSH (kept separate for later adding FIXME: rate limiting)
simple_iptables_rule 'ssh' do
  rule '--proto tcp --dport 22'
  jump 'ACCEPT'
end

# Allow Service Ports (if any)
simple_iptables_rule 'allowed_ports' do
  node['base-box']['firewall']['tcp_ports'].each do |port|
    rule "--proto tcp --dport #{port}"
  end
  jump 'ACCEPT'
  only_if { node['base-box']['firewall']['tcp_ports'].any? }
end

# Allow established
simple_iptables_rule 'established' do
  direction 'INPUT'
  rule '-m conntrack --ctstate ESTABLISHED,RELATED'
  jump 'ACCEPT'
end
