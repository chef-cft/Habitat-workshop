#!/bin/bash

if test -z "$PRIMARY_DEPOT" 
then
      echo "\$PRIMARY_DEPOT needs to be set"
      exit -1
fi

if test -z "$PRIMARY_PAT" 
then
      echo "\$PRIMARY_PAT needs to be set"
      exit -1
fi

echo $PRIMARY_DEPOT

newest_file_matching_pattern(){ 
    find $1 -name "$2" -print0 | xargs -0 ls -1 -t | head -1  
} 


cd 00-proxy
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-proxy*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    echo $HAB_ORIGIN
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 00-workshop-instructions
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-instructions*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 01-build-and-package
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-build_package*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 02-deploy-rollback
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-deploy_rollback*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file   
    hab pkg promote -u $PRIMARY_DEPOT $package production
    hab pkg promote -u $PRIMARY_DEPOT $package qa
    hab pkg promote -u $PRIMARY_DEPOT $package dev
cd ..

cd 03-cots
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-cots*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 04-decentralized
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-decentralized*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package store-1
    hab pkg promote -u $PRIMARY_DEPOT $package store-2
    hab pkg promote -u $PRIMARY_DEPOT $package store-3
cd ..

cd 05-ring
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-ring*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package store-1
    hab pkg promote -u $PRIMARY_DEPOT $package store-2
    hab pkg promote -u $PRIMARY_DEPOT $package store-3
cd ..

cd 06-smart-updates
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-smart_updates*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 07-host-compliance
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-host_compliance*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 08-host-configuration
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-host_configuration*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 09-app-compliance
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-app_compliance*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 10-jenkins
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-jenkins*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package production
    hab pkg promote -u $PRIMARY_DEPOT $package qa
    hab pkg promote -u $PRIMARY_DEPOT $package dev    
cd ..