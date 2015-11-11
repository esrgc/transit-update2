#!/bin/bash
#
#John Talbot
#Oxford STroute update

#Schedule me in cron! (crontab -e)

###################################
#Varaibles 
PGPASSWORD="---"
#Be careful is DOWNLOALOC and wHEther of not you need to include a '/'. Check downloadST.py
LOC="/home/john/bin"
DBUSER="---"
DBHOST="----"
DATABASE="----"
########################################
logfile="StMain_"$(date +%d-%m-%y)".txt"
echo $logfile > $LOC/testst2.txt
export PGPASSWORD
/usr/bin/python /home/john/bin/updatePackage/downloadST.py
echo "Starting update: " >>$LOC/$logfile
psql -o output -U $DBUSER -h $DBHOST $DATABASE < $LOC/updatePackage/sqlop 2>> $LOC/$logfile

#remove csvs after update
cd $DOWNLOADLOC
rm $LOC/passengers_bydatesummary.csv $LOC/passenger_types.csv $LOC/shifts.csv $LOC/trips.csv $LOC/passengers_by_stop_HISTORY.csv $LOC/routes.csv $LOC/stops.csv
