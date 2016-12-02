#!/bin/ksh

#REMOTE="sshpass -p <password> ssh <user>@<host> <path>/"

while true
do

${REMOTE}readcode.sh | execcode.sh

done
