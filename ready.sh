#!/bin/bash

if test -z "$STUDIO_TYPE" 
then
    echo "Copying system information"
else
    echo "this command can not be run in studio"
    exit -1
fi

cp workshop/certs/* /hab/cache/ssl/*
cp ~/systeminfo.txt .