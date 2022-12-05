#!/bin/bash
cd 00-proxy
hab svc unload $HAB_ORIGIN/kiosk_proxy
cd ..

cd 01-ui
hab svc unload $HAB_ORIGIN/kiosk_ui
cd ..

cd 02-cart
hab svc unload $HAB_ORIGIN/kiosk_cart
cd ..

cd 03-processor
#hab svc load $HAB_ORIGIN/kiosk_processor
cd ..

cd 04-store
hab svc unload $HAB_ORIGIN/kiosk_store
cd ..

cd 05-inventory
hab svc unload $HAB_ORIGIN/kiosk_inventory
cd ..

cd 06-meta
hab svc unload $HAB_ORIGIN/kiosk_meta
cd ..

cd 07-coupons
#hab svc load $HAB_ORIGIN/kiosk_coupons
cd ..

cd 08-hostCompliance
hab svc unload $HAB_ORIGIN/kiosk_hostCompliance
cd ..

cd 09-appCompliance
hab svc unload $HAB_ORIGIN/kiosk_appCompliance
cd ..

cd 10-hostConfig
hab svc unload $HAB_ORIGIN/kiosk_hostConfig
cd ..

cd 11-discover
hab svc unload $HAB_ORIGIN/kiosk_discover
cd ..
