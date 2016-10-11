# transit-update2
Update scripts for shore transit site
<h2> ESRGC Updating Bots </h2>
Two bots run, written in python and bash
<h4> STupdate.sh </h4>
> * First bot to run 
> * Will call on downloadST.py to download the CSV from the shore transit site: http://www.shoretransit.org/esrgc/
> * Once files are downloaded, will run psql command to execute the 'sqlop' sql file on the database
> * Both the download operation and the update operation log errors to a dated log file in the log directory
> * Should the log file contain errors, an email will be dispatched using the ssmtp program
> * csvs are removed

<h4> motorPoolExtract.sh </h4>
> * Second bot to run, schedule it with enough time for STupdate to finish its job (as the download sizes grow, this may need to be extened )
> * Will check date, and depending on date will either execute a certian query or do nothing. This is due to the school break times when no information is needed for several months
> * Depending on the date, a function will be called to generate sql and execute with psql
> * This will extract certain ranges of data into a csv
> * Once extracted, the csvs are encoded and emailed using the mpack program
> * logs to the motorPoolLog.txt in the log directory

<strong> Both tasks are scheduled in a crontab file, using the superuser. $ sudo crontab -e </strong></br>
<strong> Passwords here on github are not accurate, see ESRGC file for updated credentials for database access</strong></br>
<strong> Files are downloaded to /tmp/ </strong>


