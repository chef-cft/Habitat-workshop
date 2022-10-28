#!/bin/bash

hab svc unload $HAB_ORIGIN/proxy
hab svc unload $HAB_ORIGIN/instructions
hab svc unload $HAB_ORIGIN/build_package
hab svc unload $HAB_ORIGIN/deploy_rollback
