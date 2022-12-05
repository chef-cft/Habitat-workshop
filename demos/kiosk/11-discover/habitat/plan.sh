pkg_origin="kiosk"
pkg_name="kiosk_discover"
pkg_version=1.0.0
pkg_build_deps=(core/go core/make core/gcc)
pkg_deps=(core/ruby30 core/coreutils)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}"

ruby_pkg="core/ruby30"

do_prepare() {
  GEM_HOME=$pkg_prefix
  GEM_PATH="$GEM_HOME"
  export GEM_HOME GEM_PATH
}

do_setup_environment() {
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
#  set_runtime_env APP_VERSION "$pkg_version"
#  set_runtime_env APP_RELEASE "$pkg_release"
}

do_before() {
  rm -rf "$REPO_PATH"
}

do_build_go() {
  cp -R src $REPO_PATH
  cd $REPO_PATH
  cd src
  go build -o "${pkg_name}" 
  mv  "${pkg_name}" "../${pkg_name}" 
  return 0
}

do_install_go() {  
  mkdir -p "${pkg_prefix}/bin"
  mv "${REPO_PATH}/${pkg_name}" "${pkg_prefix}/bin"
  return 0
}





do_build() {
  do_build_go
  gem install --bindir "$pkg_prefix/ruby-bin" ohai -v 18.0.26 --no-document
  fix_interpreter "$pkg_prefix/ruby-bin/*" core/coreutils bin/env
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}

do_install() {
  wrap_ruby_bin "ohai"
}

wrap_ruby_bin() {
  do_install_go
  local name="$1"
  local original="$pkg_prefix/ruby-bin/$name"
  local wrapper="$pkg_prefix/bin/$name"
  build_line "Adding wrapper $original to $wrapper"
  cat <<EOF > "$wrapper"
#!/bin/sh
set -e
if test -n "$DEBUG"; then set -x; fi
export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"
unset RUBYOPT GEMRC
exec $(pkg_path_for ${ruby_pkg})/bin/ruby $original \$@
EOF
  chmod -v 755 "$wrapper"
}