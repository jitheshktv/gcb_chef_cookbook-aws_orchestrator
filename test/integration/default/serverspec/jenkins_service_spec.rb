require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end

describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening.with('tcp6') }
end

describe http_get('http://localhost:8080/') do
  its(:status) { should eq 200 }
end
