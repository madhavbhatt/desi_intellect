from Crypto.PublicKey import RSA
from Crypto.Hash import SHA256
import time
import socket
import ast
from payload import decrypt_message


def create_plain_text_message():
    getpass = "8PQRbyjfTp+AUSUBfI6FoA"

    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip_addr = s.getsockname()[0]
    s.close()
    message = str(ip_addr) + str(getpass) + str(timestamp)
    """

    timestamp = time.time()
    ip_addr = "192.168.0.30"
    message = str(ip_addr) + str(getpass)
    return SHA256.new(message).digest()


def encrypt_message():
    private_key = RSA.importKey(open("/etc/desi_private_key.pem", "r").read())
    signed_message = private_key.sign(create_plain_text_message(), "")
    return signed_message
