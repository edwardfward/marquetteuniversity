from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

plaintext = bytearray.fromhex('255044462d312e350a25d0d4c5d80a34')
ciphertext = bytearray.fromhex('d06bf9d0dab8e8ef880660d2af65aa82')
iv = bytearray.fromhex('09080706050403020100A2B2C2D2E2F2')

# read keys generated by modbadkeygenerator.bin
with open('keys.txt') as f:
    keys = f.readlines()

for k in keys:
    # remove the newline generated by modbadkeygenerator.bin
    k = k.strip('\n')
    key = bytearray.fromhex(k)
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    encryptor = cipher.encryptor()
    ct = encryptor.update(plaintext)
    if ct == ciphertext:
        print(f'Secret key is {key}')
        exit(0)
