import hashlib
from Crypto.Cipher import AES
import random
import uuid
import string

pad = lambda s: s + (size_of_the_block - len(s) % size_of_the_block) * chr(size_of_the_block - len(s) % size_of_the_block)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]


def decrypt(cipher, key,iv):
    decryptor = AES.new(key, AES.MODE_CBC, iv)
    print(unpad(decryptor.decrypt(cipher)))
