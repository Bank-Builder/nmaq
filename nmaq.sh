#!/bin/bash
# Copyright (c) 2018-2022, Andrew Turpin
# License MIT: https://opensource.org/licenses/MIT

_version="0.2"

function displayHelp(){
 echo "Usage nmaq [OPTION]... [FILE]";
 echo "   Scans the list of ip's or url's provided in a file using nmap";
 echo "   and produces .html and .pdf reports.";
 echo "";
 echo "  OPTIONS:";
 echo "    -f, --file      supply file name with ip's or urls to test";
 echo "";
 echo "    -v, --verbose   display vebose details and progress bar.";
 echo "    -q, --quiet     produces no terminal output";
 echo "        --help      display this help and exit";
 echo "        --version   display version and exit";
 echo "";
 echo "  Example:";
 echo "      nmaq -f myip.list";
 echo "";
}

function displayVersion(){
 echo "nmaq (bank-builder utils) version $_version";
 echo "Copyright (C) 2022, Bank Builder";
 echo "License MIT: https://opensource.org/licenses/MIT";
 echo "";
}

function ProgressBar {
# $1 = progress_number, $2 = total
# Author: Teddy Skarin, licensed under The Unlicense, https://github.com/fearside/ProgressBar/

    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
    # Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")
    printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"
}

function qTestFile(){
    IPLIST="$1"

    IFS=$'\n'
    total=`cat $IPLIST | wc -l`
    for iprow in $(cat $IPLIST)
    do
        host=$( echo "$iprow" |cut -d' ' -f1 );
        echo "Scanning $host" 
        sudo nmap -Pn -A --osscan-guess -p "*" -sS -oX $host.xml --stylesheet nmap.xsl --noninteractive --open --reason $host
    done
    for iprow in $(cat $IPLIST)
    do
        host=$( echo "$iprow" |cut -d' ' -f1 );
        echo "Create report for $host" 
        xsltproc $host.xml > $host.html
        #wkhtmltopdf $host.html $host.pdf
    done
}


# nmaq Main
_verbose="0"
_quiet="0"
while [[ "$#" > 0 ]]; do
    case $1 in
        --help) 
            displayHelp; exit 0;;
        --version) 
            displayVersion; exit 0;;
        -f|--file) 
            _nmaqfile="$2";
            shift;;
        -v|--verbose) 
            _verbose="1";
            ;;
        -q|--quiet) 
            _quiet="1";
            ;;            
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac; 
    shift; 
done

if [[ "$_quiet" == "0" ]]; then 
    _title="nmaq ver $_version";
fi;

if [[ -n "$_nmaqfile" ]]; then 
    qTestFile ${_nmaqfile};
fi;


echo "Try nmaq --help for help";

## End ##
