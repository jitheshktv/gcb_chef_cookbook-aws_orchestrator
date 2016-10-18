# beware: jq-devel doesn't exist in Centos6 and the jq also should be 1.5 (not Centos6's 1.3)
%w(jq jq-devel).each do |pkg|
  package pkg do
    action :install
  end
end

bash 'pull down the json-rules source' do
  code <<-END
    git clone #{node['git']['base_url']}/#{node['git']['repo']['json_rules']}.git /opt/json-rules
  END
  not_if { File.exist? '/opt/json-rules' }
end

bash 'build the gem' do
  code <<-END
    gem install rake
    gem build json-rules.gemspec
  END
  cwd '/opt/json-rules'
end
