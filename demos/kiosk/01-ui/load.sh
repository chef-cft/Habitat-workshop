#!/bin/bash
. ../../../env.sh
export HAB_ORIGIN="kiosk"

hab svc load $HAB_ORIGIN/kiosk_ui --strategy at-once --update-condition latest -f --shutdown-timeout 600 