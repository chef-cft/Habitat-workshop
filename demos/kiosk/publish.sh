#!/bin/bash
. ../../env.sh
export HAB_ORIGIN="kiosk"

if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

if test -z "$PRIMARY_DEPOT" 
then
      echo "\$PRIMARY_DEPOT needs to be set"
      exit -1
fi

if test -z "$LOCAL_BUILDER" 
then
      echo "\$LOCAL_BUILDER needs to be set"
      exit -1
fi

if test -z "$PRIMARY_PAT" 
then
      echo "\$PRIMARY_PAT needs to be set"
      exit -1
fi

if test -z "$SECONDARY_PAT" 
then
      echo "\$SECONDARY_PAT needs to be set"
      exit -1
fi

newest_file_matching_pattern(){ 
    find $1 -name "$2" -print0 | xargs -0 ls -1 -t | head -1  
} 


cd 00-proxy
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_proxy*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file

    HAB_AUTH_TOKEN=$SECONDARY_PAT
    hab pkg upload -u $LOCAL_BUILDER -c stable $file
cd ..

cd 01-ui
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_ui*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 02-cart
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_cart*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file   
    hab pkg promote -u $PRIMARY_DEPOT $package production
    hab pkg promote -u $PRIMARY_DEPOT $package qa
    hab pkg promote -u $PRIMARY_DEPOT $package dev
cd ..

cd 03-processor
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_processor*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 04-store
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_store*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package store-1
    hab pkg promote -u $PRIMARY_DEPOT $package store-2
    hab pkg promote -u $PRIMARY_DEPOT $package store-3

    HAB_AUTH_TOKEN=$SECONDARY_PAT
    hab pkg upload -u $LOCAL_BUILDER -c stable $file
    hab pkg promote -u $LOCAL_BUILDER $package store-3
cd ..

cd 05-inventory
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_inventory*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package store-1
    hab pkg promote -u $PRIMARY_DEPOT $package store-2
    hab pkg promote -u $PRIMARY_DEPOT $package store-3
cd ..

cd 06-meta
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_meta*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
cd ..

cd 07-coupons
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_coupons*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package s1d1
    hab pkg promote -u $PRIMARY_DEPOT $package s1d2
    hab pkg promote -u $PRIMARY_DEPOT $package s2d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d2
cd ..

cd 08-hostCompliance
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_hostCompliance*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package s1d1
    hab pkg promote -u $PRIMARY_DEPOT $package s1d2
    hab pkg promote -u $PRIMARY_DEPOT $package s2d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d2
cd ..

cd 09-appCompliance
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_appCompliance*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package s1d1
    hab pkg promote -u $PRIMARY_DEPOT $package s1d2
    hab pkg promote -u $PRIMARY_DEPOT $package s2d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d1
    hab pkg promote -u $PRIMARY_DEPOT $package s3d2    
cd ..

cd 10-hostConfig
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_hostConfig*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package production
    hab pkg promote -u $PRIMARY_DEPOT $package qa
    hab pkg promote -u $PRIMARY_DEPOT $package dev    
cd ..


cd 11-discover
    file=$(newest_file_matching_pattern results "$HAB_ORIGIN-kiosk_discover*.hart") 
    package=${file//"results"/""}
    package=${package//"-x86_64-linux.hart"/""}
    package=${package//"-"/"/"}
    package=${package:1}

    HAB_AUTH_TOKEN=$PRIMARY_PAT
    hab pkg upload -u $PRIMARY_DEPOT -c stable $file
    hab pkg promote -u $PRIMARY_DEPOT $package production
    hab pkg promote -u $PRIMARY_DEPOT $package qa
    hab pkg promote -u $PRIMARY_DEPOT $package dev    
cd ..