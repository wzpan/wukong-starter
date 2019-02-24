#!/bin/bash

PWD=`pwd`

install_starter(){
    os=$1
    if [[ $os == "macos" ]]
    then
        echo "正在为您安装wukong-starter"
        brew install portaudio sox ffmpeg swig
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio
        cd ~
        wget http://hahack-1253537070.file.myqcloud.com/misc/snowboy.tar.bz2
        tar -xvjf snowboy.tar.bz2
        rm snowboy.tar.bz2
        cd ~/snowboy/swig/Python3
        make
        sudo cp _snowboydetect.so ${PWD}/snowboy/
        sudo rm -rf ~/snowboy
        sudo chmod -R 777 ${PWD}
    elif [[ $os == "linux" ]]
    then
        echo "正在为您安装wukong-starter"
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install python3 python3-pip python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio distribute
        sudo pip3 install -r requirements.txt
        sudo apt-get install python3-dev
        sudo apt-get install python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        sudo wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        sudo tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get install -y libpcre3 libpcre3-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        sudo make && sudo make install
        sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo apt-get install -y libatlas-base-dev
        cd ~
        wget http://hahack-1253537070.file.myqcloud.com/misc/snowboy.tar.bz2
        tar -xvjf snowboy.tar.bz2
        rm snowboy.tar.bz2
        cd ~/snowboy/swig/Python3
        sudo make
        sudo cp _snowboydetect.so ${PWD}/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
        sudo chmod -R 777 ${PWD}
    elif [[ $os == "win10" ]]
    then
        echo "正在为您安装wukong-starter"
        sudo add-apt-repository ppa:therealkenc/wsl-pulseaudio
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install python3 python3-pip python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio distribute
        sudo pip3 install --upgrade --ignore-installed -r requirements.txt
        sudo apt-get install python3-dev
        sudo apt-get install python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        sudo wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        sudo tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get install -y libpcre3 libpcre3-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        sudo make && sudo make install
        sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo apt-get install -y libatlas-base-dev
        cd ~
        wget http://hahack-1253537070.file.myqcloud.com/misc/snowboy.tar.bz2
        tar -xvjf snowboy.tar.bz2
        rm snowboy.tar.bz2
        cd ~/snowboy/swig/Python3
        sudo make
        sudo cp _snowboydetect.so ${PWD}/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
        sed -i '$a export PULSE_SERVER=tcp:localhost' ~/.bashrc
        source ~/.bashrc
        sudo chmod -R 777 ${PWD}
    fi
clear
echo "wukong-starter 已安装完成!"

} 


clear
echo "---------- 欢迎使用 wukong-starter 一键安装脚本 ----------"
system=$(uname -a)
os_name=(${system// / })
if [ ${os_name[0]} == "Darwin" ]
then
    read -p "您的系统是否为 MacOS? [Y/n]: " confirm
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_starter "macos"
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then   
    read -p "您的系统是否为win10子系统? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                 
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_starter "win10"
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} != "raspberrypi" ]]
then
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                                                                                                                   
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_starter "linux"
    fi
fi
