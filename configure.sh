#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

cp ./certs/* /hab/cache/ssl/

find . -type f -iname "*.sh" -exec chmod +x {} \;

. ./env.sh
hab origin key download workshop
hab origin key generate workshop
hab origin key download chef
hab origin create kiosk
hab origin key download kiosk
hab origin key generate kiosk

./build-cache.sh

cd init
./migrate-chef-origin.sh
cd ..

cd shim
./build-all.sh
./publish-all.sh
cd ..

cd workshop

cd 00-proxy
build
./load.sh
cd ..

cd 00-workshop-instructions
build
./load.sh
cd ..

cd ..

cd servers
./load.sh

exit