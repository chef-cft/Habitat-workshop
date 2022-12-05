ohai 'reload openssh-client' do
  action :nothing
end

package 'openssh-client' do
  package_name node['ssh-hardening']['sshclient']['package']
  # we need to reload the package version, otherwise we get the version that was installed before cookbook execution
  notifies :reload, 'ohai[reload openssh-client]', :immediately
end

directory 'openssh-client ssh directory /etc/ssh' do
  path '/etc/ssh'
  mode '0755'
  owner 'root'
  group 'root'
end

template '/etc/ssh/ssh_config' do
  source 'openssh.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
    # we do lazy here to ensure we detect the version that comes with the packge update above
    lazy do
      {
        mac:     node['ssh-hardening']['ssh']['client']['mac']    || DevSec::Ssh.get_client_macs(node['ssh-hardening']['ssh']['client']['weak_hmac']),
        kex:     node['ssh-hardening']['ssh']['client']['kex']    || DevSec::Ssh.get_client_kexs(node['ssh-hardening']['ssh']['client']['weak_kex']),
        cipher:  node['ssh-hardening']['ssh']['client']['cipher'] || DevSec::Ssh.get_client_ciphers(node['ssh-hardening']['ssh']['client']['cbc_required']),
        version: DevSec::Ssh.get_ssh_client_version
      }
    end
  )
end
