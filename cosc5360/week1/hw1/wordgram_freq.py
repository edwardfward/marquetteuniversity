import sys


def get_freqs(filename: str, num_grams: int, top_num: int) -> []:
    num_chars_read = 0
    char_buffer = [''] * num_grams
    counter = [0] * num_grams
    # creates gram frequency bins
    gram_freqs = []

    for gram in range(num_grams):
        gram_freqs.append({})

    with open(filename, 'rb') as f:
        # read byte by byte
        while b := f.read(1):
            # filter out unwanted characters
            if b in (b'\n', b'\r', b' ', b'\t', b"'", b'.'):
                continue
            num_chars_read += 1
            b = b.lower()
            char_buffer.pop(0)
            char_buffer.append(b.decode())

            for gram in range(grams):
                if gram >= num_chars_read:
                    break
                s = ''.join(char_buffer[grams - gram - 1:])
                counter[gram] += 1
                if s in gram_freqs[gram]:
                    gram_freqs[gram][s] += 1
                else:
                    gram_freqs[gram][s] = 1

    for gram in range(num_grams):
        top_num_count = sorted(gram_freqs[gram].items(), key=lambda x: x[1], reverse=True)[:top_num]
        top_num_percent = []
        for i in range(top_num):
            top_num_percent.append((top_num_count[i][0], top_num_count[i][1] / counter[gram]))
        gram_freqs[gram] = top_num_percent
    return gram_freqs


if __name__ == '__main__':
    # python wordgram_freq library_file ciphertext_file num_grams top_num
    reference_file = sys.argv[1]
    ciphertext_file = sys.argv[2]
    grams = int(sys.argv[3])
    top = int(sys.argv[4])

    reference_grams = get_freqs(reference_file, grams, top)
    cipher_grams = get_freqs(ciphertext_file, grams, top)

    for g in range(grams):
        print('-' * 48)
        print('{}-grams'.format(g + 1))
        print('-' * 51)
        print('{:<12}'.format('Reference') + '{:>12}'.format('Percent') + ' | ' +
              '{:<12}'.format('Cipher') + '{:>12}'.format('Percent'))
        print('-' * 51)

        for c in range(top):
            print('{:<12}'.format(reference_grams[g][c][0].upper()) +
                  '{:>12.4f}%'.format(reference_grams[g][c][1]) +
                  ' | ' +
                  '{:<12}'.format(cipher_grams[g][c][0]) +
                  '{:>12.4f}%'.format(cipher_grams[g][c][1]))
