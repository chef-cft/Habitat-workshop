pkg_name="smart_updates"
pkg_origin="workshop"
pkg_version="0.1.0"

pkg_deps=(
  core/dotnet-core core/dotnet-asp-core core/hab
)

pkg_build_deps=(
  core/dotnet-core-sdk
)

do_build()
{
    cp -r $PLAN_CONTEXT/../ $HAB_CACHE_SRC_PATH/$pkg_dirname
    cd ${HAB_CACHE_SRC_PATH}/${pkg_dirname}
    dotnet build
}

do_install() {
  dotnet publish --output "$pkg_prefix/www"
}
