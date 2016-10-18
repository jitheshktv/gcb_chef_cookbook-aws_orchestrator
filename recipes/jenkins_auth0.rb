require 'openssl'
require 'net/ssh'

# need to install this plugin here because jenkins_user resource requires it
# and it is no longer included in the default jenkins installation
jenkins_plugin 'mailer' do
  notifies :restart, 'service[jenkins]', :immediately
end

if node['jenkins']['private_key']
  Chef::Log.info("Using existing private key for the chef user in jenkins")
  key = OpenSSL::PKey::RSA.new(node['jenkins']['private_key'])
else
  Chef::Log.info("Generating new key pair for the chef user in jenkins")
  key = OpenSSL::PKey::RSA.new(2048)
  IO.write(File.join("/tmp", "chef-jenkins.pem"), key.to_pem)
  node.set['jenkins']['private_key'] = key.to_pem
end

private_key = key.to_pem
public_key = "#{key.ssh_type} #{[key.to_blob].pack('m0')} auto-generated key"

# Create the Jenkins user with the public key
jenkins_user "chef" do
  id "chef@citi.com"
  email "chef@citi.com"
  full_name "Chef"
  public_keys [public_key]
end

node.run_state[:jenkins_private_key] = private_key

#ruby_block 'set jenkins private key' do
#  block do
#    node.run_state[:jenkins_private_key] = private_key
#  end
#only_if { node.attribute?('security_enabled') || ::File.file?('/var/lib/jenkins/security_enabled') }
#end
