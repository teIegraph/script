#!/bin/bash
red='\033[0;31m'
bblue='\033[0;34m'
plain='\033[0m'
red(){ echo -e "\033[31m\033[01m\$1\033[0m";}
green(){ echo -e "\033[32m\033[01m\$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m\$1\033[0m";}
white(){ echo -e "\033[37m\033[01m\$1\033[0m";}
readp(){ read -p "$(yellow "\$1")" \$2;}
clear

#[[ -e /etc/hosts ]] && grep -qE '^ *172.65.251.78 gitlab.com' /etc/hosts || echo -e '\n172.65.251.78 gitlab.com' >> /etc/hosts
[[ $EUID -ne 0 ]] && su='sudo' 
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
prl=`grep PermitRootLogin /etc/ssh/sshd_config`
pa=`grep PasswordAuthentication /etc/ssh/sshd_config`
if [[ -n $prl && -n $pa ]]; then
readp "Set a custom root password:" mima
if [[ -n $mima ]]; then
echo root:$mima | $su chpasswd root
$su sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
$su sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
$su service sshd restart
green "Current VPS username: root"
green "Current VPS root password: $mima"
else
red "No input detected, enabling root account or changing root password failed." 
fi
else
red "This VPS does not support root account customization or password setting. Consider using 'sudo -i' to switch to root account before running this script." 
fi
rm -rf root.sh
