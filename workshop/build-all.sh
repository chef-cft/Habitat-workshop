#!/bin/bash

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

03-cots
build
cd ..

04-decentralized
build
cd ..

05-ring
build
cd ..

06-smart-updates
build
cd ..

07-host-compliance
build
cd ..

08-host-configuration
build
cd ..

09-app-compliance
build
cd ..

10-jenkins
build
cd ..