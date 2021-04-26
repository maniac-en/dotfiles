#!/usr/bin/env python3

import argparse
import subprocess
import os
from typing import Union

DEBUG = False

# log file generated from $SYS/node_visibilty.sh
LOG_FILE = r'.cache/bspwm_node_visibility.log'
LOG_FILE_PATH = os.path.join(os.path.expanduser('~'), LOG_FILE)

def exec_cmd(cmd : list, out : bool) -> Union[None, list]:
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    proc_out, proc_err = proc.communicate()
    if DEBUG:
        print(f"{cmd}\nSTDOUT:\n{proc_out.decode()}\nSTDERR:\n{proc_err.decode()}")
    if out:
        return proc_out.decode().split('\n')[:-1]

def query_xdotool(class_name : str) -> int:
    wid_list = exec_cmd(['xdotool', 'search', '--class', class_name], True)
    for wid in wid_list:
        res = exec_cmd(['xprop', '-id', wid, '_NET_WM_DESKTOP'], True)[0]
        if "not found" not in res:
            return wid

def manage(desk_num: int, class_name: str, cmd : str) -> None:
    window_id = query_xdotool(class_name)
    if window_id:
        exec_cmd(['bspc', 'desktop', '-f', f'^{desk_num}'], False)
        exec_cmd(['xdotool', 'windowmap', window_id], False)
        exec_cmd(['sed', '-i', f'/{window_id}/d', LOG_FILE_PATH], False)
    else:
        exec_cmd(cmd, False)

valid_desktops = list(map(int, exec_cmd(['bspc', 'query', '-D', '--names'], True)))
parser = argparse.ArgumentParser(description='scratchpad manager script')
parser.add_argument('--debug', required=False, help='cmd to start app if not running already', dest='debug', action='store_true')
parser.add_argument('-d', required=True, type=int, help='desktop number that will have the app', dest='desk_num', choices = valid_desktops)
parser.add_argument('-c', required=True, type=str, help='exact or possible app class name for regex match', dest='class_name')
parser.add_argument('-x', required=True, type=str, help='cmd to start app if not running already', dest='cmd', nargs=argparse.REMAINDER, action='append')
args = parser.parse_args()
DEBUG = args.debug

# main call
manage(args.desk_num, args.class_name, args.cmd[0])
