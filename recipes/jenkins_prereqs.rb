packages = node.default['jenkins_config']['jenkins_prereqs']['packages']
packages.each do |package|
  package package
end
