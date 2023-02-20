#!/bin/bash
if [ $# -eq 0 ]; then
  echo "-- createusers [line delimited file of user to create]"
  exit 0
fi

while read -r user; do
  echo "-----------------------"
  # generate password
  Password=$(pwgen -c -n -y -B -s  14 1)
  echo "User: $user             $Password" >> userpasswords.bin
  useradd -G students -m -e 2023-05-15 "$user"
  echo "User added...set passwd"
done < "$1"

