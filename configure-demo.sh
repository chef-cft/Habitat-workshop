#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

. ./env.sh

cd workshop
./build-all.sh
./publish-all.sh
cd ..

exit