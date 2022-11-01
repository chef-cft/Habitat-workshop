#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

#rm cloud-formation.yml
#rm README.md
#rm -rf .git
#rm .git

find . -type f -iname "*.sh" -exec chmod +x {} \;

. ./env.sh
hab origin key download workshop
hab origin key generate workshop
hab origin key download chef

cd init
./migrate-chef-origin.sh
cd ..

cd shim
./build-all.sh
./publish-all.sh
cd ..

exit