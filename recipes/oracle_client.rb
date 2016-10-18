bash 'get oracle client rpm from s3' do
  src_dir = 's3://orchestrator-resources/oracle'
  dest_dir = '/orchestrator/files/'
  client_basic = node['ora_client']['basic']
  client_sqlplus = node['ora_client']['sqlplus']
  code <<-END
    aws s3 cp #{src_dir}/#{client_basic} #{dest_dir}/#{client_basic}
    aws s3 cp #{src_dir}/#{client_sqlplus} #{dest_dir}/#{client_sqlplus}
  END
  not_if { ::File.exists?("#{dest_dir}/#{client_basic}") && ::File.exists?("#{dest_dir}/#{client_sqlplus}") }
end

yum_package 'libaio'

rpm_package 'install oracle client basic lite' do
  action :install
  source "/orchestrator/files/#{node['ora_client']['basic']}"
end

rpm_package 'install oracle client sqlplus' do
  action :install
  source "/orchestrator/files/#{node['ora_client']['sqlplus']}"
end

ruby_block 'add env variables' do
  block do
    file = Chef::Util::FileEdit.new('/root/.bash_profile')
    new_entries = Array.new
    new_entries.push('export ORACLE_HOME=/usr/lib/oracle/11.2/client64')
    new_entries.push('export PATH=$ORACLE_HOME/bin:$PATH')
    new_entries.push('export LD_LIBRARY_PATH=$ORACLE_HOME/lib')
    new_entries.each do |new_entry|
      file.insert_line_if_no_match(Regexp.new(Regexp.quote(new_entry)), new_entry)
    end
    file.write_file
  end
end
