#!/bin/bash

#Author memN0ps and Phish aka dunderhay

# Tested on Linux/Mac OSX using Vim and Visual Code

#Export the GOPATH in case it has not been done
export GOPATH=$HOME/go

# Used get_package_manager just incase it is needed for anything
package_manager=""

# Change libpcap-dev to libpcap if using macosx to make sure naabu gets installed
# Programs to install

programs=(go git libpcap-dev libpcap)

wordlists=("https://github.com/danielmiessler/SecLists" "https://github.com/fuzzdb-project/fuzzdb" "https://github.com/swisskyrepo/PayloadsAllTheThings" "https://github.com/projectdiscovery/nuclei-templates.git")

# Change the path to your preference, tools directory will be created if it does not exist
tools_path="$HOME/tools"

# Change the path preference, wordlists directory will be created if does not exist
wordlists_path="$HOME/tools/wordlists"


load_colors() {
    red='\033[0;31m'    
    green='\033[0;32m'    
    yellow='\033[1;33m'
    blue='\033[0;34m'    
    purple='\033[0;35m'    
    cyan='\033[0;36m'    
    white='\033[1;37m'
    color_off='\033[0m'
}

# Shows the main menu
show_menu() {
    clear

    echo -e "${red}

                              _______                
  _____   ____   _____   ____ \   _  \ ______  ______
 /     \_/ __ \ /     \ /    \/  /_\  \\____ \/  ___/
|  Y Y  \  ___/|  Y Y  \   |  \  \_/   \  |_> >___ \ 
|__|_|  /\___  >__|_|  /___|  /\_____  /   __/____  >
      \/     \/      \/     \/       \/|__|       \/ 

    ${color_off}"

    echo -e "${green}"
    echo ""
    echo "  0. Install dependencies (Go, Git, libpcap-dev, install wordlists, create tools dir) *Recommended*"
    echo "  1. amass"
    echo "  2. subfinder"
    echo "  3. httprobe"
    echo "  4. shuffledns"
    echo "  5. dnsprobe"
    echo "  6. naabu"
    echo "  7. gowitness"
    echo "  8. aquatone"
    echo "  9. subjack"
    echo "  10. gobuster"
    echo "  11. fuff"
    echo "  12. hakrawler"
    echo "  13. nuclei"
    echo "  14. dirsearch"
    echo "  99. Install all of the tools above"
    echo "  100. Exit"
    echo -e "${color_off}"
}

print_installing_choice() {
    echo -e "${red}Installing $choice ${color_off}"
}

# This functions installs tools selected by the user
read_choice() {
    # ZSH/OSX does not take 'read "<enter string here>" var' on same line
    echo -e "${yellow}Enter your choice [0-100]: ${color_off}" 
    read choice

    case $choice in
	
        0)  print_installing_choice $choice
            check_missing_programs
            create_tools_dir
            install_wordlists ;;
            
        1)  print_installing_choice $choice
            install_amass ;;

        2)  print_installing_choice $choice
            install_subfinder ;;

        3)  print_installing_choice $choice
            install_httprobe ;;

        4)  print_installing_choice $choice
            install_shuffledns ;;

        5)  print_installing_choice $choice
            install_dnsprobe ;;

        6)  print_installing_choice $choice
            install_naabu ;;

        7)  print_installing_choice $choice
            install_gowitness ;;

        8)  print_installing_choice $choice
            install_aquatone ;;

        9)  print_installing_choice $choice
            install_subjack ;;

        10) print_installing_choice $choice
            install_gobuster ;;

        11) print_installing_choice $choice
            install_ffuf ;;

        12) print_installing_choice $choice
            install_hakrawler ;;

        13) print_installing_choice $choice
            install_nuclei ;;

        14) print_installing_choice $choice
            install_dirsearch ;;

        99) print_installing_choice $choice
            install_all ;;

        100) exit 0 ;;

        *)  echo -e "${red} Sorry, invalid input ${color_off}" ;;
	
    esac
}

# Checks to see if a program is installed, if not then installs it based on package manager
check_missing_programs() {
    for p in "${programs[@]}"
    do
        if [[ -n "$(command -v $p)" ]]
        then
            echo -e "${yellow}[+] $p is installed ${color_off}"
            pause
        else
            echo -e "${yellow}[-] $p is not installed ${color_off}"
            echo -e "${yellow}[+] Installing $p ${color_off}"
            install_missing_programs "$p"
        fi
    done
}



# Install missing programs/packages/dependencies based on package manager
install_missing_programs() {
    if [[ $package_manager == "apt" ]]
    then
        sudo apt install -y $p
        pause

    # Brew
    elif [[ $package_manager == "brew" ]]
    then
        brew install $p
        pause

    #DNF
    elif [[ $package_manager == "dnf" ]]
    then
        sudo dnf install -y $p
        pause

    # Yum
    elif [[ $package_manager == "yum" ]]
    then
        sudo yum install -y $p
        pause

    # PKG
    elif [[ $package_manager == "pkg" ]]
    then
        sudo pkg install -y $p
        pause

    # Error
    else
        echo -e "${red}[-] Error unable to find package manager ${color_off}"
        pause
    fi
}


# Gets the package manager
get_package_manager() {
    # Apt
    if [[ -n "$(command -v apt-get)" ]]
    then
        package_manager="apt"

    # Brew
    elif [[ -n "$(command -v brew)" ]]
    then
        package_manager="brew"

    #DNF
    elif [[ -n "$(command -v dnf)" ]]
    then
        package_manager="dnf"

    # Yum
    elif [[ -n "$(command -v yum)" ]]
    then
        package_manager="yum"

    # PKG
    elif [[ -n "$(command -v pkg)" ]]
    then
        package_manager="pkg"

    # Error
    else
        echo -e "${red}[-] Error unable to find package manager${color_off}"
    fi
}

# Installs amass
install_amass() {
    GO111MODULE=on go get -u -v github.com/OWASP/Amass/v3/...
    pause
}

# Installs subfinder
install_subfinder() {
    go get -u -v github.com/projectdiscovery/subfinder/cmd/subfinder
    pause
}

# Installs httprobe
install_httprobe() {
    go get -u -v github.com/tomnomnom/httprobe
    pause
}

# Installs shuffledns
install_shuffledns() {
    GO111MODULE=on go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
    pause
}

# Installs dnsprobe
install_dnsprobe() {
    GO111MODULE=on go get -u -v github.com/projectdiscovery/dnsprobe
    pause
}

# Installs naabu
install_naabu() {
    go get -u -v github.com/projectdiscovery/naabu/cmd/naabu
    pause
}

# Installs gowitness
install_gowitness() {
    go get -u -v github.com/sensepost/gowitness
    pause
}

# Installs aquatone
install_aquatone() {
    go get -u -v github.com/michenriksen/aquatone
    pause
}

#Installs subjack
install_subjack() {
    go get -u -v github.com/haccer/subjack
    pause
}

# Installs gobuster
install_gobuster() {
    go get -u -v github.com/OJ/gobuster
    pause
}

# Install ffuf
install_ffuf() {
    go get -u -v github.com/ffuf/ffuf
    pause
}

# Install hakrawler
install_hakrawler() {
    go get -u -v github.com/hakluke/hakrawler
    pause
}

# Install nuclei
install_nuclei() {
    GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/cmd/nuclei
    pause
}

# Install dirsearch
install_dirsearch() {
    git -C $tools_path clone https://github.com/maurosoria/dirsearch
    pause
}

# Installs all tools and dependencies
install_all() {
    check_missing_programs
    create_tools_dir
    install_wordlists
    install_amass
    install_subfinder
    install_httprobe
    install_shuffledns
    install_dnsprobe
    install_naabu
    install_gowitness
    install_aquatone
    install_subjack
    install_gobuster
    install_ffuf
    install_hakrawler
    install_nuclei
    install_dirsearch
}

# This function creates a wordlist inside the wordlists directory
install_wordlists() {                
    create_wordlists_dir
    pause

    for p in "${wordlists[@]}"
    do
        git -C $wordlists_path clone $p
        pause
    done
}

# This functions creates a tools directory if it does not exist
create_tools_dir() {
    if [ -d "$tools_path" ]
    then
        echo -e "${blue}[*] $tools_path directory found ${color_off}"
    else
        echo -e "${blue}[-] $tools_path does not exist, creating $tools_path ${color_off}"
        mkdir -p "$tools_path"
    fi
}


# This function creates a wordlist directory if it does not exist
create_wordlists_dir() {
    if [ -d "$wordlists_path" ]
    then
        echo -e "${blue}[*] $wordlists_path directory found ${color_off}"
    else
        echo -e "${blue}[-] $wordlists_path does not exist, creating $wordlists_path ${color_off}"
        mkdir -p "$wordlists_path"
    fi
}

pause() {
    # ZSH/OSX does not take 'read "<enter string here>" var' on same line
    echo "${cyan}Press [Enter] key to continue...${color_off}"
    read  ENTERKEY
}

# Main function
install_tools() {
    # Gets the package manager and sets the global variable package_manager
    get_package_manager

    # Keeps looping through the program
    while true
    do
        # load_colors
        load_colors

        # Display the main menu
        show_menu

        # Read the choice selected by the user
        read_choice
    done
}

# This function will recon a subdomain provided and output everything inside a text files
Recon_all() {

    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_all <domain name> <gowitness screenshot directory> ${color_off}"
    else
        #Run amass $1 for domains name
        ~/go/bin/amass enum -passive -d $1 -o amass_subdomains.txt

        #Run subfinder $1 is domain name
        ~/go/bin/subfinder -d $1 -o subfinder_subdomains.txt

        # Merge subdomains
        cat amass_subdomains.txt subfinder_subdomains.txt >> unsorted_subdomains.txt

        #Remove duplicate entries
        sort -u unsorted_subdomains.txt -o subdomains.txt

        # Find A records (IPv4 addresses)
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r A -o A.txt

        # Find NS records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r NS -o NS.txt

        # Find CNAME records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r CNAME -o CNAME.txt

        # Find SOA records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r SOA -o SOA.txt

        # Find PTR records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r PTR -o PTR.txt

        # Find MX records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r MX -o MX.txt

        # Find TXT records
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r TXT -o TXT.txt

        # Find AAAA records (ipv6 addresses)
        ~/go/bin/dnsprobe -l subdomains.txt -silent -r AAAA -o AAAA.txt

        # DO TO 
        # run naabu
        # run shuffledns  

        #Run httprobe to find URLs
        cat A.txt | ~/go/bin/httprobe -p http:80 -p http:443 http:8080 -p https:8443 | tee -a alive_URLs.txt

        # Search for subdomain take overs
        ~/go/bin/nuclei -l alive_URLs.txt -t ~/tools/nuclei-templates/subdomain-takeover/detect-all-takeovers.yaml -o subdomain_takeover.txt

        if [ ! -d "$2" ]
        then
            mkdir -p $2
        else
            echo ""
        fi
        
        ~/go/bin/gowitness file --source=alive_URLs.txt --threads=4 --resolution="1200,750" --log-format=json --log-level=warn --timeout=60 --destination="$2"

        #gowitness report generate
        #This should result in an report.html file with a screenshot report where screenshots are sorted using perception hashing.
        /go/bin/gowitness report generate --sort-perception

    fi
}

# Recon for quick subdomain takeover
Recon_subdomain_takeover() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_subdomain_takeover <domain name> ${color_off}"
    else
        ~/go/bin/subfinder -d $1 | ~/go/bin/dnsprobe -silent -f domain | ~/go/bin/httprobe | ~/go/bin/nuclei -t ~/tools/nuclei-templates/subdomain-takeover/detect-all-takeovers.yaml
    fi
}

Recon_nmap_full_tcp() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_nmap_full_tcp <subdomains.txt> <output file> ${color_off}"
    else
        nmap -sC -sV -p- -iL $1 -oA $2
    fi
}

Recon_gowitness() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_gowitness <subdomains.txt> <output directory> ${color_off}"
    else
        # Run gowitness to screenshot those URLs
        mkdir -p $2
        ~/go/bin/gowitness file --source=$1 --threads=4 --resolution="1200,750" --log-format=json --log-level=warn --timeout=60 --destination="$2"
    fi
}

Recon_hakrawler() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_hakrawler <subdomains.txt> <output file> ${color_off}"
    else
        cat $1 | ~/go/bin/hakrawler $2 -scope=subs | tee $2
    fi
}

Recon_ffuf() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_ffuf <path to wordlist> <URL> <output file> ${color_off}"
    else
        ~/go/bin/ffuf -c -w $1 -u $2 -of $3
    fi
}

Recon_gobuster() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_gobuster <URL> <wordlist> <threads> <output file> ${color_off}"
    else
        ~/go/bin/gobuster dir -u $1 -w $2 -t $3 -o $4
    fi
}

Recon_dirsearch() {
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo -e "$purple[*] Example: Recon_dirsearch <URL> <wordlist> <extension> <threads> <output file> ${color_off}"
    else
        $tools_path/dirsearch/dirsearch.py -u $1 -w $2 -e $3 -t $4 --plain-text-report $5
    fi
}

# DO TO 
# run naabu
# run shuffledns  
# create more functions to recon
# nmap scans etc..
# curl requests
# cronjobs
# backups
# date/time and diff