#!/bin/sh
 ## Genterate Monthly Proxy User Report ##
 # This script generates a PDF file of the montly report for each user
 # Requires package wkhtmltopdf
 ## Jason B 01/07/15 ##
 echo -n "Enter name of input file: "
 read filename
 echo -n "Enter Month for report: "
 read month
 echo -n "Enter Year for report: "
 read year
 echo -n "Username: "
 read username
 read -s -p "Password: " password
 echo "\n"
 while read line; do 
 wget -O $line$month$year.html --user=$username --password=$password --no-check-certificate
         "https://netflow.trnswrks.com/lightsquid/user_detail.cgi?year=$year&month=$month&user=$line@trnswrks.com&mode=month"
 wkhtmltopdf $line$month$year.html $line-$month-$year.pdf
 rm $line$month$year.html
 done < $filename
