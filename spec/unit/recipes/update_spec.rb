#
# Cookbook Name:: base-box-cookbook
# Spec:: default
#
# Copyright (c) 2015 Steven Praski, refer to LICENSE

require 'spec_helper'
describe 'base-box-cookbook::update' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
