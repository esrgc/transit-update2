#!/bin/bash
#
#John Talbot
#Oxford STroute update

#Schedule me in cron! (crontab -e)

###################################
#Varaibles 
PGPASSWORD="postgres1"
#Be careful is DOWNLOALOC and wHEther of not you need to include a '/'. Check downloadST.py
LOC="/home/update/transit-update2"
DBUSER="postgres"
DBHOST="localhost"
DATABASE="STRoute"
########################################
logfile="StMain_"$(date +%d-%m-%y)".txt"
export PGPASSWORD
/usr/bin/python $LOC/downloadST.py
echo "Starting update: " >>$LOC/log/$logfile
psql -o output -U $DBUSER -h $DBHOST $DATABASE < $LOC/sqlop 2>> $LOC/log/$logfile
echo "Done" >>$LOC/log/$logfile
count=$(wc -l /home/update/transit-update2/log/$logfile)
expectedCount="14 /home/update/transit-update2/log/$logfile"
if [ "$count" != "$expectedCount" ]; then
/usr/sbin/ssmtp johntalbot1215@gmail.com jtalbot1@gulls.salisbury.edu bedobelstein@salisbury.edu elsilva@salisbury.edu tahoang@salisbury.edu < $LOC/log/$logfile
fi
#$
##
#
#remove csvs after update

rm /tmp/passengers_bydatesummary.csv /tmp/passenger_types.csv /tmp/shifts.csv /tmp/trips.csv  /tmp/routes.csv /tmp/stops.csv /tmp/passengers_bystop_HISTORY.csv /tmp/passengers_bystopdetails_HISTORY.csv
## Now to do part 2, the SU bus thing
