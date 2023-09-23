#!/bin/bash
#export HAB_ORIGIN="kiosk"

cd 00-proxy
hab svc load $HAB_ORIGIN/kiosk_proxy --strategy at-once --update-condition latest -f
cd ..

cd 01-ui
hab svc load $HAB_ORIGIN/kiosk_ui --strategy at-once --update-condition latest -f --shutdown-timeout 600 
cd ..

cd 02-cart
hab svc load $HAB_ORIGIN/kiosk_cart --strategy at-once --update-condition latest -f
cd ..

cd 03-processor
hab svc load $HAB_ORIGIN/kiosk_processor --strategy at-once --update-condition latest -f
cd ..

cd 04-store
hab svc load $HAB_ORIGIN/kiosk_store --strategy at-once --update-condition latest -f
cd ..

cd 05-inventory
hab svc load $HAB_ORIGIN/kiosk_inventory --strategy at-once --update-condition latest -f
cd ..

cd 06-meta
hab svc load $HAB_ORIGIN/kiosk_meta --strategy at-once --update-condition latest -f
cd ..

cd 07-coupons
hab svc load $HAB_ORIGIN/kiosk_coupons --strategy at-once --update-condition latest -f
cd ..

cd 08-hostCompliance
hab svc load $HAB_ORIGIN/kiosk_hostCompliance --strategy at-once --update-condition latest -f
cd ..

cd 09-appCompliance
hab svc load $HAB_ORIGIN/kiosk_appCompliance --strategy at-once --update-condition latest -f
cd ..

cd 10-hostConfig
hab svc load $HAB_ORIGIN/kiosk_hostConfig --strategy at-once --update-condition latest -f
cd ..

cd 11-discover
hab svc load $HAB_ORIGIN/kiosk_discover --strategy at-once --update-condition latest -f
cd ..
