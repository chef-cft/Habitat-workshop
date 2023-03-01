#!/bin/bash
. ../../../env.sh
export HAB_ORIGIN="kiosk"

original=`cksum ./src/Pages/Index.original.cshtml | awk -F" " '{print $1}'`
update=`cksum ./src/Pages/Index.update.cshtml | awk -F" " '{print $1}'`
current=`cksum ./src/Pages/Index.cshtml| awk -F" " '{print $1}'`

if $original=$current; then
    #the file is the original so replace with the updated one
    echo "File is current, updating to new version"
    cp ./src/Pages/Index.update.cshtml ./src/Pages/Index.cshtml
else
    #the file is the updated one so replace with the original
    echo "File is new version, reverting to original"
    cp ./src/Pages/Index.original.cshtml ./src/Pages/Index.cshtml
fi
