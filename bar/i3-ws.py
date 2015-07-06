#!/usr/bin/env python
import os
import sys
import subprocess
import socket
import struct
import json

def getsockpath():
    rsockpath = subprocess.check_output(["i3", "--get-socketpath"])
    sockpath = bytes.decode(rsockpath).rstrip()
    return sockpath

def connect_to_i3():
    sp = getsockpath()
    i3sock = socket.socket(socket.AF_UNIX)
    i3sock.connect(sp)
    return i3sock

def get_workspaces(socket):
    msg = struct.pack("<6sii", b'i3-ipc', 0, 1)
    socket.send(msg)
    replyhead = socket.recv(14)
    string, size, cmd = struct.unpack("<6sii", replyhead)
    rjson = socket.recv(size) 
    js = bytes.decode(rjson)
    workspaceobj = json.loads(js)
    return workspaceobj

def print_monitor(monitor):
    status = ""
    for space in monitor:
        fg = ''
        bg = ''
        if space['focused']:
            bg = 'blue'
        status += "%{{F{}}}%{{B{}}}{}%{{F}}%{{B}}".format(fg, bg, space['name'])
    return status

def print_ws(ws, monitor):
    # sort into monitor spaces
    found_spaces = []
    for space in ws:
        if monitor in space['output']:
            found_spaces.append(space)
    print(print_monitor(found_spaces))

def main():
    if sys.argv[1]: 
        monitor = sys.argv[1] 
    socket = connect_to_i3()
    aws = get_workspaces(socket)
    print_ws(aws, monitor)
    
if __name__ == '__main__':
    main()
