#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi


cd 00-proxy
build
cd ..

cd 00-workshop-instructions
build
cd ..

cd 01-build-and-package
build
cd ..

cd 02-deploy-rollback
build
cd ..

cd 03-cots
#hab studio build
build
cd ..

cd 04-decentralized
build
cd ..

cd 05-ring
build
cd ..

cd 06-smart-updates
build
cd ..

cd 07-host-compliance
build
cd ..

cd 08-host-configuration
build
cd ..

cd 09-app-compliance
build
cd ..

cd 10-jenkins
build
cd ..