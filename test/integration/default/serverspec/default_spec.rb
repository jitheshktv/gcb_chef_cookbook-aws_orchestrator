require 'serverspec'

%w(python python-pip python-wheel python-virtualenv awscli).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w(gcc zlib-devel libyaml-devel readline-devel libffi-devel openssl-devel sqlite-devel ntp).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/orchestrator') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/orchestrator/run_stack.sh') do
  it { should exist }
end

# not sure we care about particular version? just make sure it's there
describe command('git --version') do
  its(:stdout) { should match /^git version.*$/ }
end

# make sure there is a system ruby for the basic stuff.  on centos7 should be a 2.0.0
describe command('ruby -v') do
  its(:stdout) { should match /^ruby 2\.2\.0.*$/ }
end

describe command('gem list | grep bundler') do
  its(:stdout) { should match /^bundler .*$/ }
end

describe command('gem list | grep rake') do
  its(:stdout) { should match /^rake .*$/ }
end



%w(berkshelf test-kitchen bundler rake).each do |gem_to_be_installed|
  describe command("gem list -i #{gem_to_be_installed}") do
    its(:stdout) { should eq("true\n") }
  end
end

# check if docker is running
describe command('docker -v') do
  its(:stdout) { should start_with('Docker version') }
end

# make sure jenkins got added to sudoers
describe command('grep "jenkins ALL=(ALL) NOPASSWD:ALL" /etc/sudoers | wc -l') do
  its(:stdout) { should eq("1\n") }
end