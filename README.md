# nmaq

`nmaq` a play on `nmap` but with q for **quaint** instead is a tool to bulk run detailed nmap scans against a list of ip's or hostnames specified in the `nmaq.list` file.

> **WARNING** : Be CAREFUL and HAVE PERMISSION to run scans against production hosts.  It it quite possible that one or more of such hosts could be running [fail2ban](https://www.fail2ban.org) or an equivalent and you will effectively lock yourself out of all the hosts with one press of the ENTER key!

## Requirements
```
sudo apt install nmap xsltproc
# It is a good idea to check the github repo for a more up to date version
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
sudo apt install ./wkhtmltox_0.12.6-1.bionic_amd64.deb --install-recommends
```

## Installation
`nmaq` is a simple shell script with an accompanying .list file.  It may be downloaded and installed b cloning this repository.



Usage
```
Usage nmaq [OPTION]... [FILE]
   Scans the list of ip's or url's provided in a file using nmap
   and produces .html and .pdf reports.

  OPTIONS:
    -f, --file      supply file name with ip's or urls to test

    -v, --verbose   display vebose details and progress bar.
    -q, --quiet     produces no terminal output
        --help      display this help and exit
        --version   display version and exit

  Example:
      nmaq -f myip.list
```

> `namq.list` is just a file of IP's, one per line with a space on the end of each line.

---
(c) Copyright 2019-2022, Bank-Builder. Licensed under open source MIT license.