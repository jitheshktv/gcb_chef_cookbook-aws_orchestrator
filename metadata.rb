name 'cti_orchestrator'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures cti_orchestrator'
long_description 'Installs/Configures cti_orchestrator'
version '0.1.0'

issues_url 'https://github.com/chef-cookbooks/something/issues' if respond_to?(:issues_url)
source_url 'https://github.com/chef-cookbooks/something' if respond_to?(:source_url)

depends 'enforce_supported_platform'
depends 'yum-epel'
depends 'git'
depends 'docker', '~> 2.0'

#for jenkins
depends 'magic_shell', '~> 1.0.0'
depends 'java'
depends 'jenkins', '~> 2.6.0'

%w(redhat centos).each do |os|
  supports os
end
