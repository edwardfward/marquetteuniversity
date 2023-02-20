#!/bin/bash
if [ $# -eq 0 ]; then
  echo "-- delusers [line delimited file of user to delete]"
  exit 0
fi

while read -r user; do
  echo "-----------------------"
  deluser --remove-home "$user"
  echo "$user deleted"
done < "$1"