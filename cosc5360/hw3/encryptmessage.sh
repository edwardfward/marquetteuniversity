#!/bin/bash

# encrypt original message
openssl enc -aes-128-ecb -in originalmessage.txt -out message_ecb.bin \
  -K 00112233445566778889aabbccddeeff
openssl enc -aes-128-cbc -in originalmessage.txt -out message_cbc.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cfb -in originalmessage.txt -out message_cfb.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-ofb -in originalmessage.txt -out message_ofb.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708