import socket
import ssl


def connect(param):
    try:
        global host
        global port
        global s
        global sock
        global result
        global command
        command = param

        command = param
        host = '172.16.69.139'
        port = 9999
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # s = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1)
        print("Trying to Connect")
        s.connect((host, port))
        print("Connection Established")
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



