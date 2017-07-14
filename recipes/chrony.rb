# Cookbook Name:: base-box-cookbook
# Recipe:: chrony
#
# Copyright (c) 2017 Steven Praski, refer to LICENSE

package 'chrony'

service 'chronyd' do
  supports status: true, restart: true, start: true, stop: true
  action [:enable, :start]
end
