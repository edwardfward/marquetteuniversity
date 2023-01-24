# Task 1: Frequency Analysis
## [Assignment Instructions: Secret-Key Encryption Lab](https://seedsecuritylabs.org/Labs_20.04/Files/Crypto_Encryption/Crypto_Encryption.pdf)
### Steps used to decrypt the mono-alphabetic cipher

I found it difficult to compare the English language n-grams provided in `words.txt` side-by-side with the encrypted n-grams in `ciphertext.txt` using the author's Python program `freq.py`.

Also, I wanted to see four and five-letter sequences, so I decided to write my own program, `wordgram_freq.py`, to give me the ability to see plaintext and ciphertext n-grams side-by-side and the flexibility to see four or more letter sequences to find common four and five-letter sequences such as _tion_ and _action_.

Here's an example of how to use `wordgram_freq.py` from the command line:

`python wordgram_freq.py plaintextfile ciphertext file numberofngrams topxgrams`

This is the command I ran to start decrypting the cipher. The output can be seen in `freq.txt`:

`python wordgram_freq.py words.txt ciphertext.txt 5 20`



