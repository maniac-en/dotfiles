#!/usr/bin/env python3

import argparse
import subprocess
import os
from typing import Union

DEBUG = False

LOG_FILE = r'.cache/bspwm_node_visibility.log'
LOG_FILE_PATH = os.path.join(os.path.expanduser('~'), LOG_FILE)

"""
usage: node_manager.py [-h] [--debug] -d {1,2,3,4,5,6,7,8,9,10} -c CLASS_NAME
                       -x ...

scratchpad manager script

optional arguments:
  -h, --help            show this help message and exit
  --debug               cmd to start app if not running already
  -d {1,2,3,4,5,6,7,8,9,10}
                        desktop number that will have the app
  -c CLASS_NAME         exact or possible app class name for regex match
  -x ...                cmd to start app if not running already
"""


def exec_cmd(cmd : list, out : bool) -> Union[None, list]:
    """
    1. execute system commans passed as `cmd` list,
    2. return list output based `out` bool
    """

    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    proc_out, proc_err = proc.communicate()
    if DEBUG:
        print(f"{cmd}\nSTDOUT:\n{proc_out.decode()}\nSTDERR:\n{proc_err.decode()}")
    if out:
        return proc_out.decode().split('\n')[:-1]


def get_wid(class_name : str) -> int:
    """
    query xdotool to get possible window id's for the given class name,
    and then find the required wid among those id's based on _NET_WM_DESKTOP.
    """

    wid_list = exec_cmd(['xdotool', 'search', '--class', class_name], True)
    for wid in wid_list:
        res = exec_cmd(['xprop', '-id', wid, '_NET_WM_DESKTOP'], True)[0]
        if "not found" not in res:
            return wid

def manage(desk_num: int, class_name: str, cmd : str) -> None:
    """
    main manager script to get command line arguments, and then
    call the required functions to get expected beheviour

    Also update the bspwm_node_visibility log file generated from
    $SYS/node_visibilty.sh script
    """

    window_id = get_wid(class_name)
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
