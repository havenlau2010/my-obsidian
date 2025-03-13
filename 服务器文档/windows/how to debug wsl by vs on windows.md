# 如何在windows 上用 vs 调试 wsl上发布的代码

1. 发布代码、部署到wsl上

2. 在wsl上卸载openssl-server 再从新安装

    ```bash
    sudo apt-get remove openssh-server

    sudo apt-get install openssh-server
    ```

3. 开启 ssh

    ```bash
    PasswordAuthentication no ===>>> PasswordAuthentication yes
    service ssh restart
    ```

4. 安装vsdbg

    ```bash
    sudo apt-get install unzip
    curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l ~/vsdbg
    ```
