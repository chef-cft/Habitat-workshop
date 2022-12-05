#!/bin/sh

export SSL_CERT_FILE="/hab/pkgs/core/cacerts/2021.10.26/20220311110931/ssl/cert.pem"
export SSL_CERT_DIR="/hab/pkgs/core/cacerts/2021.10.26/20220311110931/ssl/certs"

CFG_INTERVAL={{cfg.interval}}
CFG_PORT={{cfg.port}}

cfg_log_level="${cfg_log_level:-warn}"
cfg_run_lock_timeout="${cfg_run_lock_timeout:-1800}"

EXEC="{{pkgPathFor "chef/chef-infra-client"}}/bin/chef-client" 
COMMAND="$EXEC -z -l ${cfg_log_level} -c {{pkg.svc_config_path}}/client-config.rb -j {{pkg.svc_config_path}}/attributes.json --once --no-fork --run-lock-timeout ${cfg_run_lock_timeout} --chef-license accept-no-persist"

echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
whoami
cp -ar "{{pkg.path}}/.chef" "{{pkg.svc_var_path}}"
cp -ar "{{pkg.path}}/policies" "{{pkg.svc_var_path}}"
cp -ar "{{pkg.path}}/policy_groups" "{{pkg.svc_var_path}}"
cp -ar "{{pkg.path}}/cookbook_artifacts" "{{pkg.svc_var_path}}"
cp "{{pkg.path}}/Policyfile.lock.json" "{{pkg.svc_var_path}}"


mkdir "{{pkg.svc_path}}/output/"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"
echo "----------------------"

cd "{{pkg.svc_var_path}}"
exec  {{pkg.path}}/bin/{{pkg.name}} $CFG_PORT $CFG_INTERVAL "{{pkg.svc_path}}/output/" $COMMAND


#cfg_splay_duration=$(shuf -i 0-"${cfg_splay}" -n 1)

#cfg_splay_first_run_duration=$(shuf -i 0-"${cfg_splay_first_run}" -n 1)
#
#cd "{{pkg.svc_var_path}}"
#cd "{{pkg_prefix}}"

#pwd

#exec 2>&1
#sleep "${cfg_splay_first_run_duration}"
#chef_client_cmd

#while true; do
#  sleep "${cfg_splay_duration}"
#  sleep "${cfg_interval}"
#  chef_client_cmd
#done
