require 'spec_helper'
# Serverspec examples can be found at
# http://serverspec.org/resource_types.html

describe 'Firewall' do
  it 'can not connect to rpcbind port' do
    port(111) { should_not be_listening }
  end
  it 'SSH is availble' do
    port(22) { should be_listening }
  end
end
