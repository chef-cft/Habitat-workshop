#!/bin/bash
hab svc load $HAB_ORIGIN/deploy_rollback --strategy at-once --update-condition latest -f