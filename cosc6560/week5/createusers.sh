#!/bin/bash
if [ $# -eq 0 ]; then
  echo "-- createusers [line delimited file of user to create]"
  exit 0
fi

while read user; do
  echo "-----------------------"
  echo "$user"
  Password=$(pwgen -c -n -y -B -s  14 1)
  echo $Password
  echo "-----------------------"

done < $1

