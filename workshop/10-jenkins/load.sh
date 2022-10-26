#!/bin/bash
hab svc load $HAB_ORIGIN/jenkins --strategy at-once --update-condition latest -f