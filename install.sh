#!/bin/bash

#Author memN0ps

#Installing amass
echo "Installing amass"
export GO111MODULE=on
go get -v -u github.com/OWASP/Amass/v3/...
echo "Done! amass installed"

#Installing subfinder
echo "Installing subfinder"
go get -v -u github.com/subfinder/subfinder
echo "Done! subfinder installed"

#Installing aquatone
echo "Installing aquatone"
go get -v -u github.com/michenriksen/aquatone
echo "Done! aquatone installed"

#Installing assetfinder
echo "Installing assetfinder"
go get -v -u github.com/tomnomnom/assetfinder
echo "Done! assetfinder installed"

#Installing httprobe
echo "Installing httprobe"
go get -v -u github.com/tomnomnom/httprobe
echo "Done! httprobe installed"

#Installing gowitness
echo "Installing gowitness"
go get -v -u github.com/sensepost/gowitness
echo "Done! gowitness installed"

#Installing gobuster
echo "Installing gobuster"
go get -v -u github.com/OJ/gobuster
echo "Done! gobuster installed"

#Installing sublist3r
echo "Installing sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git ~/tools/Sublist3r/
pip install -r ~/tools/Sublist3r/requirements.txt
echo "Done! sublist3r installed"

#Installing dirsearch
echo "Installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch/
echo "Done! dirsearch installed"
