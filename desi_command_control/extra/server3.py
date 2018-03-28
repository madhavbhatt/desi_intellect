import socket, sys, time


connections = {}


class Socket:

    def __init__(self):
        pass

    def set_attr(self, interface, port):
        self.interface = interface
        self.port = port

    global s
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def create_socket(self):
        try:
            s.bind((self.interface, self.port))
            s.listen(1)
        except socket.error as error_message:
            print(" Failed to Bind to " + str(self.interface) + ":" + str(self.port) + ":" + str(error_message))
            # print("Retrying ..!!")
            # time.sleep(5)
            # self.create_socket()

    def sock_connect(self):
        global connect
        global ip_addr
        try:
            connect, ip_addr = s.accept()
            print("connection from %s:%s \n" % (ip_addr[0], ip_addr[1]))
            connections[ip_addr[0]] = ip_addr[1]
            print(connections)
            self.command_control(ip_addr[0])
        except socket.error as error_message:
            print(" Failed to Connect..!! " + str(error_message))

    def new_thread(self):
        try:
            self.sock_connect()
        except:
            print("cannot start new connection")

    def command_control(self,ip_address):
        connect.sendto("Gotcha",(ip_addr[0],ip_addr[1]))


def main():
    i = 0
    connector = Socket
    connector.set_attr('', 9999)
    connector.create_socket()
    connector.sock_connect()
    connector.new_thread()
    i += 1


if len(sys.argv) == 2:
    if sys.argv[1] == "start":
        main()
