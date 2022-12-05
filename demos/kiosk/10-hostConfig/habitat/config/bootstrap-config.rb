### Chef Infra Client Configuration ###
# The settings in this file will configure chef to apply the exported policy in
# this directory. To use it, run:
#
# chef-client -z
#

policy_name 'sample'
policy_group 'local'

use_policyfile true
policy_document_native_api true

# In order to use this repo, you need a version of Chef Infra Client and Chef Zero
# that supports policyfile "native mode" APIs:
current_version = Gem::Version.new(Chef::VERSION)
unless Gem::Requirement.new(">= 12.7").satisfied_by?(current_version)
  puts("!" * 80)
  puts(<<-MESSAGE)
This Chef Repo requires features introduced in Chef Infra Client 12.7, but you are using
Chef #{Chef::VERSION}. Please upgrade to Chef Infra Client 12.7 or later.
MESSAGE
  puts("!" * 80)
  exit!(1)
end
cache_path '/hab/svc/host_configuration/data/cache'
node_path '/hab/svc/host_configuration/data/nodes'
role_path '/hab/svc/host_configuration/data/roles'
chef_zero.enabled true
ENV['PATH'] = "/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:#{ENV['PATH']}"
