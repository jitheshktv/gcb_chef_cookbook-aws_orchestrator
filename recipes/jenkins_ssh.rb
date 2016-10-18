directory '/var/lib/jenkins/.ssh' do
  mode '0700'
  owner 'jenkins'
  group 'jenkins'
end

if ::File.exist?("/root/.ssh/config")
  file '/var/lib/jenkins/.ssh/config' do
    content ::File.open("/root/.ssh/config").read
    mode '0755'
    owner 'jenkins'
    group 'jenkins'
    sensitive true
  end
end

if ::File.exist?("/root/.ssh/known_hosts") 
  file '/var/lib/jenkins/.ssh/known_hosts' do
    content ::File.open("/root/.ssh/known_hosts").read
    mode '0755'
    owner 'jenkins'
    group 'jenkins'
    sensitive true
  end
end

if ::File.exist?("/root/.ssh/citi_rsa") 
  file '/var/lib/jenkins/.ssh/citi_rsa' do
    content ::File.open("/root/.ssh/citi_rsa").read
    mode '0400'
    owner 'jenkins'
    group 'jenkins'
    sensitive true
  end
end
