#
# Cookbook Name:: base-box-cookbook
# Recipe:: default
#
# Copyright (c) 2015 Steven Praski, refer to LICENSE

include_recipe 'base-box-cookbook::update'
include_recipe 'base-box-cookbook::firewall'
include_recipe 'base-box-cookbook::admins'
include_recipe 'base-box-cookbook::sshd'
