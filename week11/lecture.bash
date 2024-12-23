#!/bin/bash
allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d ' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" |cut -d' ' -f1)
}

function pageCount(){
count=$(echo "$allLogs" | cut -d' ' -f1,3 | sort | uniq -c)
}

function getCurlAccess(){
curlAccessCount=$(grep "curl/" "$file" | awk '{print $1, $(NF)}' | sort | uniq -c)
}

getAllLogs
ips
pageCount
getCurlAccess
echo "$curlAccessCount"
