$pkg_name="postgresql"
$pkg_origin="mwrock"
$pkg_version="15.0-1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_source="https://get.enterprisedb.com/postgresql/postgresql-$pkg_version-windows-x64.exe"
$pkg_shasum="5a628a9f292ecfb8555ae071a75e5978e4fc2beacd4a18a2c81f95e7d3676328"
$pkg_bin_dirs = @("bin")

function Invoke-Unpack { }

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/postgresql-$pkg_version-windows-x64.exe" "$pkg_prefix/bin/postgresql.exe" -Force
}
