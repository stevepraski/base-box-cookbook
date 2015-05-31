#
# Cookbook Name:: prep-box-cookbook
# Recipe:: admins
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 Steven Praski
# 

include_recipe 'sudo'

admin = node['prep-box']['admin_user']

group admin do
  action :create
end

user admin do
  gid admin
  home File.join('/home', admin)
  shell '/bin/bash'
  comment 'System Administrator'
  action :create
end

# this is for AWS, and other base images that enable root access
file '/root/.ssh/authorized_keys' do
  action :delete
  not_if { node['prep-box']['root_ssh_login_enabled'] }
end

node['prep-box']['admin_auth_keys']
ssh_dir = File.join('/home', admin, '.ssh')

directory ssh_dir do
  owner admin
  group admin
  mode '0700'
  recursive true # workaround for ubuntu 12.04 not creating home directory on user creation
end

template File.join(ssh_dir, 'authorized_keys') do
  source 'authorized_keys.erb'
  owner admin
  group admin
  mode '0400'
  variables ssh_keys: node['prep-box']['admin_auth_keys']
end
