#!/bin/bash
hab svc load $HAB_ORIGIN/proxy --strategy at-once --update-condition latest -f