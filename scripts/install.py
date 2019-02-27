#!/bin/python
# -*- coding: utf-8-*-

import sys
import os
import subprocess
import logging

logging.basicConfig(level=logging.DEBUG)

ROOT = os.path.split(os.path.realpath(__file__))[0]

def execute_commands(command_list, cache_list):
    cache_length = len(cache_list)    
    cwd = os.path.join(ROOT, os.pardir)
    pwd = cwd
    new_cache_list = []
    stop_cache = False
    try:
        for i in range(len(command_list)):
            command = command_list[i].strip()
            if i < len(cache_list) and \
               command == cache_list[i] and \
               not stop_cache:
                if command.startswith('WORKDIR '):
                    cwd = command[8:].strip().replace('$PWD', pwd).replace('${PWD}', pwd)
                else:
                    logging.info("缓存命令 {}".format(command))
                new_cache_list.append(command)
            else:
                stop_cache = True
                logging.info("执行命令 {}".format(command))
                if command.startswith('RUN '):
                    cmd = command[4:].strip().replace('$PWD', pwd).replace('${PWD}', pwd)
                    res = subprocess.call([cmd], shell=True, cwd=cwd)
                    if res != 0:
                        logging.error("错误：命令 {} 执行失败！".format(command))
                        # 写入缓存
                        with open(os.path.join(ROOT, '.install_cache'), 'w') as f:
                            f.write('\n'.join(new_cache_list))
                        return False
                    else:
                        new_cache_list.append(command)
                elif command.startswith('WORKDIR '):
                    cwd = command[8:].strip().replace('$PWD', pwd).replace('${PWD}', pwd)
                    new_cache_list.append(command)
                else:
                    new_cache_list.append(command)
        return True
    except Exception as e:
        logging.error('错误：{}'.format(e))
    finally:
        # 写入缓存
        with open(os.path.join(ROOT, '.install_cache'), 'w') as f:
            f.write('\n'.join(new_cache_list))

def install():
    if len(sys.argv) <= 1:
        logging.critical("参数错误")
        return False
    t = sys.argv[1]
    cache = ""
    if os.path.exists(os.path.join(ROOT, '.install_cache')):
        with open(os.path.join(ROOT, '.install_cache'), 'r') as f:
            cache = f.read()
    cache_list = cache.split('\n')
    if str(t) == '0':
        with open(os.path.join(ROOT, 'linux.txt'), 'r') as f:
            command_list = f.read().split('\n')    
    elif str(t) == '1':
        with open(os.path.join(ROOT, 'mac.txt'), 'r') as f:
            command_list = f.read().split('\n')
    elif str(t) == '2':
        with open(os.path.join(ROOT, 'win.txt'), 'r') as f:
            command_list = f.read().split('\n')
    else:
        logging.critical("错误：不支持的系统类型")
        return False
    return execute_commands(command_list, cache_list)

if __name__ == '__main__':
    if install():
        logging.info("wukong-starter 安装成功！")
        exit(0)
    else:
        logging.error("wukong-starter 安装失败！")
        exit(1)
