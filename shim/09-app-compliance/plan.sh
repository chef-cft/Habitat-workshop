pkg_origin=workshop
pkg_name=app_compliance
pkg_version="0.0.0"
pkg_maintainer="The Chef Training Team <training@chef.io>"
pkg_license=('Apache-2.0')
pkg_build_deps=(core/go)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_svc_run="${pkg_name} 8009 $pkg_svc_config_path/index.html"
pkg_bin_dirs=(bin)

do_download() {
  return 0
}

do_setup_environment() {
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_before() {
  rm -rf "$REPO_PATH"
}

do_build() {
  cp -R src $REPO_PATH
  cd $REPO_PATH
  cd src
  go build -o "${pkg_name}" 
  mv  "${pkg_name}" "../${pkg_name}" 
  return 0
}

do_install() {  
  mkdir -p "${pkg_prefix}/bin"
  mv "${REPO_PATH}/${pkg_name}" "${pkg_prefix}/bin"
  return 0
}
