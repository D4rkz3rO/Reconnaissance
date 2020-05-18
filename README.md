# Recon Profile

This is a basic `.bash_profile` which allows you to install tools of your choice and perform subdomain recon against a target of your choice.

I made this to work on my bash scripting skills, learn more about subdomain recon and contribute to the community. There is always room for improvements, so feel free to modify according to your needs. It's not perfect, but its a start.

You can add more tools to this script by creating a function which will install the tool and add it to `read_choice`, `show_menu` and `install_all` functions.

You can also add more functions with onliner commands of your choice, which will perform the tasks that you need.

For example, dirsearch, ffuff, gobuster, nmap, subdomain takeover, curl requests, screenshots, locate JavaScript files, cronjobs, backups, diff etc...

**Note: I'm still working on this from time to time, so some of the functionality may not work.**

## Usage

Download the repository 

`git clone https://github.com/memN0ps/Reconnaissance`

Copy the `.bash_profile` in your home directory (make sure you don't overwrite your existing one, so please create a backup copy)

`cp Reconnaissance/.bash_profile ~/.bash_profile`

Activate the bash profile

`source ~/.bash_profile`

Install all the tools required

`install_tools` (Recommended) or `install_all` (Blindly install all the tools)

Start your recon

Run most of the recon tools on hackerone.com

`Recon_all hackerone.com`

Check for subdomain takeovers on bugcrowd.com

`Recon_subdomain_takeover bugcrowd.com`



# References and credits

* https://www.shellhacks.com/bash-colors/
* https://misc.flogisoft.com/bash/tip_colors_and_formatting
* https://vim.fandom.com/wiki/Vim_Tips_Wiki 
* https://github.com/vitalysim/totalrecon/blob/master/total_recon.sh
* https://github.com/dunderhay/recon/blob/master/recon.sh

* https://github.com/OWASP/
* https://github.com/projectdiscovery/
* https://github.com/nahamsec
* https://github.com/tomnomnom/
* https://github.com/sensepost/
* https://github.com/michenriksen/
* https://github.com/haccer/
* https://github.com/OJ/
* https://github.com/ffuf
* https://github.com/hakluke/hakrawler
* https://github.com/maurosoria/dirsearch
