#!/bin/bash
##John Talbot June 2 2016
##Script to get the date a
star=*
##take this out
PGPASSWORD="postgres1"
export PGPASSWORD

function emailCSV(){
	#/usr/bin/zip /home/update/transit-update2/csvTmp/* testzip
	/usr/bin/mpack -s "Auto ESRGC update for motorpool busA $1 - $2 - $3" /home/update/transit-update2/csvTmp/motorpool_bus105a.csv johntalbot1215@gmail.com bedobelstein@salisbury.edu esrgc@salisbury.edu CLKirby@salisbury.edu
        /usr/bin/mpack -s "Auto ESRGC update for motorpool busR $1 - $2 - $3" /home/update/transit-update2/csvTmp/motorpool_bus105r.csv johntalbot1215@gmail.com bedobelstein@salisbury.edu esrgc@salisbury.edu CLKirby@salisbury.edu
	rm /home/update/transit-update2/csvTmp/*.csv
	echo "Motorpool complete - $1 - $2 - $3 " >> /home/update/transit-update2/log/motorPoolLog.txt  
}


function clean(){
	rm /home/update/transit-update2/sqlTmp/*
	rm /home/update/transit-update2/csvTmp/*
}

function fall(){
    echo "COPY (SELECT $star FROM motorpool_bus105a WHERE \"Date\" >= '$1-08-20' AND \"Date\" < '$1-12-25') TO '/home/update/transit-update2/csvTmp/motorpool_bus105a.csv' DELIMITER ',' CSV HEADER;" > /home/update/transit-update2/sqlTmp/tmpSQL1
    echo "COPY (SELECT $star FROM motorpool_bus105r WHERE \"Date\" >= '$1-08-20' AND \"Date\" < '$1-12-25') TO '/home/update/transit-update2/csvTmp/motorpool_bus105r.csv' DELIMITER ',' CSV HEADER;" > /home/update/transit-update2/sqlTmp/tmpSQL2
    echo "fall function"
    psql -U postgres -h localhost STRoute < /home/update/transit-update2/sqlTmp/tmpSQL1
    psql -U postgres -h localhost STRoute < /home/update/transit-update2/sqlTmp/tmpSQL2
    emailCSV $1 $2 $3
    
    exit 0
}

function spring(){
    echo "COPY (SELECT $star FROM motorpool_bus105a WHERE \"Date\" >= '$1-01-25' AND \"Date\" < '$1-05-23') TO '/home/update/transit-update2/csvTmp/motorpool_bus105a.csv' DELIMITER ',' CSV HEADER;" > /home/update/transit-update2/sqlTmp/tmpSQL1
    echo "COPY (SELECT $star FROM motorpool_bus105r WHERE \"Date\" >= '$1-01-25' AND \"Date\" < '$1-05-23') TO '/home/update/transit-update2/csvTmp/motorpool_bus105r.csv' DELIMITER ',' CSV HEADER;" > /home/update/transit-update2/sqlTmp/tmpSQL2
    echo "spring function"
    psql -U postgres -h localhost STRoute < /home/update/transit-update2/sqlTmp/tmpSQL1
    psql -U postgres -h localhost STRoute < /home/update/transit-update2/sqlTmp/tmpSQL2
    emailCSV $1 $2 $3
    exit 0 
}



month=$( date +%m )
##month="01"
day=$( date +%d )
year=$( date +%Y )
echo day $day
echo month $month
echo year $year

echo "Running motorpool $year $month $day " >> /home/update/transit-update2/log/motorPoolLog.txt

#### Determine action based on date
if [ $month = "07" ] || [ $month = "08" ]; then
    echo dead time >> /home/update/transit-update2/log/motorPoolLog.txt
    exit 0
fi

if [ $month = "06" ]; then
    if [ $day -le 15 ]; then
	spring $year $month $day
    else
	echo dead time >> /home/update/transit-update2/log/motorPoolLog.txt
	exit 0
   fi
fi
	

if [ $month = "01" ]; then
    if [ $day -le 15 ]; then
	fall $(( $year - 1 )) $month $day## test
    else
	spring $year $month $day
   fi
fi

if [ $month = "09" ] || [ $month = "10" ] || [ $month = "11" ] || [ $month = "12" ]; then
    fall $year $month $day
fi
## the only possible opetion remaining is spring
spring $year $month $day


