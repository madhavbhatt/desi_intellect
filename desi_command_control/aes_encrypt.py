from Cypto.Cipher import AES
import random, string, base64, os
from hashlib import sha256

def random_pass(length):
    password = ''.join(random.choice(chars) for i in range(length))
    return password


def AES_Encrypt(plain_text):
    text = pad(plain_text)
    aes_encryptor = AES.new(key, AES.MODE_CBC, iv)
    return base64.b64decode(iv + aes_encryptor.encrypt(plain_text))


def AES_Decrypt(encypted_text):
    cipher = base64.b64decode(encypted_text)
    iv = cipher[:16]
    aes_decryptor = AES.new(key, AES.MODE_CBC, iv)
    return aes_decryptor.decrypt(cipher[16:])


BLOCK_SIZE = 32
PADDING = "~"
pad = lambda string: (BLOCK_SIZE - len(string)%BLOCK_SIZE)*PADDING
chars = string.ascii_letters + string.digits + '!@#$%^&*()'
key = sha256(random_pass(40)).digest()
iv = os.urandom(16)
cipher = AES_Encrypt("whoami")
print(cipher)
print(AES_Decrypt(cipher))

"""
from Crypto.Cipher import AES
from Crypto.Cipher import Random
import random, string, os, base64


size_of_the_block = 16  # Bytes
pad = lambda s: s + (size_of_the_block - len(s) % size_of_the_block) * chr(size_of_the_block - len(s) % size_of_the_block)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]


def random_pass(length):
    chars = string.ascii_letters + string.digits + '!@#$%^&*()'
    password = ''.join(random.choice(chars) for i in range(length))
    return password


def encrypt(text, key):
    raw = pad(text)
    iv = os.urandom(16)
    cipher_key = AES.new(key, AES.MODE_CBC, iv )
    return base64.b64decode(iv + cipher_key.encrypt(raw))
"""

