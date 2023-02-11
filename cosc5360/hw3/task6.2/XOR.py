#!/usr/bin/python3
# Program from Computer and Internet Security 3rd Edition by Wenliang Du
# Chapter 24.5.2 pg. 578

from sys import argv

script, first, second = argv
aa = bytearray.fromhex(first)
bb = bytearray.fromhex(second)
xord = bytearray(x ^ y for x, y in zip(aa, bb))
print(xord.hex())
