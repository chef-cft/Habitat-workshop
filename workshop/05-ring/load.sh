#!/bin/bash
hab svc load $HAB_ORIGIN/ring --strategy at-once --update-condition latest -f