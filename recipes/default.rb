#
# Cookbook Name:: prep-box-cookbook
# Recipe:: default
#
# Copyright (c) 2015 Steven Praski, refer to LICENSE

include_recipe 'prep-box-cookbook::update'
include_recipe 'prep-box-cookbook::firewall'
include_recipe 'prep-box-cookbook::admins'
