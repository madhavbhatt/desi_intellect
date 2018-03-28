from scratchpad import *
from scratchpad2 import *


main()


while 1:
    command = raw_input('$ ')
    if command == "quit" or command == 'exit':
        sys.exit()
    cmd = command_control(command, ip_address="172.16.69.140")
    print(cmd)