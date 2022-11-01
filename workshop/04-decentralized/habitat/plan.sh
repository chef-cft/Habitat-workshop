pkg_origin=workshop
pkg_name=decentralized
pkg_description="A sample JavaEE Web app deployed in the Tomcat8 package"
pkg_version=1.0.0
pkg_maintainer="The Chef Training Team <training@chef.io>"
pkg_license=('Apache-2.0')
pkg_deps=(core/tomcat8 core/corretto11)
pkg_build_deps=(core/corretto11 core/maven)
pkg_svc_user="root"
pkg_svc_group="root"

do_prepare()
{
    export JAVA_HOME=$(hab pkg path core/corretto11)
}

do_build()
{
    cp -r $PLAN_CONTEXT/../ $HAB_CACHE_SRC_PATH/$pkg_dirname
    cd ${HAB_CACHE_SRC_PATH}/${pkg_dirname}
    mvn package
}

do_install()
{
    cp ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/target/national-parks.war ${PREFIX}/
    return 0
}
