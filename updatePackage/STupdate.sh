#!/bin/bash
#
#John Talbot
#Oxford STroute update

#Schedule me in cron! (crontab -e)

###################################
#Varaibles 
PGPASSWORD="-----"
#Be careful is DOWNLOALOC and wHEther of not you need to include a '/'. Check downloadST.py
LOC="/home/johntalbot/bin"
DBUSER="----"
DBHOST="localhost"
DATABASE="STRoute"
########################################
logfile="StMain_"$(date +%d-%m-%y)".txt"
export PGPASSWORD
/usr/bin/python /home/johntalbot/bin/transit-update2/updatePackage/downloadST.py
echo "Starting update: " >>$LOC/$logfile
psql -o output -U $DBUSER -h $DBHOST $DATABASE < $LOC/transit-update2/updatePackage/sqlop 2>> $LOC/$logfile
echo "Done" >>$LOC/$logfile 
/usr/sbin/ssmtp johntalbot1215@gmail.com jtalbot1@gulls.salisbury.edu bedobelstein@salisbury.edu elsilva@salisbury.edu tahoang@salisbury.edu < /home/johntalbot/bin/$logfile
#remove csvs after update
cd $DOWNLOADLOC
rm $LOC/passengers_bydatesummary.csv $LOC/passenger_types.csv $LOC/shifts.csv $LOC/trips.csv $LOC/passengers_by_stop_HISTORY.csv $LOC/routes.csv $LOC/stops.csv

