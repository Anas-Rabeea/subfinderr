#!/usr/bin/bash

# This is a simple subdomain finder from a webpage 
# Inspired By  @Limbo0

blue='\033[0;32m'
clear='\033[0m'
red='\033[0;34m'

if [[ $# -eq 0 ]]
then
echo "How to use : ./findersh <domain>"
echo "Example : ./finder.sh nmap.org"
else
echo "*********************************************"
echo -e "Started At : ${blue} $(date) ${clear}"
wget $1  2>/dev/null && cat index.html | grep "href=" | cut -d ":" -f 2 | cut -d "/" -f 3 | grep $1 | uniq  >>domains.txt

for domain in $(cat domains.txt)
do
if [[ $(ping -c 2 $domain 2>/dev/null ) ]]
then
echo -e " $domain  --> ${red} is live ${clear} "
echo $domain >> Live_domains.txt
else
echo -e " $domain  --> ${blue} is NOT live ${clear}"
fi
done

for IP in $(cat Live_domains.txt)
do
host $IP | cut -d " " -f 4| uniq >> IPs.txt
done
rm  index.html
echo "*********************************************"
echo -e  "Finished At : ${blue} $(date) ${clear}"
fi
