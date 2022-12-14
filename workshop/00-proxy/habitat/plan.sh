pkg_origin=workshop
pkg_name=proxy
pkg_version="1.0.0"
pkg_maintainer="The Chef Training Team <training@chef.io>"
pkg_license=('Apache-2.0')
pkg_deps=(core/nginx)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_svc_run="nginx -c $pkg_svc_config_path/nginx.conf"

do_download() {
  return 0
}

do_build() {
  return 0
}



do_install() {  
  mkdir -p "${pkg_prefix}/wwwroot"
  cp -v index.html "${pkg_prefix}/wwwroot/"

  return 0
}
