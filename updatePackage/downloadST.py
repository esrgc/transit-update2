##Update python download for STroutes
##John Talbot ESRGC

import urllib2
import time
import sys

location= "/tmp/"
logloc="/home/update/transit-update2/log/"


logName = "StMain_"+(time.strftime("%d-%m-%y"))+".txt"
log=open(logloc+logName, 'w')
log.write("From: Oxford Update\nSubject: Shore Transit Update on "+str(time.strftime("%c"))+"\n")
log.write(time.strftime("%c")+"\n")
log.write("Download location is: "+location+"\n")
url= 'http://www.shoretransit.org/esrgc/'

##file_list=[##
file_list=["passengers_bystop_HISTORY.csv","passengers_bystopdetails_HISTORY.csv","passenger_types.csv","passengers_bydatesummary.csv","routes.csv","shifts.csv","stops.csv","trips.csv"]
for i in file_list:
    try:
        u=urllib2.urlopen(url+i)
##set to add '/' for $(pwd)
        f=open(location+i,'wb')
        print "downloading "+i
        f.write(u.read())
        f.close()
        log.write("Download of "+i+" complete\n")
    except Exception,e:
        log.write("Error downloading: "+i+"-   "+str(e)+"\n")
    
