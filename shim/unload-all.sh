#!/bin/bash

#00
hab svc unload $HAB_ORIGIN/proxy 

#00
hab svc unload $HAB_ORIGIN/instructions 

#01
hab svc unload $HAB_ORIGIN/build_package 

#02
hab svc unload $HAB_ORIGIN/deploy_rollback 

#03
hab svc unload $HAB_ORIGIN/cots

#04
hab svc unload $HAB_ORIGIN/decentralized

#05
hab svc unload $HAB_ORIGIN/ring

#06
hab svc unload $HAB_ORIGIN/smart_updates

#07
hab svc unload $HAB_ORIGIN/host_compliance

#08
hab svc unload $HAB_ORIGIN/host_configuration

#09
hab svc unload $HAB_ORIGIN/app_compliance

#10
hab svc unload $HAB_ORIGIN/jenkins 