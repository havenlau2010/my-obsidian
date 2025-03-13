## 启用wsl2

1. 管理员启动PowerShell启用虚拟机平台

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

2. 启用Linux子系统功能

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```

3. 安装WSL转WSL2补丁 [下载地址](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

4. 在windows商店中安装一个linux发行版
    > Ubuntu 20.04 LTS

5. wsl常用命令
    | 命令                           | 说明                                         |
    |--------------------------------|----------------------------------------------|
    | wsl -l -v                      | 已安装wsl列表                                 |
    | wsl --set-version Ubuntu       | 设置默认wsl                                   |
    | wsl --set-default-version 2    | 设置默认的wsl 版本                            |
    | wsl --set-version Ubuntu  2    | 将Ubuntu 从 wsl 转换为 wsl2                   |

6. 官方文档
    [微软官方文档](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

7. 设置静态IP
    [NIC Bridge mode](https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723)
    [Static IP on WSL 2](https://github.com/MicrosoftDocs/WSL/issues/418)
    [Microsoft/WSL/issues/](https://github.com/Microsoft/WSL/issues/)
    [manually-set-ip-linux](https://danielmiessler.com/study/manually-set-ip-linux/)
    [Static IP on WSL 2](https://github.com/MicrosoftDocs/WSL/issues/418#issuecomment-511104330)
    [Static IP on WSL 2](https://github.com/microsoft/WSL/issues/4210)

## 安装 Docker

1. 更新程序包索引并安装添加新的HTTPS仓库所需的依赖项

    ```bash
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    ```

2. 使用curl命令导入存储库的GPG密钥

    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

3. 将Docker APT存储库添加到系统中

    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

4. 安装最新版本的Docker

    ```bash
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io
    ```

5. 安装特定的Docker版本

    ```bash
    sudo apt update
    apt list -a docker-ce
    docker-ce/focal 5:19.03.9~3-0~ubuntu-focal amd64
    ```

6. 验证

    ```bash
    sudo systemctl status docker
    docker -version
    ```

7. 以非root用户身份执行Docker命令

    ```bash
    sudo usermod -aG docker $USER | sudo adduser $USER docker
    ```

8. 卸载docker

    ```bash
    docker container stop $(docker container ls -aq)
    docker system prune -a --volumes
    sudo apt purge docker-ce
    sudo apt autoremove
    ```

## 安装 Docker Compose

1. 安装

    ```bash
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    ```

2. 将可执行权限应用于文件

    ```bash
    sudo chmod +x /usr/local/bin/docker-compose
    ```

3. 验证是否安装成功

    ```bash
    docker-compose --version
    ```

## Tips

1. windows wsl 下 启动 docker
    > sudo service docker start （不是 systemctl start docker）

2. windows 运行 docker-compose up -d 报错
    > 没有将当前用户加入到docker用户组里面

    ```bash
    sudo usermod -aG docker $USER 或者 sudo adduser $USER docker
    ```

3. linux docker 配置 阿里云加速(/etc/docker/daemon.json)

    ```bash
    {
    "registry-mirrors": ["https://mmsdfvki.mirror.aliyuncs.com"]
    }
    ```

4. docker run 报错：cgroups: cannot find cgroup mount destination: unknown
    + 关闭所有的WSL 窗口
    + 用管理员打开WSL 窗口，并且执行 wsl.exe --shutdown
    + 打开一个新的WSL 窗口，执行 sudo service docker start
5. 解决wsl2 cpu和内存占用过高的问题
    + 在%UserProfile%目录下创建.wslconfig文件
    + 输入以下配置

        ```config
        [wsl2]
        memory=6GB
        swap=0
        localhostForwarding=true
        ```

    + wsl2 配置说明

    | 配置项                     | 说明                                                   |
    | ---------------------------| ----------------------------------                     |
    |kernel=<path>              | # An absolute Windows path to a custom Linux kernel.    |
    |memory=<size>              | # How much memory to assign to the WSL2 VM.             |
    |processors=<number>        | # How many processors to assign to the WSL2 VM.         |
    |swap=<size>                | # How much swap space to add to the WSL2 VM. 0 for no swap file. |
    |swapFile=<path>            | # An absolute Windows path to the swap vhd.                 |
    |localhostForwarding=<bool> | # Boolean specifying if ports bound to wildcard or localhost in the WSL2 VM should be connectable from the host via localhost:port (default true). |
    | | # <path> entries must be absolute Windows paths with escaped backslashes, for example C:\\Users\\Ben\\kernel |
    | | # <size> entries must be size followed by unit, for example 8GB or 512MB |

6. Windows常用环境变量说明

    | Environment Variable         | Path                                             |
    | -----------------------------| -------------------------------------------------|
    | %ALLUSERSPROFILE%	           | C:\ProgramData                                     |
    | %APPDATA%	                   | C:\Users\Username\AppData\Roaming |
    | %COMMONPROGRAMFILES%	       | C:\Program Files\Common Files |
    | %COMMONPROGRAMFILES(x86)%	   | C:\Program Files (x86)\Common Files |
    | %COMSPEC%	                   | C:\Windows\System32\cmd.exe |
    | %HOMEDRIVE%	               | C: |
    | %HOMEPATH%	               | C:\Users\Username |
    | %LOCALAPPDATA%	           | C:\Users\Username\AppData\Local |
    | %PROGRAMDATA%	               | C:\ProgramData |
    | %PROGRAMFILES%	           | C:\Program Files |
    | %PROGRAMFILES(X86)%	       | C:\Program Files (x86) (only in 64-bit version) |
    | %PUBLIC%	                   | C:\Users\Public |
    | %SystemDrive%	               | C: |
    | %SystemRoot%	               | C:\Windows |
    | %TEMP% and %TMP%	           | C:\Users\Username\AppData\Local\Temp |
    | %USERPROFILE%	               | C:\Users\Username |
    | %WINDIR%	                   | C:\Windows |
