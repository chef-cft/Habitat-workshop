#!/bin/bash
hab svc load $HAB_ORIGIN/build_package --strategy at-once --update-condition latest -f