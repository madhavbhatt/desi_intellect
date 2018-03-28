from __builtin__ import raw_input
from scratchpad import *
import sys
import threading

"""
def threadingConn():
    conn_thread = threading.Thread(target=sock_connect(),args=())
    conn_thread.daemon = True
    conn_thread.start()
"""

def main():
    create_socket('', 9997)
    sock_connect()
