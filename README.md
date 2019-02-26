# wukong-starter

用于给 wukong-robot 提供一个初始化的教学用开发环境。

主要借鉴了 docker 的思想以及 [musistudio/wukong-robot-install-script](https://github.com/musistudio/wukong-robot-install-script)，但去除了 wukong-robot 本体。要安装 wukong-robot 的朋友请移步使用他的工具。

## 适用系统 ##

本脚本在几个平台中测试可用：

* Ubuntu 16.04
* Mac OS X
* Windows 10 上的 WSL（Windows Subsystem for Linux）

## 安装开发环境

``` bash
git clone https://github.com/wzpan/wukong-starter.git
cd wukong-starter
./install.sh
```

安装过程中，因为需要安装一些工具，可能会提示你输入 sudo 密码。另外，安装 homebrew 时需要你按回车确认，照做即可。

## 启动开发环境

``` bash
./start.sh
```

之后就可以在这个环境中进行开发。

## 整体说明

1. 如果使用遇到问题，可以到 [issue 页](https://github.com/wzpan/wukong-starter/issues) 提交反馈。
2. 运行后如果出现 **No module named 'xxx’** 可能是有 pip3 的网络原因引起的，请切换到 ~/wukong-starter/ 目录后执行以下命令:

```shell
pip3 install -r requirements.txt 
```

如果是 win10 子系统，请执行以下命令:

```shell
pip3 install --upgrade --ignore-installed -r requirements.txt
```

## Windows 用户说明

在执行本脚本前，你需要先启动 pulseaudio-server 。

下载解压 [pulseaudio.zip](http://hahack-1253537070.file.myqcloud.com/misc/pulseaudio.zip) 并在 CMD 里运行 bin 目录下的 pulseaudio.exe 。
