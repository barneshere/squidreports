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
echo -n "Enter Start Date of Month: "
read begin
echo -n "Enter Stop Date of Month: " 
read end 
echo -n "Username: "
read username
read -s -p "Password: " password
echo "\n"
#username=
#password=
day="$begin"
while read name; do 
 while (("$day" <= "$end")); do 
if (($day < 10 )); then
  day="$(printf "%02d" $day)"
fi
 wget -O $name$month$day$year.html --user=$username --password=$password --no-check-certificate "https://netflow.trnswrks.com/lightsquid/user_detail.cgi?year=$year&month=$month&day=$day&user=$name@trnswrks.com"
wkhtmltopdf $name$month$day$year.html $name-$month-$day-$year.pdf
rm $name$month$day$year.html
day=`echo $day|sed 's/^0*//'`
day=$((day+1))
done
pdfunite $name* $name-$month-$year.pdf
day="$begin"
while (("$day" <= "$end")); do 
if (($day < 10 )); then
  day="$(printf "%02d" $day)"
fi
rm $name-$month-$day-$year.pdf
day=`echo $day|sed 's/^0*//'`
day=$((day+1))
done
day="$begin"
done < $filename
