import os, subprocess, socket, sys
import ssl
from encrypt import encrypt_message
import time
import  pickle


def connect():
    try:
        global host
        global port
        global s
        global sock

        # host = '172.16.69.132'
        host = ''
        port = 9999
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # s = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1)
        print("Trying to Connect")
        s.connect((host, port))
        print("Connection Established")
        knock = encrypt_message()
        s.send(pickle.dumps(knock))
        time.sleep(1)
        receive()
    except socket.error as msg:
        print("socket error : " + str(msg[0]))


def receive():
    command = sys.argv[1]
    if command == 'quit' or command == 'exit':
        s.close()
    else:
        send(command)


def send(args):
    s.send(args)
    result = s.recv(16384)
    print(result)
    s.close()

connect()
# receive()
s.close()
