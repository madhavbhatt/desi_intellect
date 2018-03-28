from Crypto.PublicKey import RSA
from Crypto.Hash import SHA256
import ast
import socket
import time


def create_plain_text_message():
    getpass = "8PQRbyjfTp+AUSUBfI6FoA"
    # s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    # s.connect(("8.8.8.8", 80))
    # ip_addr = s.getsockname()[0]
    # s.close()
    timestamp = time.time()
    ip_addr = "192.168.0.30"
    # message = str(ip_addr) + str(getpass) + str(timestamp)
    message = str(ip_addr) + str(getpass)
    return SHA256.new(message).digest()


def decrypt_message(encrypted):
    pub_key = open('/etc/desi_public_key.pem', 'r').read()
    # pub_key = open('desi_public_key.pem', 'r').read()
    public_key = RSA.importKey(str(pub_key))
    decrypted = public_key.verify(create_plain_text_message(), encrypted)
    return decrypted
