template '/var/lib/jenkins/proxy.xml' do
  source 'proxy.xml.erb'

  variables(
    {
      :proxy_host => node['jenkins']['proxy']['host'],
      :proxy_port => node['jenkins']['proxy']['port'],
      :no_proxy => node['jenkins']['proxy']['no_proxy']
    }
  )
  only_if { node['jenkins']['proxy']['enabled'] }
  notifies :restart, 'service[jenkins]', :immediately
end
