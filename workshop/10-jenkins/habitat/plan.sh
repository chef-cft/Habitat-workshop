pkg_origin=workshop
pkg_name=jenkins
pkg_version="1.1.0"
pkg_deps=(core/node)


do_build() {
  npm install
}

do_install() {
  local app_path="$pkg_prefix/app"
  mkdir -p $app_path

  cp -R \
    node_modules \
    public \
    routes \
    views \
    package.json \
    app.js \
    index.js \
    $app_path
}
