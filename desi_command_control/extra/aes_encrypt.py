"""
from Crypto.Cipher import AES
import random, string, base64, os
from hashlib import sha256


BLOCK_SIZE = 16
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
chars = string.ascii_letters + string.digits + '!@#$%^&*()'


def random_pass(length):
    password = ''.join(random.choice(chars) for i in range(length))
    return password


key = sha256(random_pass(20)).digest()
iv = os.urandom(16)
aes_encryptor = AES.new(key, AES.MODE_CBC, iv)


def AES_Encrypt(plain_text):
    return base64.b64encode(iv + aes_encryptor.encrypt(plain_text))


def AES_Decrypt(encypted_text):
    cipher = base64.b64decode(encypted_text)
    return aes_encryptor.decrypt(cipher[16:])

text = pad("whoami")
print(text)
cipher = AES_Encrypt(text)
print(cipher)
print(AES_Decrypt(cipher))

"""

from Crypto.Cipher import AES
import random, string, os, base64


BLOCK_SIZE = 16  # Bytes
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]


def random_pass(length):
    chars = string.ascii_letters + string.digits + '!@#$%^&*()'
    password = ''.join(random.choice(chars) for i in range(length))
    return password


def encrypt(text, key):
    raw = pad(text)
    iv = os.urandom(16)
    cipher_key = AES.new(key, AES.MODE_CBC, iv )
    return base64.b64encode(iv + cipher_key.encrypt(raw))


