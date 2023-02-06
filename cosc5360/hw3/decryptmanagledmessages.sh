#!/bin/bash

openssl enc -aes-128-ecb -d -in message_ecb.bin -out messageout_ecb.txt \
  -K 00112233445566778889aabbccddeeff
openssl enc -aes-128-cbc -d -in message_cbc.bin -out messageout_cbc.txt \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cfb -d -in message_cfb.bin -out messageout_cfb.txt \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-ofb -d -in message_ofb.bin -out messageout_ofb.txt \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708