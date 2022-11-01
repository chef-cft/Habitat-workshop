#!/bin/bash
hab svc load $HAB_ORIGIN/cots --strategy at-once --update-condition latest -f