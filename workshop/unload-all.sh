#!/bin/bash

#!/bin/bash

hab svc unload $HAB_ORIGIN/proxy 
hab svc unload $HAB_ORIGIN/instructions 
hab svc unload $HAB_ORIGIN/build_package 
hab svc unload $HAB_ORIGIN/deploy_rollback 
hab svc unload $HAB_ORIGIN/cots
hab svc unload $HAB_ORIGIN/decentralized
hab svc unload $HAB_ORIGIN/ring
hab svc unload $HAB_ORIGIN/smart_updates
hab svc unload $HAB_ORIGIN/host_compliance
hab svc unload $HAB_ORIGIN/host_configuration
hab svc unload $HAB_ORIGIN/app_compliance
hab svc unload $HAB_ORIGIN/jenkins 