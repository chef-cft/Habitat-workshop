#!/bin/bash
. ../../env.sh

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

newest_file_matching_pattern(){ 
    find $1 -name "$2" -print0 | xargs -0 ls -1 -t | head -1  
} 

. ../env.sh
export HAB_AUTH_TOKEN=$PRIMARY_PAT
hab pkg download -u $PRIMARY_DEPOT --download-directory . workshop/decentralized -c store-3

file=$(newest_file_matching_pattern artifacts "$HAB_ORIGIN-decentralized*.hart") 

export HAB_AUTH_TOKEN=$SECONDARY_PAT
hab origin key download -u $LOCAL_BUILDER workshop

hab pkg upload -u $LOCAL_BUILDER -c store-3 "./artifacts/$file"