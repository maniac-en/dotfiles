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

bspwm node manager script

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
    1. Execute a command and store it's output and errors.
    2. If `out` is true, return command output.
    """

    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    proc_out, proc_err = proc.communicate()
    if DEBUG:
        if not proc_out.decode():   proc_out = b"No Output"
        if not proc_err.decode():   proc_err = b"No Errors"
        print(f"\033[96m{' '.join(cmd)}")
        print(f"\033[92m{proc_out.decode()}")
        print(f"\033[91m{proc_err.decode()}")
        print('\033[0m')
    if out:
        return proc_out.decode().split('\n')[:-1]


def get_wid(class_name : str, bspwm_desk_num : int) -> Union[int, bool]:
    """
    1. Store mapped dictionary of window_id and desktop number.
    2. If dictionary is empty then return None, None.
    3. If dictionary is not empty then check if there's a window open on
    expected desktop. If yes then return window_id, True else return None, None.
    """

    wid_list = exec_cmd(['xdotool', 'search', '--class', class_name], True)
    wid_desks_map = {}
    for wid in wid_list:
        res = exec_cmd(['xprop', '-id', wid, '_NET_WM_DESKTOP'], True)[0]
        if "not found" not in res:
            wid_desks_map[wid] = int(res.split()[-1])
    if DEBUG:
        print('\033[92m'+'wid_desks_map:\t', wid_desks_map)
        print('\033[0m')
    if bool(wid_desks_map):
        for wid in wid_desks_map.keys():
            if wid_desks_map[wid] == bspwm_desk_num:
                return wid, True
    return None, None

def manage(desk_num: int, class_name: str, cmd : str) -> None:
    """
    1. Handler function to call other functions.
    2. Decides weather to invoke a new firefox session, or get hidden session
    based on window_id and is_on_expected_desktop variables.
    """

    window_id, is_on_expected_desktop = get_wid(class_name, desk_num - 1)
    if DEBUG:
        print(window_id, is_on_expected_desktop)
    if window_id:
        if is_on_expected_desktop:
            exec_cmd(['bspc', 'desktop', '-f', f'^{desk_num}'], False)
            exec_cmd(['xdotool', 'windowmap', window_id], False)
            exec_cmd(['sed', '-i', f'/{window_id}/d', LOG_FILE_PATH], False)
        else:
            exec_cmd(cmd, False)
    else:
        exec_cmd(cmd, False)

valid_desktops = list(map(int, exec_cmd(['bspc', 'query', '-D', '--names'], True)))
parser = argparse.ArgumentParser(description='bspwm node manager script')
parser.add_argument('--debug', required=False, help='cmd to start app if not running already', dest='debug', action='store_true')
parser.add_argument('-d', required=True, type=int, help='desktop number that will have the app', dest='desk_num', choices = valid_desktops)
parser.add_argument('-c', required=True, type=str, help='exact or possible app class name for regex match', dest='class_name')
parser.add_argument('-x', required=True, type=str, help='cmd to start app if not running already', dest='cmd', nargs=argparse.REMAINDER, action='append')
args = parser.parse_args()
DEBUG = args.debug

# main call
manage(args.desk_num, args.class_name, args.cmd[0])
