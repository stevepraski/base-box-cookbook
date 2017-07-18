#
# Cookbook Name:: base-box-cookbook
# Recipe:: firewall
#
# Copyright (c) 2015 Steven Praski, refer to LICENSE

include_recipe 'iptables::default'

# push rules (from the iptables recipe documentation; this is easier than making templates)
node['iptables']['rules'].map do |rule_name, rule_body|
  iptables_rule rule_name do
    lines [rule_body].flatten.join("\n")
  end
end

include_recipe 'fail2ban'
# unconditionally disable firewalld (installed by fail2ban package) to prevent interference with iptables
service 'firewalld' do
  action [:disable, :stop]
end
