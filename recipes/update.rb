#
# Cookbook Name:: prep-box-cookbook
# Recipe:: update
#
# Copyright (c) 2015 Steven Praski, All Rights Reserved.

# references:
# https://bugs.launchpad.net/ubuntu/+source/grub/+bug/239674/comments/1
# http://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt

case node['platform_family']
when 'debian'
  update_cmd = 'apt-get update'
  update_rtn_codes = [0]
  # note: will over-write old configuration files,
  # which is normally not the desired action for non-fresh systems
  upgrade_cmd = 'DEBIAN_FRONTEND=noninteractive ucf
                --purge /var/run/grub/menu.lst && \
                apt-get -y -o Dpkg::Options::="--force-confdef" \
                -o Dpkg::Options::="--force-confnew" dist-upgrade'
when 'rhel', 'chefspec'
  update_cmd = 'yum check-update'
  update_rtn_codes = [0, 100]
  # acts on obsolete packages as well
  upgrade_cmd = 'yum update -y yum && yum upgrade -y'
else
  fail "Unsupported Platform Family: #{node['platform_family']}"
end

execute 'repository update' do
  command update_cmd
  user 'root'
  group 'root'
  only_if { node['update']['upgrade'] }
  returns update_rtn_codes
end

execute 'software upgrade' do
  command upgrade_cmd
  user 'root'
  group 'root'
  only_if { node['update']['upgrade'] }
end
