# XOR two bytearrays
def xor(first, second):
    return bytearray(x ^ y for x,y in zip(first, second))

P1_s = 'This is a known message!'
C1_s = 'a469b1c502c1cab966965e50425438e1bb1b5f9037a4c159'
C2_s = 'bf73bcd3509299d566c35b5d450337e1bb175f903fafc159'

P1 = bytes(P1_s, 'utf-8')
C1 = bytearray.fromhex(C1_s)
C2 = bytearray.fromhex(C2_s)

P1_XOR_C1 = xor(P1, C1)
P2 = xor(P1_XOR_C1, C2)

print("P2: " + str(P2, 'utf-8'))