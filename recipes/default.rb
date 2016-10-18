#
# Cookbook Name:: cti_orchestrator
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
#
fail "unsupported platform!! #{node[:platform]}" if skip_unsupported_platform

bash 'clean yum metadata' do
  code <<-END
  yum clean metadata
  END
end

include_recipe 'yum-epel'

cookbook_file 'root personal bashrc' do
  path '/root/.bashrc'
  source 'bashrc'
end

template 'root orchestrator env file' do
  source 'env.sh.erb'
  mode '0755'
  path '/root/env.sh'
end

%w(python python-pip python-wheel python-virtualenv awscli ntp).each do |pkg|
  package pkg do
    action :install
  end
end

%w(gcc zlib-devel libyaml-devel readline-devel libffi-devel openssl-devel sqlite-devel bzip2).each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file 'ruby 2.3.1 source dist' do
  path '/var/tmp/ruby-2.3.1.tar.gz'
  source 'ruby-2.3.1.tar.gz'
end

bash 'unzip ruby 2.3.1' do
  cwd '/var/tmp'
  code <<-END
    tar vzxf ruby-2.3.1.tar.gz
  END
  not_if { ::File.exists?('/bin/ruby') }
end

bash 'build ruby 2.3.1' do
  cwd '/var/tmp/ruby-2.3.1'
  code <<-END
    set -e
    ./configure --prefix /
    make
    make install
  END
  not_if { ::File.exists?('/bin/ruby') }
end

include_recipe 'git'

include_recipe 'cti_orchestrator::json_rules'

bash 'install bundler and rake in system ruby' do
  code <<-END
    # don't use 1.11.2 if we ever feed from Nexus
    gem install bundler rake --conservative \
                             --no-ri \
                             --no-rdoc
  END
end

%w(berkshelf test-kitchen kitchen-ec2 bundler rake).each do |gem_to_install|
  bash "install #{gem_to_install}" do
    code <<-END
      gem install #{gem_to_install}  --conservative \
                                     --no-ri \
                                     --no-rdoc
    END
  end
end

# delete the dir so the git resource below will always get the latest code
bash 'delete orchestrator directory' do
  orch_dir = node['orchestrator']['orchestrator_path']
  code <<-END
    rm -rf #{orch_dir}
  END
end

# pull the orchestrator in so it can be run outside of jenkins
git node['orchestrator']['orchestrator_path'] do
  repository node['git']['base_url'] + '/' + node['git']['repo']['orchestrator'] + '.git'
  revision 'master'
  action :checkout
end

docker_service 'default' do
  action [:create, :start]
end

ruby_block 'add jenkins to sudoers' do
  block do
    file = Chef::Util::FileEdit.new('/etc/sudoers')
    new_entry = 'jenkins ALL=(ALL) NOPASSWD:ALL'
    file.insert_line_if_no_match(Regexp.new(Regexp.quote(new_entry)), new_entry)
    file.write_file
  end
end unless node['run_mode'] == 'dev'

ruby_block 'drop any tty req so jenkins scripts can sudo without trouble' do
  block do
    file = Chef::Util::FileEdit.new('/etc/sudoers')
    file.search_file_delete_line /Defaults\s+requiretty/
    file.write_file
  end
end unless node['run_mode'] == 'dev'

include_recipe 'cti_orchestrator::oracle_client'
include_recipe 'cti_orchestrator::default_orchestrator_name'
include_recipe 'cti_orchestrator::jenkins_default' unless node['run_mode'] == 'dev'
