#!/bin/bash

if [ ! -f $1 ] 
then
    echo "Error: Must supply file"
    exit
fi 

while read -r line 
do
    host=`echo $line | cut -d" " -f1`
    echo "Scanning $host : $port " 
    sudo nmap -A --osscan-guess -p "*" -sS -v -oX $host.xml  --open --reason $host
    xsltproc $host.xml > $host.html
done < $1