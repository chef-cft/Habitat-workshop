pkg_origin="kiosk"
pkg_name="kiosk_hostConfig"
pkg_version=1.0.0
pkg_svc_user=root
pkg_svc_group=root
pkg_build_deps=(chef/scaffolding-chef-infra core/go)
pkg_deps=(chef/chef-infra-client)

scaffold_policy_name="sample"
scaffold_policyfile_path="$PLAN_CONTEXT/../policyfiles"
scaffold_data_bags_path="$PLAN_CONTEXT/../data_bags"
src_path="$PLAN_CONTEXT/../src"

do_setup_environment() {
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_before() {
  rm -rf "$REPO_PATH"
}

do_build() {
  export CHEF_LICENSE="accept-no-persist"
  if [ ! -d "${scaffold_policyfile_path}" ]; then
    build_line "A policyfile directory is required to build. More info: https://docs.chef.io/policyfile.html"
    exit 1
  fi
  rm -f "${scaffold_policyfile_path}"/*.lock.json
  policyfile="${scaffold_policyfile_path}/${scaffold_policy_name}.rb"

  for p in $(grep include_policy "${policyfile}" | awk -F "," '{print $1}' | awk -F '"' '{print $2}' | tr -d " "); do
    build_line "Detected included policyfile, ${p}.rb, installing"
    chef-cli install "${scaffold_policyfile_path}/${p}.rb"
  done

  for p in $(grep include_policy "${policyfile}" | awk -F "," '{print $1}' | awk -F '\x27' '{print $2}' | tr -d " "); do
    build_line "Detected included policyfile, ${p}.rb, installing"
    chef-cli install "${scaffold_policyfile_path}/${p}.rb"
  done

  chef-cli install "${policyfile}"

  #--------------------------------------------------------------------

  build_line "Compiling wrapper"
  echo $REPO_PATH
  pwd

  cp -R $src_path $REPO_PATH
  cd $REPO_PATH
  cd src
  go build -o "${pkg_name}" 
  mv  "${pkg_name}" "../${pkg_name}" 
}

do_install() {
  chef-cli export "${scaffold_policyfile_path}/${scaffold_policy_name}.lock.json" "${pkg_prefix}"
  
  if [ -d "${scaffold_data_bags_path}" ]; then
    cp -a "${scaffold_data_bags_path}" "${pkg_prefix}"
  fi

  #--------------------------------------------------------------------


  mkdir -p "${pkg_prefix}/bin"
  mv "${REPO_PATH}/${pkg_name}" "${pkg_prefix}/bin"
}
