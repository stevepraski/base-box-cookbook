#
# Cookbook Name:: prep-box-cookbook
# Recipe:: vagrant
#
# Copyright (c) 2015 Steven Praski, All Rights Reserved.

remote_file '/home/vagrant/.ssh/authorized_keys' do
  source 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
  user 'vagrant'
  group 'vagrant'
  mode '0600'
end
