#!/bin/bash
. ../../../env.sh
export HAB_ORIGIN="kiosk"

hab svc unload $HAB_ORIGIN/kiosk_ui
