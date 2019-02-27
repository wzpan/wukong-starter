#!/bin/bash

function check_and_install_python {    
    if ! command -v python3 >/dev/null; then
        echo "准备安装python3"
        if command -v apt-get >/dev/null; then
            sudo apt-get install -y python3
            if [[ $? -eq 0 ]]; then
                echo "安装python3成功"
            else
                echo "安装python3失败"
                exit 1
            fi
        elif command -v yum >/dev/null; then
            sudo yum update
            sudo yum install -y python3
            if [[ $? -eq 0 ]]; then
                echo "安装python3成功"
            else
                echo "安装python3失败"
                exit 1
            fi
        else
            echo "安装python3失败：不支持的系统类型"
            exit 1
        fi
    fi
}

echo "---------- 欢迎使用 wukong-starter 一键安装脚本 ----------"
system=$(uname -a)
os_name=(${system// / })
if [ ${os_name[0]} == "Darwin" ]
then
    read -p "您的系统是否为 MacOS? [Y/n]: " confirm
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "安装失败：系统检测错误，已退出安装"
        exit
    else
        python ./scripts/install.py 1
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then   
    read -p "您的系统是否为win10子系统? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "安装失败：系统检测错误，已退出安装"
        exit 1
    else
        check_and_install_python
        python3 ./scripts/install.py 2
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} != "raspberrypi" ]]
then
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "安装失败，系统检测错误，已退出安装，请反馈给作者"
        exit 1
    else
        check_and_install_python
        python3 ./scripts/install.py 0
    fi
fi
