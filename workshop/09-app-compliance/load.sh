#!/bin/bash
hab svc load $HAB_ORIGIN/app_compliance --strategy at-once --update-condition latest -f