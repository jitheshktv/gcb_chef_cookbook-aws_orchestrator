template "/var/tmp/job-seed.xml" do
  source 'job-seed.xml.erb'

  variables(
    {
    :source_repo => node['git']['base_url'] + '/' + node['git']['repo']['orchestrator'] + '.git',
    :env_repo => node['git']['base_url'] + '/${env_repo_name}' + '.git'
    }
  )
end

jenkins_job "job-seed" do
  config "/var/tmp/job-seed.xml"
end

jenkins_job "job-seed" do
  parameters(
      'env_repo_name' => node['git']['repo']['environment']
  )
  stream_job_output true
  wait_for_completion true
  action :build
end
