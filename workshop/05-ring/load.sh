#!/bin/bash
hab svc load $HAB_ORIGIN/ring --group store1 --strategy at-once --update-condition latest -f
