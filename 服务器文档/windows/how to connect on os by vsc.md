1. 在windows主机上生成公钥和私钥
    ```
    ssh-keygen.exe -t rsa
    cd C:/Users/HavenLau/.ssh
    拷贝 id_rsa.pub 内容，添加到到云服务器的 ~/.ssh/authorized_keys 文件后面
    ```
2. 将公钥拷贝到Linux服务器上
    ```
    scp C:\Users\HavenLau\.ssh\id_rsa.pub bitnami@192.168.10.232:/home/bitnami/.ssh/id_rsa.pub
    cat /home/bitnami/.ssh/id_rsa.pub >> /home/bitnami/.ssh/authorized_keys
    ```

3. 在windows上安装ssh client和server(管理员启动powershell)
    ```
    Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

    # Install the OpenSSH Client
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

    # Install the OpenSSH Server
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    ``` 

4. 开启Windows作为SSH Host
    ```
    Start-Service sshd
    # OPTIONAL but recommended:
    Set-Service -Name sshd -StartupType 'Automatic'
    # Confirm the Firewall rule is configured. It should be created automatically by setup. 
    Get-NetFirewallRule -Name *ssh*
    # There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
    # If the firewall does not exist, create one
    New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    ```

5. 当使用 ssh name@server_id 远程登录服务器时，出现错误提示：Permission denied (publickey).
    >在服务器上的终端输入：sudo vim /etc/ssh/sshd_config，打开该文件。找到PasswordAuthentication，将其后的 no 改为 yes。重启ssh服务：sudo service sshd 
    
6. 离线进行 remote 开发
    + 在 [VSCode Marketplace](https://marketplace.visualstudio.com/VSCode) 下载 Remote 插件
        - Remote - WSL
        - Remote - SSH
        - Remote - SSH:Editing
    + VSCode 从 VSIX 安装 上述下载的插件
    + 离线环境下VSCode远程服务器
        ```
        cd ~
        la
        cd .vscode-server[-insiders]/bin/
        ls
        ```
    + 下载离线文件
        ```
        https://update.code.visualstudio.com/commit:ID/server-linux-x64/stable
        https://update.code.visualstudio.com/commit:ID/server-linux-x64/insider
        ```
    + 离线包下载后将其拷贝到服务器里面以ID为名字的目录里面，可能里面存在一个同名的文件，但是文件是空的，因为联网下载失败了，覆盖它就行了

5. Develop by docker Best practices🔗
    + To get the best out of the file system performance when bind-mounting files:
        1. Store source code and other data that is bind-mounted into Linux containers (i.e., with ) in the Linux filesystem, rather than the Windows filesystem.docker run -v <host-path>:<container-path>
        2. Linux containers only receive file change events (“inotify events”) if the original files are stored in the Linux filesystem.
        3. Performance is much higher when files are bind-mounted from the Linux filesystem, rather than remoted from the Windows host. Therefore avoid (where is mounted from Windows).docker run -v /mnt/c/users:/users/mnt/c Instead, from a Linux shell use a command like where is expanded by the Linux shell to .docker run -v ~/my-project:/sources <my-image>~$HOME
    + If you have concerns about the size of the docker-desktop-data VHDX, or need to change it, take a look at the WSL tooling built into Windows.
    + If you have concerns about CPU or memory usage, you can configure limits on the memory, CPU, Swap size allocated to the WSL 2 utility VM.
    + To avoid any potential conflicts with using WSL 2 on Docker Desktop, you must uninstall any previous versions of Docker Engine and CLI installed directly through Linux distributions before installing Docker Desktop.