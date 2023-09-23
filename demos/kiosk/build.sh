#!/bin/bash
#export HAB_ORIGIN="kiosk"

cd 00-proxy
build
cd ..

cd 01-ui
build
cd ..

cd 02-cart
build
cd ..

cd 03-processor
build
cd ..

cd 04-store
build
cd ..

cd 05-inventory
build
cd ..

cd 06-meta
build
cd ..

cd 07-coupons
build
cd ..

cd 08-hostCompliance
build
cd ..

cd 09-appCompliance
build
cd ..

cd 10-hostConfig
build
cd ..

cd 11-discover
build
cd ..
