#!/bin/bash

#Author memn0ps

#Run amass $1 for domains name
~/go/bin/amass enum -passive -d $1 -o amass_subdomains.txt

#Run subfinder $1 is domain name
~/go/bin/subfinder -d $1 -o subfinder_subdomains.txt

# Merge subdomains
cat amass_subdomains.txt subfinder_subdomains.txt >> unsorted_subdomains.txt

#Remove duplicate entries
sort -u unsorted_subdomains.txt -o merged_subdomains.txt

#Run shuffledns to find alive hosts
~/go/bin/shuffledns -list merged_subdomains.txt -r ~/tools/SecLists/Miscellaneous/dns-resolvers.txt -silent -o alive_subdomains.txt

#Run httprobe to find URLs
cat alive_subdomains.txt | ~/go/bin/httprobe -p http:80 -p http:443 http:8080 -p https:8443 | tee -a alive_URLs.txt

# Run gowitness to screenshot those URLs
~/go/bin/gowitness file --source=alive_URLs.txt --threads=4 --resolution="1200,750" --log-format=json --log-level=warn --timeout=60 --destination="gowitness_screenshots"

#gowitness report generate
#This should result in an report.html file with a screenshot report where screenshots are sorted using perception hashing.
~/go/bin/gowitness report generate --sort-perception 
