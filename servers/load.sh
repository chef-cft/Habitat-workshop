if test -z "$STUDIO_TYPE" 
then
    echo "must run inside of studio"
    exit -1
fi

. /src/env.sh

export HAB_CTL_SECRET="Ct6xkqw4kggECo1IvzappT1v5tc/T0833k42H8gvTSARPou9MIka4LURSwZQlrp7q9FJMZ4hT0pnihymcKGcLg=="

/src/servers/startup/store-1.sh
/src/servers/startup/store-2.sh
/src/servers/startup/store-3.sh