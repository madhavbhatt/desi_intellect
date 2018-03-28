import os, socket, sys
import ssl
import threading

def sock_create():
    try:
        global s
        global host
        global port
        global sock
        host = ''
        port = 9998
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # s = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1)
    except socket.error as msg:
        print("socket error : " + str(msg[0]))


def sock_bind():
    try:
        print("Binding Port ... ")
        s.bind((host, port))
        s.listen(1)
    except socket.error as msg:
        print("socket error : " + str(msg[0]))
        print("Retrying ...")
        sock_bind()


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
    threading.Thread(sock_accept()).start()
    while 1:
        command = raw_input(str(addr[0]) + '@' + str(hostname) + '>')
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
    sock_bind()
    threading.Thread(sock_accept()).start()


main()
