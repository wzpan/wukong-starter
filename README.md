# wukong-starter

用于给 wukong-robot 提供一个初始化的教学用开发环境。

主要参考了 [musistudio/wukong-robot-install-script](https://github.com/musistudio/wukong-robot-install-script)，但去除了 wukong-robot 本体。要安装 wukong-robot 的朋友请移步使用他的工具。

## 适用系统 ##

本脚本在几个平台中测试可用：

* Ubuntu 16.04
* Mac OS X
* Windows 10 上的 WSL（Windows Subsystem for Linux）


## 用法

```shell
git clone https://github.com/wzpan/wukong-starter.git
cd wukong-starter
./install.sh
```

## 整体说明

1. 如果使用遇到问题，可以到 [issue 页](https://github.com/wzpan/wukong-starter/issues) 提交反馈。
2. 运行后如果出现 **No module named 'xxx’** 可能是有 pip3 的网络原因引起的，请切换到 ~/wukong-starter/ 目录后执行以下命令:

```shell
sudo pip3 install -r requirements.txt 
```

如果是 win10 子系统，请执行以下命令:

```shell
sudo pip3 install --upgrade --ignore-installed -r requirements.txt
```

下载解压 [pulseaudio.zip](http://hahack-1253537070.file.myqcloud.com/misc/pulseaudio.zip) 并在 CMD 里运行 bin 目录下的 pulseaudio.exe 。