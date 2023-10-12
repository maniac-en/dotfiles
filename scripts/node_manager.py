#!/usr/bin/env python3

import argparse
import subprocess
import os
from typing import Union

DEBUG = False

"""
usage: node_manager.py [-h] [--debug] -c CLASS_NAME -x ...

node manager script

optional arguments:
  -h, --help            show this help message and exit
  --debug               enable script debugging
  -c CLASS_NAME         exact or possible app WM class name for regex match
  -x ...                cmd to start app if not running already
"""


def exec_cmd(cmd : list, out : bool) -> Union[None, list]:
    """
    1. Execute a command and store it's output and errors.
    2. If `out` is true, return command output.
    """

    #  print(cmd)
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    proc_out, proc_err = proc.communicate()
    #  if not proc_out.decode():   proc_out = b"No Output"
    #  if not proc_err.decode():   proc_err = b"No Errors"
    if DEBUG:
        if not proc_out.decode():   proc_out = b"No Output"
        if not proc_err.decode():   proc_err = b"No Errors"
        print(f"\033[96m{' '.join(cmd)}")
        print(f"\033[92m{proc_out.decode()}")
        print(f"\033[91m{proc_err.decode()}")
        print('\033[0m')
    if out:
        return proc_out.decode().split('\n')[:-1]


def get_wid(class_name : str) -> int:
    """
    1. Store mapped dictionary of window_id and desktop number.
    2. If dictionary is empty then return None, None.
    3. If dictionary is not empty then check if there's a window open on
    expected desktop. If yes then return window_id, True else return None, None.
    """

    wid_list = exec_cmd(['xdotool', 'search', '--class', class_name], True)
    for wid in wid_list:
        output = exec_cmd(['xprop', '-id', wid, '_NET_WM_DESKTOP'], True)[0]
        if "not found" not in output:
            if DEBUG:
                print('\033[92m'+'Found WID:\t', wid)
                print('\033[0m')
            return wid
    return None

def run_or_raise(class_name: str, cmd : str) -> None:
    """
    1. Handler function to call other functions.
    2. Decides weather to run a new session, or raise an existing session.
    """

    window_id = get_wid(class_name)
    if DEBUG:
        print(window_id)
    if window_id:
        exec_cmd(['xdotool', 'windowactivate', window_id], False)
    else:
        exec_cmd(cmd, False)

parser = argparse.ArgumentParser(description='node manager script')
parser.add_argument('--debug', required=False, help='enable script debugging', dest='debug', action='store_true')
parser.add_argument('-c', required=True, type=str, help='exact or possible app WM class name for regex match', dest='class_name')
parser.add_argument('-x', required=True, type=str, help='cmd to start app if not running already', dest='cmd', nargs=argparse.REMAINDER, action='append')
args = parser.parse_args()
DEBUG = args.debug

# main call
run_or_raise(args.class_name, args.cmd[0][0].split())
#  exec_cmd(["gnome-terminal", "--class=tmux-term", "--full-screen", "--", "/usr/local/bin/zsh", "-c", "''"], True)
