#download a specific version of Tomcat and Java Corretto
hab pkg download -u "https://bldr.habitat.sh" core/tomcat8/8.5.9/20200403130237
hab pkg upload -u $PRIMARY_DEPOT -c stable core/tomcat8/8.5.9/20200403130237

#download a specific version of Java Corretto
hab pkg download -u "https://bldr.habitat.sh" core/corretto/11.0.2.9.3

#download a specific version of Infra Client
hab pkg download -u "https://bldr.habitat.sh" chef/chef-infra-client/17.10.3/20220823074032

#download a specific version of InSpec
hab pkg download -u "https://bldr.habitat.sh" chef/inspec/5.18.14/20220823064351

corretto11