#!/bin/bash

################## ecb ##################
# encrypt
openssl enc -aes-128-ecb -in f5.txt -out f5.bin \
  -K 00112233445566778889aabbccddeeff
openssl enc -aes-128-ecb -in f10.txt -out f10.bin \
  -K 00112233445566778889aabbccddeeff
openssl enc -aes-128-ecb -in f16.txt -out f16.bin \
  -K 00112233445566778889aabbccddeeff

echo 'ECB has the following byte counts for the three files:'
# decrypt and count bytes
openssl enc -aes-128-ecb -d -nopad -in f5.bin \
  -K 00112233445566778889aabbccddeeff | wc -c

openssl enc -aes-128-ecb -d -nopad -in f10.bin \
  -K 00112233445566778889aabbccddeeff | wc -c

openssl enc -aes-128-ecb -d -nopad -in f16.bin \
  -K 00112233445566778889aabbccddeeff | wc -c

################## CBC ##################
# encrypt
openssl enc -aes-128-cbc -in f5.txt -out f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cbc -in f10.txt -out f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cbc -in f16.txt -out f16.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708

echo 'CBC has the following byte counts for the three files:'
# decrypt and count bytes
openssl enc -aes-128-cbc -d -nopad -in f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-cbc -d -nopad -in f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-cbc -d -nopad -in f16.bin \
  -K 00112233445566778889aabbccddeeff \
   -iv 01020304050607080102030405060708 | wc -c

################## CFB ##################
# encrypt
openssl enc -aes-128-cfb -in f5.txt -out f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cfb -in f10.txt -out f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-cfb -in f16.txt -out f16.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708

echo 'CFB has the following byte counts for the three files:'
# decrypt and count bytes
openssl enc -aes-128-cfb -d -nopad -in f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-cfb -d -nopad -in f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-cfb -d -nopad -in f16.bin \
  -K 00112233445566778889aabbccddeeff \
   -iv 01020304050607080102030405060708 | wc -c

################## OFB ##################
# encrypt
openssl enc -aes-128-ofb -in f5.txt -out f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-ofb -in f10.txt -out f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708
openssl enc -aes-128-ofb -in f16.txt -out f16.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708

echo 'OFB has the following byte counts for the three files:'
# decrypt and count bytes
openssl enc -aes-128-ofb -d -nopad -in f5.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-ofb -d -nopad -in f10.bin \
  -K 00112233445566778889aabbccddeeff \
  -iv 01020304050607080102030405060708 | wc -c

openssl enc -aes-128-ofb -d -nopad -in f16.bin \
  -K 00112233445566778889aabbccddeeff \
   -iv 01020304050607080102030405060708 | wc -c

rm f5.bin f10.bin f16.bin