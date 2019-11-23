#!/bin/bash

#Author memN0ps

#Installing Amass
go get -v -u github.com/OWASP/Amass/v3/...

#Installing subfinder
go get -v -u github.com/subfinder/subfinder

#Installing aquatone
go get -v -u github.com/michenriksen/aquatone

#Installing assetfinder
go get -v -u github.com/tomnomnom/assetfinder

#Installing httprobe
go get -v -u github.com/tomnomnom/httprobe

#Installing gowitness
go get -v -u github.com/sensepost/gowitness

#Installing Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git ~/tools/
pip install -r ~/tools/Sublist3r/requirements.txt
