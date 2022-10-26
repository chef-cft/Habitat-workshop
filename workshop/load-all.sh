#!/bin/bash

hab svc load $HAB_ORIGIN/proxy --strategy at-once --update-condition latest -f
hab svc load $HAB_ORIGIN/instructions --strategy at-once --update-condition latest -f
hab svc load $HAB_ORIGIN/build_package --strategy at-once --update-condition latest -f
hab svc load $HAB_ORIGIN/deploy_rollback --strategy at-once --update-condition latest -f