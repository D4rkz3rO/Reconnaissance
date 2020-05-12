#!/bin/bash

#Author memN0ps
# Tested on Linux using Vim

# Used get_package_manager just incase it is needed for anything
PACKAGE_MANAGER=""

# Change libpcap-dev to libcap if using macosx to make sure naabu gets installed
# Programs to install
programs=(go git libpcap-dev)


# Usage function
display_usage() {
    echo "[-] This script must be run with root privileges."
    echo -e "[-] Usage: ./install.sh"
}

load_colors() {
    RED='\033[0;31m'    
    GREEN='\033[0;32m'    
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'    
    PURPLE='\033[0;35m'    
    CYAN='\033[0;36m'    
    WHITE='\033[1;37m'
    COLOR_OFF='\033[0m'
}

# Shows the main menu
show_menu() {
	clear
	
	echo -e "${RED}

                              _______                
  _____   ____   _____   ____ \   _  \ ______  ______
 /     \_/ __ \ /     \ /    \/  /_\  \\____ \/  ___/
|  Y Y  \  ___/|  Y Y  \   |  \  \_/   \  |_> >___ \ 
|__|_|  /\___  >__|_|  /___|  /\_____  /   __/____  >
      \/     \/      \/     \/       \/|__|       \/ 

	${COLOR_OFF}"

	echo -e "${GREEN}"
	echo ""
	echo "	0. Install dependencies (Go, Git, libpcap-dev)"
	echo "	1. amass"
	echo "	2. subfinder"
	echo "	3. httprobe"
	echo "	4. shuffledns"
	echo "	5. dnsprobe"
	echo "	6. naabu"
	echo "	7. gowitness"
	echo "	8. aquatone"
	echo "	9. subjack"
	echo "	10. gobuster"
	echo "	11. ffuf"
	echo "	99. Install all of the tools above"
	echo "	100. Exit"
	echo -e "${COLOR_OFF}"
}

# This functions installs tools selected by the user
read_choice() {
    read -p "Enter your choice [0-100]: " choice

    case $choice in
		0)
			# Checks for missing programs and installs them
			echo "Installing $choice"
			check_missing_programs ;;
        	1)
            		echo "Installing $choice"
			install_amass ;;

        	2)  	echo "Installing $choice"
			install_subfinder ;;

       		3)  	echo "Installing $choice"
			install_httprobe ;;

		4)	echo "Installing $choice"
			install_shuffledns ;;

		5)	echo "Installing $choice"
			install_dnsprobe ;;

		6)	echo "Installing $choice"
			install_naabu ;;

		7)	echo "Installing $choice"
			install_gowitness ;;

		8)	echo "Installing $choice"
			install_aquatone ;;

		9) 	echo "Installing $choice"
			install_subjack ;;

		10) 	echo "Installing $choice"
			install_gobuster ;;

		11) 	echo "Installing $choice"
			install_ffuf ;;

		99) 	echo "Installing All Tools"
			install_all ;;

		100) exit 0 ;;

        *)  echo "Sorry, invalid input" ;;
    esac
}

# Checks to see if a program is installed, if not then installs it based on package manager
check_missing_programs() {
	for p in "${programs[@]}"
	do
		if command -v "$p" &>/dev/null
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
	if [[ $PACKAGE_MANAGER == "apt" ]]
	then
		apt install -y $p
		pause

	# Brew
	elif [[ $PACKAGE_MANAGER == "brew" ]]
	then
		brew install $p
		pause

	#DNF
	elif [[ $PACKAGE_MANAGER == "dnf" ]]
	then
		dnf install -y $p
		pause

	# Yum
	elif [[ $PACKAGE_MANAGER == "yum" ]]
	then
		yum install -y $p
		pause

	# PKG
	elif [[ $PACKAGE_MANAGER == "pkg" ]]
	then
		pkg install -y $p
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
		PACKAGE_MANAGER="apt"

	# Brew
	elif [ -x "$(command -v brew)" ]
	then
		PACKAGE_MANAGER="brew"

	#DNF
	elif [ -x "$(command -v dnf)" ]
	then
		PACKAGE_MANAGER="dnf"

	# Yum
	elif [ -x "$(command -v yum)" ]
	then
		PACKAGE_MANAGER="yum"

	# PKG
	elif [ -x "$(command -v pkg)" ]
	then
		PACKAGE_MANAGER="pkg"

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
}

pause() {
	read -p "Press [Enter] key to continue..." ENTERKEY
}


# Main function
main() {
	# Gets the package manager and sets the global variable PACKAGE_MANAGER
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

# Check whether user had supplied -h or --help . If yes display usage 
if [[ ( $1 == "--help") ||  $1 == "-h" ]] 
then 
	display_usage
	exit 0
fi 
 
# Display usage if the script is not run as root user 
if [[ $USER != "root" ]]; then 
	echo "This script must be run as root!" 
	exit 1
fi 

main

# References
##  https://www.shellhacks.com/bash-colors/
##  https://misc.flogisoft.com/bash/tip_colors_and_formatting
##  https://vim.fandom.com/wiki/Vim_Tips_Wiki 
##  https://github.com/vitalysim/totalrecon/blob/master/total_recon.sh
