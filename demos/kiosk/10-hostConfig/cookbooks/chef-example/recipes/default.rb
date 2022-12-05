

log "Welcome to Chef Infra Client, #{node['example']['name']}!" do
level :info
end


include_recipe 'chef-example::file'
