#!/bin/bash
hab svc load $HAB_ORIGIN/smart_updates --shutdown-timeout 600 --strategy at-once --update-condition latest