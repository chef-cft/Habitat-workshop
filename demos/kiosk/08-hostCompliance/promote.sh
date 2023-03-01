#!/bin/bash
. ../../../env.sh
export HAB_ORIGIN="kiosk"
export PATTERN="kiosk_hostCompliance*.hart"

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


if test -z $1 
then
      echo "Please pass in the channel you would like to promote the latest build"
      exit -1
fi
channel=$1


newest_file_matching_pattern(){ 
    find $1 -name "$2" -print0 | xargs -0 ls -1 -t | head -1  
} 

file=$(newest_file_matching_pattern results "$HAB_ORIGIN-$PATTERN") 

package=${file//"results"/""}
package=${package//"-x86_64-linux.hart"/""}
package=${package//"-"/"/"}
package=${package:1}

echo "Promoting: "
echo $package
echo "to channel: $channel"


hab pkg promote -u $PRIMARY_DEPOT $package $channel

