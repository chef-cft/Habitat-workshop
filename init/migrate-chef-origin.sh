export OLD_AUTH_TOKEN=$HAB_AUTH_TOKEN
export HAB_AUTH_TOKEN="_Qk9YLTEKYmxkci0yMDE3MDkyNzAyMzcxNApibGRyLTIwMTcwOTI3MDIzNzE0ClJDcXNzcWdOazBWTlptMGJJanQwYklUWDkvc3lkT3BQCmRVSzBWbHRTVzNWY2FiSUFGTUxQSERVMDQ0T2RmUzYrR2h4SlBRVnVCeVBTUGpNag=="

#download a specific version of Infra Client
hab pkg download -u "https://bldr.habitat.sh" chef/chef-infra-client/17.10.3/20220823074032

#download a specific version of InSpec
hab pkg download -u "https://bldr.habitat.sh" chef/inspec/5.18.14/20220823064351


export HAB_AUTH_TOKEN=$OLD_AUTH_TOKEN
hab bldr channel create chef

hab pkg upload -u $PRIMARY_DEPOT -c stable /hab/cache/artifacts/chef-chef-infra-client-17.10.3-20220823074032-x86_64-linux.hart

hab pkg upload -u $PRIMARY_DEPOT -c stable /hab/cache/artifacts/chef-inspec-5.18.14-20220823064351-x86_64-linux.hart