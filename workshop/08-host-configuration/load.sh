#!/bin/bash
hab svc load $HAB_ORIGIN/host_configuration --strategy at-once --update-condition latest -f