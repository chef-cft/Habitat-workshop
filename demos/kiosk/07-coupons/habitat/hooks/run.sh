#cd "{{pkg.svc_var_path}}/www" || exit


EXEC="{{pkgPathFor "core/curl"}}/bin/curl" 
PKG={{pkg.path}}
FILE="$PKG/coupons-{{cfg.coupon}}.json"

COMMAND="$EXEC -v -H 'Content-Type: application/json' -H 'Accept: application/json' --data-binary @$FILE http://localhost:8004/"



attempts=0
max_attempts=10
sleep_attempt=15
sleep_success=10

echo "Starting update for coupon data (max attempts = $max_attempts)"
echo "------"
cat $FILE
echo "\n"
echo "------"
echo $COMMAND
echo "------"
until [ "$attempts" -ge $max_attempts ]
do
   echo "Updating coupons."
   $COMMAND && break  # substitute your command here
   attempts=$((attempts+1)) 
   echo "Update coupon failed, attempt #$attempts of $max_attempts... Will try again in $sleep_attempt seconds."
   sleep 15
done

if [ "$attempts" -ge $max_attempts ] 
then
    echo "attempts ($attempts) expired"
    exit 1
fi

echo "Updating coupons successful."
while true; do
   sleep $sleep_success
 done
