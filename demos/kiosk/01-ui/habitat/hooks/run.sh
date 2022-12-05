cd "{{pkg.svc_var_path}}/www" || exit
exec {{pkgPathFor "core/dotnet-asp-core"}}/bin/dotnet {{pkg.name}}.dll 2>&1
