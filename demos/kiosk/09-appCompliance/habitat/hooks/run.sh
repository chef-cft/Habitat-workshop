#!{{ pkgPathFor "core/bash" }}/bin/bash

export HOME="{{pkg.svc_var_path}}"
export INSPEC_CONFIG_DIR="{{pkg.svc_var_path}}"

CFG_INTERVAL={{cfg.interval}}
CFG_PORT={{cfg.port}}

CFG_LOG_LEVEL={{cfg.log_level}}
CFG_LOG_LEVEL="${CFG_LOG_LEVEL:-warn}"
CFG_CHEF_LICENSE={{cfg.chef_license.acceptance}}
CFG_CHEF_LICENSE="${CFG_CHEF_LICENSE:-undefined}"
CONFIG="{{pkg.svc_config_path}}/inspec_exec_config.json"
WAIVER="{{pkg.svc_config_path}}/waiver.yml"
INPUTS="{{pkg.svc_config_path}}/inputs.yml"
PROFILE_PATH="{{pkg.path}}/{{pkg.name}}-{{pkg.version}}*.tar.gz"

CENSUS=$(curl -s localhost:9631/census)
NODE_ID=$(echo $CENSUS | grep -Pio -m1 '"member_id":"[^"]*"' | grep -Eo -m1 '[^:]*$')
sed -i "s/\"11111111-1111-1111-1111-111111111111\"/$NODE_ID/" ${CONFIG}

cfg_waiver_cmd="--waiver-file ${WAIVER}"
echo ${cfg_waiver_cmd}

EXEC="{{pkgPathFor "chef/inspec"}}/bin/inspec" 
COMMAND="$EXEC exec {{pkg.path}}/profiles/* --config ${CONFIG} ${cfg_waiver_cmd} --chef-license $CFG_CHEF_LICENSE --log-level $CFG_LOG_LEVEL"

mkdir {{pkg.svc_path}}/output/

inspec_cmd()
{
  #{{pkgPathFor "chef/inspec"}}/bin/inspec exec ${PROFILE_PATH} --config ${CONFIG} ${cfg_waiver_cmd} --input-file ${INPUTS} --chef-license $CFG_CHEF_LICENSE --log-level $CFG_LOG_LEVEL
  #{{pkgPathFor "chef/inspec"}}/bin/inspec exec ${PROFILE_PATH} --config ${CONFIG} ${cfg_waiver_cmd} --chef-license $CFG_CHEF_LICENSE --log-level $CFG_LOG_LEVEL
  {{pkgPathFor "chef/inspec"}}/bin/inspec exec "{{pkg.path}}/profiles/*" --config ${CONFIG} ${cfg_waiver_cmd} --chef-license $CFG_CHEF_LICENSE --log-level $CFG_LOG_LEVEL
  #{{pkgPathFor "chef/inspec"}}/bin/inspec exec "{{pkg.path}}/profiles/*" --config ${CONFIG} --chef-license $CFG_CHEF_LICENSE --log-level $CFG_LOG_LEVEL
}

exec  {{pkg.path}}/bin/{{pkg.name}} $CFG_PORT $CFG_INTERVAL "{{pkg.svc_path}}/output/" $COMMAND
