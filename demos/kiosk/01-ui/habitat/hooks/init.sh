mkdir {{pkg.svc_var_path}}/www
cp -ar "{{pkg.path}}/www" "{{pkg.svc_var_path}}"
ln -vsf "{{pkg.svc_config_path}}/appsettings.json" "{{pkg.svc_var_path}}/www/appsettings.json"