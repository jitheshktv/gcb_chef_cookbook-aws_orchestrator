include_recipe 'cti_orchestrator::default'
include_recipe 'jenkins::master'
include_recipe 'cti_orchestrator::jenkins_plugins'
# include_recipe 'cti_orchestrator::jenkins_jobs'
include_recipe 'cti_orchestrator::homebin'

service 'jenkins' do
  action :restart
end
