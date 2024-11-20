#! /bin/bash

# Define the access log file path
logfile="/home/champuser/CSI-230/week13/fileaccesslog.txt"

# Log the current timestamp and the user accessing the file
echo "$(date) - File accessed by $(whoami)" >> fileaccesslog.txt
# Make the email
subject="Access"
body="$(cat $logfile)" 
echo -e "To: matthew.kanejimenez@mymail.champlain.edu\nSubject: $subject\n\n$body" |ssmtp matthew.kanejimenez@mymail.champlain.edu

# print for debug
cat fileaccesslog.txt
