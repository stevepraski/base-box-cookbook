# Cookbook Name:: base-box-cookbook
# Recipe:: chrony
#
# Copyright (c) 2017 Steven Praski, refer to LICENSE

package 'chrony'

service 'chronyd' do
  supports status: true, restart: true, start: true, stop: true
  action [:enable, :start] if node['platform_family'] == 'rhel'
end

execute 'ubuntu-systemd-workaround' do
  command '/bin/systemctl enable chrony && /bin/systemctl start chrony'
  user 'root'
  group 'root'
  only_if { node['platform_family'] == 'debian' }
end
