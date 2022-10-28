pkg_origin=workshop
pkg_name=build_package
pkg_version="0.1.0"
pkg_maintainer="The Chef Training Team <training@chef.io>"
pkg_license=('Apache-2.0')
pkg_deps=(core/httpd)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_svc_run="httpd -DFOREGROUND -f $pkg_svc_config_path/httpd.conf"

do_download() {
  return 0
}

do_build() {
  return 0
}

do_install() {  
  cp index.html $pkg_prefix/
  return 0
}
