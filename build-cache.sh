#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

cd shim
./build-all.sh
cd ..

cd workshop
./build-all.sh
cd ..


cd demos
cd kiosk
./build-all.sh
cd ..
cd ..


./purge.sh

exit