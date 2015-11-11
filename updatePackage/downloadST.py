##Update python download for STroutes
##John Talbot ESRGC

import urllib2
import time
import sys

location= "/home/john/bin" 


logName = "StMain_"+(time.strftime("%d-%m-%y"))+".txt"
log=open(location+"/"+logName, 'w')
log.write(time.strftime("%c")+"\n")
log.write("Download location is: "+location+"\n")
url= 'http://www.shoretransit.org/esrgc/'
##"passengers_bystop_HISTORY.csv" ,"passengers_bystopdetails_HISTORY.csv"

file_list=["passenger_types.csv","passengers_bydatesummary.csv","routes.csv","shifts.csv","stops.csv","trips.csv"]
for i in file_list:
    try:
        u=urllib2.urlopen(url+i)
##set to add '/' for $(pwd)
        f=open(location+"/"+i,'wb')
        print "downloading "+i
        f.write(u.read())
        f.close()
        log.write("Download of "+i+" complete\n")
    except Exception,e:
        log.write("Error downloading: "+i+"-   "+str(e)+"\n")
    
