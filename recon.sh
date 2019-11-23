#!/bin/bash

#Author memN0ps

# Starting amass with configuration script
~/go/bin/amass enum -passive -config ~/config.ini -d $1 -o amass_subdomains.txt
#amass enum -passive -d $1 -o amass_subdomains.txt

# Starting subfinder
~/go/bin/subfinder -d $1 -o subfinder_subdomains.txt

# Starting assetfinder
~/go/bin/assetfinder --subs-only $1 | tee -a assetfinder_subdomains.txt

# Starting sublist3r
~/tools/Sublist3r/sublist3r.py -d $1 -o sublist3r_subdomains.txt

# Merging subdomains
cat amass_subdomains.txt >> merge.txt && cat subfinder_subdomains.txt >> merge.txt && cat assetfinder_subdomains.txt >> merge.txt && cat sublist3r_subdomains.txt >> merge.txt

# Removing duplicate entries
sort -u merge.txt -o all_subdomains.txt

# Starting httpprobe
cat all_subdomains.txt | ~/go/bin/httprobe | tee -a alive.txt

# Starting gowitness
~/go/bin/gowitness file --source=alive.txt --threads=4 --resolution="1200,750" --log-format=json --log-level=warn --timeout=60 --destination="gowitness_screenshots"

# Starting aquatone
cat all_subdomains.txt | ~/tools/aquatone/aquatone -out aquatone
