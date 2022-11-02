#!/bin/bash
. ../env.sh

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


file=$(newest_file_matching_pattern results "$HAB_ORIGIN-ring*.hart") 
#hab pkg upload -u $PRIMARY_DEPOT -z $PRIMARY_PAT -c stable $file
hab pkg upload -u $PRIMARY_DEPOT $file
