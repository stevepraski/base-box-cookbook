#
# Cookbook:: base-box-cookbook
# Recipe:: iscsi
#
# Copyright (c) 2017 Steven Praski, refer to LICENSE

# not for centos yet,...
raise "Unsupported Platform Family: #{node['platform_family']}" unless node['platform_family'] == 'debian'

# note: current kernel should be the same as updated or latest kernel
#  (i.e., linux-headers-generic), but not necessarily
package "linux-headers-#{node['kernel']['release']}"

package 'iscsitarget'
# FIXME: iscsitarget-dkms needs to be rebuilt (via --reinstall) on every kernel update,
#  also package installation will silently fail with missing kernel headers
package 'iscsitarget-dkms'

template '/etc/default/iscsitarget' do
  source 'iscsitarget.erb'
  mode '0400'
  owner 'root'
  group 'root'
  variables max_sleep: node['base-box']['iscsi']['max_sleep']
  notifies :restart, 'service[iscsitarget]', :delayed
end

template '/etc/iet/ietd.conf' do
  source 'ietd_conf.erb'
  mode '0400'
  owner 'root'
  group 'root'
  variables iqn: node['base-box']['iscsi']['iqn'],
            path: node['base-box']['iscsi']['drive_path'],
            conns: node['base-box']['iscsi']['max_connections'],
            user: node['base-box']['iscsi']['username'],
            password: node['base-box']['iscsi']['password']
  notifies :restart, 'service[iscsitarget]', :delayed
end

service 'iscsitarget' do
  supports status: true, restart: true, start: true, stop: true
  action :nothing
end
