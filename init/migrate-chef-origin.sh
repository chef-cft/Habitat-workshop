. ../env.sh
export HAB_AUTH_TOKEN=""

hab origin key download -u "https://bldr.habitat.sh" chef

#download a specific version of Infra Client
hab pkg download -u "https://bldr.habitat.sh" --download-directory . chef/chef-infra-client/17.10.3/20220823074032

#download a specific version of InSpec
hab pkg download -u "https://bldr.habitat.sh" --download-directory . chef/inspec/5.18.14/20220823064351

#download a specific version of InSpec
hab pkg download -u "https://bldr.habitat.sh" --download-directory . chef/scaffolding-chef-inspec/0.25.0/20220823082215

#download a specific version of InSpec
hab pkg download -u "https://bldr.habitat.sh" --download-directory . chef/scaffolding-chef-infra/0.25.0/20220823082225

export HAB_AUTH_TOKEN=$PRIMARY_PAT

hab pkg upload -u $PRIMARY_DEPOT -c stable ./artifacts/chef-chef-infra-client-17.10.3-20220823074032-x86_64-linux.hart
hab pkg upload -u $PRIMARY_DEPOT -c stable ./artifacts/chef-inspec-5.18.14-20220823064351-x86_64-linux.hart
hab pkg upload -u $PRIMARY_DEPOT -c stable ./artifacts/chef-scaffolding-chef-infra-0.25.0-20220823082225-x86_64-linux.hart
hab pkg upload -u $PRIMARY_DEPOT -c stable ./artifacts/chef-scaffolding-chef-inspec-0.25.0-20220823082215-x86_64-linux.hart


export HAB_AUTH_TOKEN=$SECONDARY_PAT

hab origin key download -u $LOCAL_BUILDER chef
hab origin key download -u $LOCAL_BUILDER workshop

hab pkg upload -u $LOCAL_BUILDER -c stable ./artifacts/chef-chef-infra-client-17.10.3-20220823074032-x86_64-linux.hart
hab pkg upload -u $LOCAL_BUILDER -c stable ./artifacts/chef-inspec-5.18.14-20220823064351-x86_64-linux.hart
hab pkg upload -u $LOCAL_BUILDER -c stable ./artifacts/chef-scaffolding-chef-infra-0.25.0-20220823082225-x86_64-linux.hart
hab pkg upload -u $LOCAL_BUILDER -c stable ./artifacts/chef-scaffolding-chef-inspec-0.25.0-20220823082215-x86_64-linux.hart



