#
# Cookbook:: base-box-cookbook
# Recipe:: build
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Steven Praski, refer to LICENSE

include_recipe 'build-essential::default'

# kernel headers
case node['platform_family']
when 'debian'
  package "linux-headers-#{node['kernel']['release']}"
when 'rhel', 'chefspec'
  package 'kernel-devel' do
    version node['kernel']['release'].split('.' + node['kernel']['machine']).first
  end
else
  raise "Unsupported Platform Family: #{node['platform_family']}"
end
