from Crypto.PublicKey import RSA
import uuid
import base64


def generate_temp_password(length):
    return base64.b64encode(uuid.uuid4().bytes).replace('=', '')


private_key = RSA.generate(2048)
public_key = private_key.publickey()

f = open('/etc/desi_private_key.pem', 'w')
f.write(private_key.exportKey('PEM'))
f.close()

f = open('/etc/desi_public_key.pem', 'w')
f.write(public_key.exportKey('PEM'))
f.close()


f = open('/etc/desi_c2_secret.txt', 'w')
passwd = generate_temp_password(20)
f.write(passwd)
f.close()
