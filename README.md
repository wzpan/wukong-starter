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

如果使用遇到问题，可以到 [issue 页](https://github.com/wzpan/wukong-starter/issues) 提交反馈。

## 启动开发环境

``` bash
source start.sh
```

之后就可以在这个环境中进行开发。第一次启动时顺便装一下 `pyaudio`：

``` bash
pip3 install pyaudio
```

## Linux 用户说明

Linux 用户如果在遇到这个错误：

``` 
swig: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
```

可以参考 [这篇文章](https://www.jianshu.com/p/3dbad433783f) ，创建一下软链接解决。

## Mac 用户说明

如果遇到 brew 安装软件失败，可以尝试使用清华大学的 [Homebrew 镜像](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/) 和 [Homebrew bottles 镜像](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/) 。

## Windows 用户说明

建议使用虚拟机安装 Ubuntu 来进行开发学习。如果你是这种方案，请关注上面的 [Linux用户说明](#linux-用户说明)。下面的说明仅适用于 Windows + WSL 的用户。

在执行本脚本前，你需要先启动 pulseaudio-server 。

下载解压 [pulseaudio.zip](http://hahack-1253537070.file.myqcloud.com/misc/pulseaudio.zip) 并在 CMD 里运行 bin 目录下的 pulseaudio.exe 。

