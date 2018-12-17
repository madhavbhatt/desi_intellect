import os
import socket

# os.system("mkdir /opt/vectr")                                                         # uncomment this line
# os.chdir("/opt/vectr/")                                                               # uncomment this line

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
ip = s.getsockname()[0]

Path = '/etc/init.d/vectr'

schedule_service = '''

#!/bin/bash
### BEGIN INIT INFO
# Provides:         VECTR
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: start VECTR on boot
### END INIT INFO

docker-compose -f /opt/vectr/docker-compose.yml -f /opt/vectr/dev.yml -p dev up -d

'''

"""

If you want to install VECTR over HTTPS use ssl_install_VECTR. I am having issues with connecting to VECTR over HTTPS as of now.

ssl_install_VECTR = ["apt-get remove docker docker-engine docker.io -y", "apt-get update",
                     "apt-get install apt-transport-https ca-certificates curl software-properties-common -y",
                     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
                     "apt-key fingerprint 0EBFCD88",
                     'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
                     "apt-get update", "apt-get install docker-ce -y", "apt-get install unzip python-pip -y",
                     "pip install docker-compose",
                     "wget -O /opt/vectr/vectr.zip https://github.com/SecurityRiskAdvisors/VECTR/releases/download/ce-4.4.5/ce_4.4.5_20181116.zip",
                     "unzip vectr.zip", 'openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj '
                                        '"/C=SomeCountry/ST=SomeState/L=SomeLocality/O=SomeOrg/CN=SomeCommonName" -keyout '
                                        '/opt/vectr/config/ssl.key -out /opt/vectr/config/ssl.crt', "docker-compose -f "
                                                                                                    "docker-compose.yml "
                                                                                                    "-f devSsl.yml -p dev "
                                                                                                    "up "
                                                                                                    "-d", "docker ps"]
"""

install_VECTR = ["apt-get remove docker docker-engine docker.io -y", "apt-get update",
                 "apt-get install apt-transport-https ca-certificates curl software-properties-common -y",
                 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
                 "apt-key fingerprint 0EBFCD88",
                 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
                 "apt-get update", "apt-get install docker-ce -y", "apt-get install unzip python-pip -y",
                 "pip install docker-compose",
                 "wget -O /opt/vectr/vectr.zip https://github.com/SecurityRiskAdvisors/VECTR/releases/download/ce-4.4.5/ce_4.4.5_20181116.zip",
                 "unzip vectr.zip", "docker-compose -f docker-compose.yml -f dev.yml -p dev up -d", "docker ps",
                 "chmod +x " + Path, "update-rc.d vectr defaults",
                 "systemctl enable vectr"]

f = open(Path, 'w')
f.write(schedule_service)
f.close()

for command in install_VECTR:
    print ("----------------------------------------------------------------------------------------------------")
    print(command)
    # os.system(command)                                                                # uncomment this line
    print ("----------------------------------------------------------------------------------------------------")

# print (" In order to setup docker containers to start upon reboot use following command : ")
# print (" docker run -dit --restart unless-stopped <container_name> ")
print ("Go to http://" + ip + ":8081")