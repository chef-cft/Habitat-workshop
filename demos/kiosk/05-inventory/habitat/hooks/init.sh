
#[ -d "{{pkg.svc_var_path}}/www" ] || mkdir {{pkg.svc_var_path}}/www
#cp -R "{{pkg.path}}/" "{{pkg.svc_var_path}}"
cp -R {{pkg.path}}/www/*  {{pkg.svc_data_path}}