#!/bin/bash

PWD=$(pwd)

install_homebrew(){
    os=$1
    echo "正在为您安装homebrew"
    if [[ $os == "macos" ]]
    then        
        /usr/bin/ruby -e "$(curl -fsSL https://hahack-1253537070.file.myqcloud.com/misc/homebrew/mac/install)"
    else
	    which apt-get
	    if [[ $? -eq 0 ]]
	    then
	        sudo apt-get install -y build-essential curl file git
	    else
	        sudo yum groupinstall 'Development Tools' && sudo yum install curl file git
	    fi
        sh -c "$(curl -fsSL https://hahack-1253537070.file.myqcloud.com/misc/homebrew/linux/linux.sh)"
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    fi
    # 更换 homebrew 镜像源
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
    brew update
    echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
    source ~/.bash_profile
}

install_starter(){
    echo "正在为您安装wukong-starter"
    brew install portaudio sox ffmpeg swig python3    
    pip3 install --upgrade pip
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    pip3 install virtualenv
    cd ${PWD}
    # 创建一个名为 wukong 的 virtualenv
    virtualenv --no-site-packages wukong
    pip3 install pyaudio
    # 安装其他依赖
    cd ~
    wget http://hahack-1253537070.file.myqcloud.com/misc/snowboy.tar.bz2
    tar -xvjf snowboy.tar.bz2
    rm snowboy.tar.bz2
    cd ~/snowboy/swig/Python3
    make
    cp _snowboydetect.so ${PWD}/snowboy/
    rm -rf ~/snowboy
    
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
        install_homebrew "macos"
        install_starter
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then   
    read -p "您的系统是否为win10子系统? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                 
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_homebrew "win10"
        install_starter
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} != "raspberrypi" ]]
then
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                                                                                                                   
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_homebrew "linux"
        install_starter
    fi
fi
