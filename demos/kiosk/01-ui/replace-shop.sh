#!/bin/bash
. ../../../env.sh
export HAB_ORIGIN="kiosk"

original=`cksum ./src/Pages/Shop.original.cshtml | awk -F" " '{print $1}'`
update=`cksum ./src/Pages/Shop.update.cshtml | awk -F" " '{print $1}'`
current=`cksum ./src/Pages/Shop.cshtml| awk -F" " '{print $1}'`

if $original=$current; then
    #the file is the original so replace with the updated one
    echo "File is current, updating to new version"
    cp ./src/Pages/Shop.update.cshtml ./src/Pages/Shop.cshtml
else
    #the file is the updated one so replace with the original
    echo "File is new version, reverting to original"
    cp ./src/Pages/Shop.original.cshtml ./src/Pages/Shop.cshtml
fi
