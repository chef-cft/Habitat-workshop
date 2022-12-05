# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'sample'

# Where to find external cookbooks:
#default_source :supermarket
default_source :chef_repo, "../"

run_list [
    #'chef-example::file'
    'chef-example::default'
    #'ssh-hardening::server',
    #'ssh-hardening::client'
]

#cookbook "chef-example", path: "../cookbooks/chef-example"
#cookbook "ssh-hardening", path: "../cookbooks/ssh-hardening"
