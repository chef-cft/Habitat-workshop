#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

find . -type f -iname "*.sh" -exec chmod +x {} \;

. ./env.sh
hab origin key download workshop
hab origin key generate workshop
hab origin key download chef

./build-cache.sh

cd init
./migrate-chef-origin.sh
cd ..

cd shim
./build-all.sh
#./publish-all.sh
cd ..

cd workshop

cd 00-proxy
build
./load.sh
cd ..

cd 00-workshop
build
./load.sh
cd ..

cd ..

exit