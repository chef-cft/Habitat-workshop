#!/bin/bash

cd 00-proxy
hab studio build
cd ..

cd 00-workshop-instructions
hab studio build
cd ..

cd 01-build-and-package
hab studio build
cd ..

cd 02-deploy-rollback
hab studio build
cd ..

cd 03-cots
hab studio build
cd ..

cd 04-decentralized
hab pstudiokg build
cd ..

cd 05-ring
hab studio build
cd ..

cd 06-smart-updates
hab studio build
cd ..

cd 07-host-compliance
hab studio build
cd ..

cd 08-host-configuration
hab studio build
cd ..

cd 09-app-compliance
hab studio build
cd ..

cd 10-jenkins
hab studio build
cd ..