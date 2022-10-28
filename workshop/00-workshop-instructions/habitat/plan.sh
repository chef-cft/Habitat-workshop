pkg_origin=workshop
pkg_name=instructions
pkg_version="0.5.0"
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
  local app_path="$pkg_prefix/htdocs"
  mkdir -p $app_path

  cp -R \
    fonts \
    images \
    styles \
    templates \
    scripts \
    $app_path

  cp -R \
    00-overview \
    01-build \
    02-deploy \
    03-prepackaged \
    04-decentralized \
    05-ring \
    06-updates \
    07-host-compliance \
    08-host-config \
    09-app-compliance \
    10-jenkins \
    $app_path

  cp -R *.html $app_path
  
  return 0
}
