if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

. ../../../env.sh

export HAB_CTL_SECRET="Ct6xkqw4kggECo1IvzappT1v5tc/T0833k42H8gvTSARPou9MIka4LURSwZQlrp7q9FJMZ4hT0pnihymcKGcLg=="

/src/demos/kiosk/servers/startup/store-1.sh
/src/demos/kiosk/servers/startup/store-2.sh
/src/demos/kiosk/servers/startup/store-3.sh