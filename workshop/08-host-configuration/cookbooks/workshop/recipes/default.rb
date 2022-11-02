# ---
# resources:
# - type: file
#   name: /tmp/tmpfile1
# - type: file
#   name: /tmp/will-not-create-due-to-guard
#   only_if: windows?
# - type: file
#   name: /tmp/should-be-created
#   not_if: windows?
# - type: execute
#   name: exec_block1
#   command: echo 'Cookbook has run and done things.'


chef_effortless = if Chef::CHEF_ROOT.include?("hab/pkgs/chef/chef")
                    Chef::Config['chef_server_url'].include?("chefzero://") || nil
                  end

file '/tmp/tmpfile1'
file '/tmp/should-be-created' unless windows?
execute "echo 'Cookbook has run and done things.'"
ruby_block 'show_chef_config' do
  block do
    Chef::Config.keys.sort.each { |k| puts "#{k} -> #{Chef::Config[k]}" }
    puts "My Effortless status is: #{chef_effortless}"
  end
  action :run
end
