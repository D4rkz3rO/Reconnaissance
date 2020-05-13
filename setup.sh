#!/bin/bash

#Author memN0ps and Phish aka dunderhay

# Tested on Linux using Vim

# Used get_package_manager just incase it is needed for anything
package_manager=""

# Change libpcap-dev to libcap if using macosx to make sure naabu gets installed
# Programs to install

programs=(go git libpcap-dev)

wordlists=("https://github.com/danielmiessler/SecLists" "https://github.com/fuzzdb-project/fuzzdb" "https://github.com/swisskyrepo/PayloadsAllTheThings")

# Change the path to your preference, tools directory will be created if it does not exist
tools_path="/opt/tools"

# Change the path preference, wordlists directory will be created if does not exist
wordlists_path="/opt/wordlists"


# Usage function
display_usage() {
	echo -e "$purple [-] Usage: ./setup.sh $color_off"
}

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
        echo "  0. 	Install dependencies (Go, Git, libpcap-dev)"
        echo "  1. 	amass"
        echo "  2. 	subfinder"
        echo "  3. 	httprobe"
        echo "  4. 	shuffledns"
        echo "  5. 	dnsprobe"
        echo "  6. 	naabu"
        echo "  7. 	gowitness"
        echo "  8. 	aquatone"
        echo "  9. 	subjack"
        echo "  10. 	gobuster"
        echo "  11. 	ffuf"
        echo "  12. 	hakrawler"
        echo "  99. 	Install all of the tools above"
        echo "  100. 	Exit"
        echo -e "${color_off}"
}

# This functions installs tools selected by the user
read_choice() {
	read -p "Enter your choice [0-100]: " choice

	case $choice in
	
	0)	echo "Installing $choice"
		check_missing_programs ;;
		
	1)	echo "Installing $choice"
		install_amass ;;

	2)	echo "Installing $choice"
		install_subfinder ;;

	3)  	echo "Installing $choice"
		install_httprobe ;;

	4)	echo "Installing $choice"
		install_shuffledns ;;

	5)      echo "Installing $choice"
		install_dnsprobe ;;

	6)      echo "Installing $choice"
		install_naabu ;;

	7)      echo "Installing $choice"
		install_gowitness ;;

	8)      echo "Installing $choice"
		install_aquatone ;;

	9)	echo "Installing $choice"
		install_subjack ;;

	10)	echo "Installing $choice"
		install_gobuster ;;

	11)	echo "Installing $choice"
		install_ffuf ;;

	12)	echo "Installing $choice"
		install_hakrawler ;;

	99)	echo "Installing All Tools"
		install_all ;;

	100)	exit 0 ;;

	*) 	echo "Sorry, invalid input" ;;
	
	esac
}

# Checks to see if a program is installed, if not then installs it based on package manager
check_missing_programs() {
	for p in "${programs[@]}"
	do
		if [ -x "$(command -v $p &>/dev/null)" ]
		then
		        echo "[+] $p is installed"
		        pause
		else
		        echo "[-] $p is not installed"
		        echo "[+] Installing $p"
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
		sudo brew install $p
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
		echo "[-] Error unable to find package manager"
		pause
	fi

}


# Gets the package manager
get_package_manager() {
	# Apt
	if [ -x "$(command -v apt)" ]
	then
		package_manager="apt"

	# Brew
	elif [ -x "$(command -v brew)" ]
	then
		package_manager="brew"

	#DNF
	elif [ -x "$(command -v dnf)" ]
	then
		package_manager="dnf"

	# Yum
	elif [ -x "$(command -v yum)" ]
	then
		package_manager="yum"

	# PKG
	elif [ -x "$(command -v pkg)" ]
	then
		package_manager="pkg"

	# Error
	else
		echo "[-] Error unable to find package manager"
	fi
}

# Installs amass
install_amass() {
	GO111MODULE=on go get -u -v github.com/OWASP/Amass/v3/...
}

# Installs subfinder
install_subfinder() {
	go get -u -v github.com/projectdiscovery/subfinder/cmd/subfinder
}

# Installs httprobe
install_httprobe() {
	go get -u -v github.com/tomnomnom/httprobe
}

# Installs shuffledns
install_shuffledns() {
	GO111MODULE=on go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
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

# Installs all tools
install_all() {
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
	create_tools_dir
	create_wordlists_dir 
}

# This functions creates a tools directory if it does not exist
create_tools_dir() {
	if [ -d "$tools_path" ]
	then
		echo -e "[*] $tools_path directory found $no_color"
	else
		echo -e "$blue [-] $tools_path does not exist, creating $tools_path $no_color"
		sudo mkdir -p "$tools_path"
	fi
}


# This function creates a wordlist directory if it does not exist
create_wordlists_dir() {
	if [ -d "$wordlists_path" ]
	then
		echo -e "$blue [*] $wordlists_path directory found $no_color"
	else
		echo -e "$blue [-] $wordlists_path does not exist, creating $wordlists_path $no_color"
		sudo mkdir -p "$wordlists_path"
	fi
}

pause() {
	read -p "Press [Enter] key to continue..." ENTERKEY
}

# Main function
main() {
        # Gets the package manager and sets the global variable package_manager
        get_package_manager
        
        create_tools_dir
        pause
        
        create_wordlists_dir
        pause

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

# Check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
	display_usage
	exit 0
fi 
 
main
