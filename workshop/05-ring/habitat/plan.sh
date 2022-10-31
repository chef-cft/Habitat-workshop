pkg_name=ring
pkg_origin=workshop
pkg_version="1.0.0"
pkg_maintainer="The Chef Training Team <training@chef.io>"
pkg_license=("Apache-2.0")
pkg_svc_user="root"

pkg_deps=(
  core/gcc
  core/gcc-libs
  core/git 
  core/rust
)

pkg_build_deps=(
  core/gcc
  core/gcc-libs
  core/git 
  core/rust
)

do_download() {
  return 0
}

do_verify() {
  return 0 # required per do_download() comments
}

do_build() {
  #rm -rf ./habitat/poem-toy

  #build_line "cargo clean"
  #cargo clean

  #build_line "cargo build --release"
  cargo build --release
}


do_install() {
  build_line "cp target/release/${pkg_name} ${pkg_prefix}"
  cp target/release/${pkg_name} ${pkg_prefix}

  build_line "cp -r files ${pkg_prefix}"
  cp -r files ${pkg_prefix}

  build_line "cp -r templates ${pkg_prefix}"
  cp -r templates ${pkg_prefix}
}

# The default implementation is to strip any binaries in $pkg_prefix of their
# debugging symbols. You should override this behavior if you want to change
# how the binaries are stripped, which additional binaries located in
# subdirectories might also need to be stripped, or whether you do not want the
# binaries stripped at all.
do_strip() {
  return 0 # should be fine due to cargo build --release 
}
