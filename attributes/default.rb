default['orchestrator']['orchestrator_path'] = '/orchestrator'

default['git']['base_url'] = 'https://github.com/jitheshktv'
default['git']['repo']['orchestrator'] = 'gcb_orchestrator-aws_orchestrator'
default['git']['repo']['json_rules'] = 'gcb_gem-json_rules'

# default repository should be the Long-Term Support release
# https://wiki.jenkins-ci.org/display/JENKINS/LTS+Release+Line
node.default['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/redhat-stable'
node.default['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key'

# disable the setup wizard
node.default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'
