#
# Cookbook Name:: prep-box-cookbook
# Recipe:: sshd
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 Steven Praski
# 

root_group = node['platform_family'] == 'freebsd' ? 'wheel' : 'root'

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  mode '0400'
  owner 'root'
  group root_group
  notifies :restart, 'service[sshd]'
  variables permit_root_login: node['prep-box']['root_ssh_login_enabled'] ? 'yes' : 'no'
end

service_name = node['platform_family'] == 'debian' ? 'ssh' : 'sshd'

service 'sshd' do
  service_name service_name
  supports [:restart]
  action [:enable, :start]
end
