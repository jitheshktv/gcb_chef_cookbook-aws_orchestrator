node.default['jenkins_config']['jenkins_plugins'] = [
  {'name'    =>  'git', 'version' => '2.4.1'},
  {'name'    => 'job-dsl'},
  {'name'    => 'envinject'},
#  {'name'    => 'rvm'},
  {'name'    => 'token-macro'},
  {'name'    => 'ruby-runtime'},
  {'name'    => 'ansicolor'},
  {'name'    => 'delivery-pipeline-plugin'},
#  {'name'    => 'aws-codepipeline'},
  {'name'    => 'workflow-aggregator'},
  {'name'    => 'copyartifact'},
  {'name'    => 'multiple-scms'},
  {'name'    => 'matrix-auth'},
  {'name'    => 'greenballs'}
]
