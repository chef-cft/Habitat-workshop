pkg_origin="kiosk"
pkg_name="kiosk_coupons"
pkg_version=1.0.0
pkg_deps=(core/curl)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  return 0
}

do_install() {
  cp -R $PLAN_CONTEXT/../data/* "$pkg_prefix/"
  return 0  
}
