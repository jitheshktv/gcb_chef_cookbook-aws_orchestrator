# Cookbook name:: cti_orchestrator
# Recipe:: jenkins_default
#
# Configure a Jenkins master

include_recipe 'cti_orchestrator::jenkins_prereqs'
include_recipe 'java'
include_recipe 'git'
include_recipe 'jenkins::master'
include_recipe 'cti_orchestrator::jenkins_auth0'
include_recipe 'cti_orchestrator::jenkins_proxy'
include_recipe 'cti_orchestrator::jenkins_ssh'
include_recipe 'cti_orchestrator::jenkins_homebin'
include_recipe 'cti_orchestrator::jenkins_plugins'
include_recipe 'cti_orchestrator::jenkins_jobs'
include_recipe 'cti_orchestrator::jenkins_auth'
