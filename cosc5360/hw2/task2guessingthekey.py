from subprocess import check_output, Popen
from datetime import datetime

PLAINTEXT = '255044462d312e350a25d0d4c5d80a34'
CIPHERTEXT = 'd06bf9d0dab8e8ef880660d2af65aa82'
IV = '09080706050403020100A2B2C2D2E2F2'
CIPHER = 'aes-128-cbc'

# create binaries
Popen(f"echo '{PLAINTEXT}' | xxd -r -p > ./plaintext.txt", shell=True)

# determine search window bounded by save time and two hours prior to save
save_time = int(datetime(2018, 4, 17, 23, 8, 49).timestamp())
start_time = save_time - 60 * 60 * 2

for k in range(save_time, start_time, -1):
    key = check_output(f'./task2badkeygenerator.bin {k}', shell=True)
    cmd = f"openssl enc -{CIPHER} -e -a -in ./plaintext.txt -K {key.decode()} -iv {IV}"
    # result is saved in base64, need to take the first 16-chars and convert to hex
    cipher_out = check_output(cmd, shell=True)[:16].hex()
    print(f'{key} | {cipher_out}')
    if cipher_out == CIPHERTEXT:
        print(f'Secret key is {k}')
        break
