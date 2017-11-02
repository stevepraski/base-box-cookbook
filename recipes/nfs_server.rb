#
# Cookbook:: base-box-cookbook
# Recipe:: nfs_server
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Steven Praski, refer to LICENSE

# FIXME: later - ONLY TESTED ON UBUNTU 16.04
raise "Unsupported Platform: #{node['platform']}" unless node['platform'] == 'ubuntu'

node.default['nfs_server']['root_dir'] = '/var/nfs'
node.default['nfs_server']['exports'] = [
  # {
  #   :comment => 'read-only subnet',
  #   :subdir => 'share',
  #   :hosts => '192.168.1.0/24',
  #   :opts => 'ro,no_subtree_check'
  # },
  {
    comment: 'read-write entire subnet',
    subdir: 'share',
    hosts: '192.168.1.0/24',
    opts: 'rw,sync,no_subtree_check'
  }
]

package 'nfs-kernel-server'

directory node['nfs_server']['root_dir'] do
  owner 'nobody'
  group 'nogroup'
  action :create
end

node['nfs_server']['exports'].each do |export|
  directory File.join(node['nfs_server']['root_dir'], export[:subdir]) do
    owner 'nobody'
    group 'nogroup'
    mode '0777'
    action :create
  end
end

template '/etc/exports' do
  source 'nfs_exports.erb'
  mode '0400'
  owner 'root'
  group 'root'
  variables exports: node['nfs_server']['exports'],
            root_dir: node['nfs_server']['root_dir']
  notifies :restart, 'service[nfs-kernel-server]', :delayed
end

service 'nfs-kernel-server' do
  supports status: true, restart: true, start: true, stop: true
  action [:enable, :start]
end
