# Task 1: Frequency Analysis
## [Assignment Instructions: Secret-Key Encryption Lab](https://seedsecuritylabs.org/Labs_20.04/Files/Crypto_Encryption/Crypto_Encryption.pdf)
### Steps used to decrypt the mono-alphabetic cipher

I found it difficult to compare the English language n-grams provided in [words.txt](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/words.txt) side-by-side with the encrypted n-grams in [ciphertext.txt](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/ciphertext.txt) using the author's Python program [freq.py](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/freq.py). Plus, I wanted to see four and five-letter sequences, so I decided to write my own program, [wordgram_freq.py](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/wordgram_freq.py).

My program gives me the ability to see plaintext and ciphertext n-grams side-by-side and the option to see four or more letter sequences to find common four and five-letter sequences such as _tion_ and _action_. Here's an example of how to use `wordgram_freq.py`:

`python wordgram_freq.py plaintextfile ciphertext file numberofngrams topxgrams`

This is the command I ran to start decrypting the cipher:

`python wordgram_freq.py words.txt ciphertext.txt 5 20`

The output from the command can be seen in [freq.txt](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/freq.txt).

Using the output from the n-gram frequency analysis, it became obvious the encrypted 1-letter n-gram `n` was a substitution for the plaintext text 1-letter n-gram `E`. I continued to notice more and more patterns as the words and the subject of the message became clearer. 

While I did not use any of the four or five-letter sequence n-grams, they were helpful in spotting patterns and deciphering some of the three-letter n-grams, enabling me to speed up the decryption. The entire decryption process took me about 15-minutes once I generated the frequency analysis for the plaintext and ciphertext n-grams.

The following Bash command can be used to decipher the ciphertext:

`tr 'nvihtybxlrpmaqcfzudgeksjow' 'EALRHTFOWGDICSMVUNYBPXKQJZ' < ciphertext.txt`

The complete decrypted message about the Oscars is available in [plaintext.txt](https://github.com/edwardfward/marquetteuniversity/blob/main/cosc5360/week1/hw1/plaintext.txt)
