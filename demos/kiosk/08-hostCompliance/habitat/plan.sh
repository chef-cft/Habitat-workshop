pkg_origin="kiosk"
pkg_name="kiosk_hostCompliance"
pkg_version=1.0.0
pkg_build_deps=(core/go chef/inspec)
pkg_deps=(chef/inspec)
pkg_svc_user="root"
pkg_svc_group="root"

do_setup_environment() {
  ARCHIVE_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name-$pkg_version.tar.gz"
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_before() {
  rm -rf "$REPO_PATH"
}

do_build() {
  if [ ! -f $PLAN_CONTEXT/../inspec.yml ]; then
    exit_with 'Cannot find inspec.yml. Please build from profile root.' 1
  fi

  local profile_files=($(ls $PLAN_CONTEXT/../ -I habitat -I results))
  local profile_location="$HAB_CACHE_SRC_PATH/$pkg_dirname/build"
  mkdir -p $profile_location

  build_line "Copying profile files to $profile_location"
  cp -R ${profile_files[@]} $profile_location

  build_line "Archiving $ARCHIVE_PATH"
  inspec archive "$HAB_CACHE_SRC_PATH/$pkg_dirname/build" --chef-license "accept-no-persist" -o $ARCHIVE_PATH --overwrite

  build_line "Compiling wrapper"

  cp -R src $REPO_PATH
  cd $REPO_PATH
  cd src
  go build -o "${pkg_name}" 
  mv  "${pkg_name}" "../${pkg_name}" 
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/profiles
  cp $ARCHIVE_PATH $pkg_prefix/profiles

  mkdir -p "${pkg_prefix}/bin"
  mv "${REPO_PATH}/${pkg_name}" "${pkg_prefix}/bin"
  return 0  
}
