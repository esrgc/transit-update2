# transit-update2
update script for shore transit site

Python and shell scripts. Schedule runs with cron. ($ crontab -e)
Will download csvs from shore tranist site, apply sql update for database from csvs, log any errors and 
clean up csvs when done.
