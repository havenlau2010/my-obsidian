[ToC]

# CentOS Web Api-Angular前后端分离项目

## 查看当前操作系统版本：

1. 查看当前操作系统版本信息 ```cat /proc/version```
2. 查看版本当前操作系统内核信息 ```uname -a```
3. linux 查看版本当前操作系统发行信息```cat /etc/centos-release 或者 cat /etc/issue```
4. 查看cpu信息 ```cat /etc/cpuinfo```
5. 查找关键字的程序 ```ps -ef | grep supervisor```
6. 查看当前监听端口 ```netstat -lnpt```
7. ```df -h```
8. ```iptables -L -n```



## CentOS 文件操作

### 1. 压缩、解压

1. 安装 zip 工具 ```yum install -y unzip zip```

2. 将.zip文件复制到CentOS /usr/bsti/applications/vls.zip

3. 将文件解压到目录 ```unzip /usr/bsti/applications/vls.zip -d vls.angular```

4. 把/home目录下面的abc文件夹和123.txt压缩成为abc123.zip

   ```zip -r abc123.zip abc 123.txt```

5. 把/home目录下面的wwwroot.zip直接解压到/home目录里面

   ```unzip wwwroot.zip```

6. 把/home目录下面的abc12.zip、abc23.zip、abc34.zip同时解压到/home目录里面

   ```unzip abc\*.zip```

7. 解压并覆盖文件

   ```unzip -o app.zip ```
   
8. [Linux目录结构和常用命令](https://www.cnblogs.com/JCSU/articles/2770249.html)

### 2.复制

 1. ```cp -r /usr/bsti/applications/vls.angular/virtual-laboratory-system/. /usr/bsti/applications/vls.angular```

 2. ```cp -r /usr/bsti/applications/vls.angular/. /usr/share/nginx/html```

### 3.删除

1. 删除文件夹及其文件 ```rm -rf /usr/bsti/applications/vls.angular```

### 4.刷新终端

1. systemctl 

### 5.端口查看

1. 是否被占用： 
   + lsof -i:80
   + netstat -tunlp|grep 80

### 6.文件检索

1. find find <指定目录> <指定条件> <指定动作>

   使用find命令搜索在根目录下的所有interfaces文件所在位置 ”find / -name  'interfaces'”

2. locate

   > 使用locate搜索linux系统中的文件，它比find命令快。因为它查询的是数据库(/var/lib/locatedb)，数据库包含本地所有的文件信息。

   使用locate命令在根目录下搜索interfaces文件的命令为”locate interfaces“

3. whereis

   > 使用”whereis“命令可以搜索linux系统中的所有可执行文件即二进制文件。

   使用whereis命令搜索grep二进制文件的命令为”whereis grep“

4. which

   > 使用which命令查看系统命令是否存在，并返回系统命令所在的位置。

   使用which命令查看grep命令是否存在以及存在的目录的命令为”which grep“

5. type

   > 使用type命令查看系统中的某个命令是否为系统自带的命令。

   使用type命令查看cd命令是否为系统自带的命令 “type cd”；查看grep 是否为系统自带的命令“type grep”。

## yum安装 docker

1. 安装 yum

   + 更新yum包 ```sudo yum update```
   + 安装需要软件包 ```sudo yum install -y yum-utils device-mapper-persistent-data lvm2```

2. 查看是否安装包

   ```
   yum list installed | grep docker
   ```

3. 查看已添加仓库

   ```yum repolist```
   
   ```yum repolist disable```
   
4. 删除已安装版本

   ```
   yum remove docker \
       docker-client \
       docker-client-latest \
       docker-common \
       docker-latest \
       docker-latest-logrotate \
       docker-logrotate \
       docker-engine
   ```

5. 安装依赖

   ```
   yum install -y yum-utils \
     device-mapper-persistent-data \
     lvm2
   ```

6. 配置仓库

   ```
   yum-config-manager \ --add-repo \ https://download.docker.com/linux/centos/docker-ce.repo
   ```

7. 查找相关镜像

   ```
   yum list docker-ce --showduplicates | sort -r
   ```

8. 安装

   ```
   yum install docker-ce docker-ce-cli containerd.io
   ```

9. 检测是否安装成功

   ```
   docker version
   ```

10. 启动docker

   ```
   systemctl start docker
   ```

11. 查看docker启动状态

    ```
    systemctl status docker 
    ```

12. docker设置阿里云镜像

    + [阿里云镜像加速器地址](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

    + 配置镜像加速器

      ```
      sudo mkdir -p /etc/docker
      sudo tee /etc/docker/daemon.json <<-'EOF'
      {
        "registry-mirrors": ["https://mmsdfvki.mirror.aliyuncs.com"]
      }
      EOF
      sudo systemctl daemon-reload
      sudo systemctl restart docker
      ```

      

13. 设置开机启动

    ```
    systemctl enable docker
    ```

## 离线安装 Docker

1. 下载

   **安装包官方地址**：https://download.docker.com/linux/static/stable/x86_64/

   ```
   wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz
   ```

2. 上传到服务器，解压

   ```
   tar -zxvf docker-18.06.3-ce.tgz
   ```

3. 将解压出来的docker文件复制到/usr/bin目录下

   ```
   cp docker/* /usr/bin/
   ```

4. **在/etc/systemd/system/目录下新增docker.service文件**，将docker注册为service服务

   ```
   [Unit]
   Description=Docker Application Container Engine
   Documentation=https://docs.docker.com
   After=network-online.target firewalld.service
   Wants=network-online.target
     
   [Service]
   Type=notify
   # the default is not to use systemd for cgroups because the delegate issues still
   # exists and systemd currently does not support the cgroup feature set required
   # for containers run by docker
   ExecStart=/usr/bin/dockerd --selinux-enabled=false --insecure-registry=127.0.0.1
   ExecReload=/bin/kill -s HUP $MAINPID
   # Having non-zero Limit*s causes performance problems due to accounting overhead
   # in the kernel. We recommend using cgroups to do container-local accounting.
   LimitNOFILE=infinity
   LimitNPROC=infinity
   LimitCORE=infinity
   # Uncomment TasksMax if your systemd version supports it.
   # Only systemd 226 and above support this version.
   #TasksMax=infinity
   TimeoutStartSec=0
   # set delegate yes so that systemd does not reset the cgroups of docker containers
   Delegate=yes
   # kill only the docker process, not all processes in the cgroup
   KillMode=process
   # restart the docker process if it exits prematurely
   Restart=on-failure
   StartLimitBurst=3
   StartLimitInterval=60s
     
   [Install]
   WantedBy=multi-user.target
   ```

   > 此处的--insecure-registry=127.0.0.1（此处改成你私服ip）设置是针对有搭建了自己私服Harbor时允许docker进行不安全的访问，否则访问将会被拒绝。

5. **启动docker**,给docker.service文件添加执行权限

   ```
   chmod +x /etc/systemd/system/docker.service 
   ```

6. 重新加载配置文件（每次有修改docker.service文件时都要重新加载下）

   ```
   systemctl daemon-reload     
   ```

## yum 安装  docker-compose

1. 使用Github安装

   + ```
     curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
     ```
     
   + 给docker-compose执行权限 ```chmod +x /usr/local/bin/docker-compose```
   
   + 查看是否安装成功 ```docker-compose --version```
   
2. 使用EPEL源安装(CentOS 8 以下)

   + 添加EPEL源 ```yum install -y epel-release```
   + 安装python-pip ```yum install -y python-pip```
   + 安装docker-compose ```pip install docker-compose```

3. CentOS 8安装

   + ```pip3 install docker-compose ```


## centos docker 操作

1. 查看docker安装过的包

   ```yum list installed | grep docker```

2. 删除安装包

   ```yum remove docker-ce.x86_64 docker-ce-cli.x86_64 -y```

3. 删除镜像容器

   ```rm -rf /var/lib/docker```

4. 查询镜像

   + docker search querystring

5. 拉取镜像

   + docker pull imagename:tag

6. 导出镜像

   + docker export 将镜像或者运行容器导出成一个tar文件
   + docker save 将镜像文件导出成一个tar文件

7. 载入镜像

   + docker import 将tar文件导成镜像或者容器到docker中
   + docker load 将tar文件导成镜像到docker中

8. 载入镜像添加Tag

   + docker tag

## Linux 使用 supervisor 挂在进程

1. 更新 yum ```sudo yum update```

2. 安装 libicu ```sudo yum install libunwind libicu```

3. 安装 .net core sdk ```sudo yum install dotnet-sdk-2.2.0```

4. 使用dotnet cli运行 ```dotnet XXX.dll --urls http://*:8888

5. supervisor 为 dotnet 创建守护进程

   + 安装 supervisor ```sudo yum install supervisor```

   + 在 etc文件夹下创建 supervisor文件夹 ```mkdir /etc/supervisor```

   + 在supervisor文件夹下创建 文件夹 conf.d ```mkdir /etc/supervisor/conf.d```

   + 生成supervisord_conf配置文件 

     ```echo_supervisord_conf > /etc/supervisor/supervisord.conf```

   + 定位到文件夹下修改配置文件

     1. ```cd /etc/supervisor```
     2. vim supervisor.conf

6. https://www.cnblogs.com/chuankang/p/9473768.html

## Linux 使用 Nginx

1. 安装Nignx  ```sudo yum install nginx```

2. 开启Nginx服务 ```sudo systemctl start nginx.service```

3. 设置开机启动 ```sudo systemctl enable nginx.service```

## Linux 使用 Kestrel 部署 .NET CORE

4. VS 右键发布

5. 新建=>文件夹=>浏览选择文件夹=>选择创建配置文件=>保存

6. 点击配置=>配置选择 release，目标框架选择 netcoreapp3.1，部署模式选择框架依赖，目标运行时选择linux-x64，数据库选择DefaultConnection,点击发布。

7. 定位到服务器 /usr/bsti/composes/bsti.vls.api，将刚才发布文件复制到此目录下

8. 执行代码 ```nohup dotnet BSTI.VLS.Core.dll --urls http://*:8899 > /usr/bsti/applications/bsti.vls.core.log 2>&1```

9. 检测成功 ```curl localhost:8899```

10. 编辑/etc/nginx/conf.d/default.conf 文件 。添加以下部分

    ```
    server {
            listen       8899;
            listen       [::]:8899;
            server_name  _;
            # root         /usr/share/nginx/html;
    
            # Load configuration files for the default server block.
            include /etc/nginx/default.d/*.conf;
    
            location / {
    			#Kestrel上运行的asp.net core mvc网站地址
    			proxy_pass            http://localhost:8899;
    			proxy_http_version    1.1;
    			proxy_set_header      Upgrade $http_upgrade;
    			proxy_set_header      Host $http_host;
    			proxy_cache_bypass    $http_upgrade;
            }
        }
    ```

11. 执行 nginx -s reload 重新加载 nginx

## CentOS 部署 Angular

1. 安装Nignx  ```yum install nginx```

2. 开启Nginx服务 ```sudo systemctl start nginx.service```

3. 设置开机启动 ```sudo systemctl enable nginx.service```

4. 卸载 ```yum remove nginx```

5. 开启端口 ```firewall-cmd --permanent --zone=public --add-port=80/tcp```

6. 关闭端口 ```firewall-cmd --permanent --zone=public --remove-port=80/tcp```

7. 重启防火墙 ```firewall-cmd –reload```

8. 将 angular 编译之后的文件复制到目标文件夹

   ```cp -r /usr/bsti/applications/vls.angular/. /usr/share/nginx/html```

9. 开放文件权限，因为过程中有对/usr/share/nginx/html的写入操作，所以我就直接将该文件夹递归解除所有权限

   ```sudo chmod -R 777 /usr/share/nginx/html```

10. 然后vim打开nginx配置文件

   + ```
     vi /etc/nginx/conf.d/default.conf
     ```

   + 在location里面加入如下语句防止单页应用出现404资源未找到错误：```try_files $uri $uri/ /index.html;```

   + ```
     server {
             listen       80 default_server;
             listen       [::]:80 default_server;
             server_name  _;
             
     
             # Load configuration files for the default server block.
             include /etc/nginx/default.d/*.conf;
     
             location / {
     			try_files $uri $uri/ /index.html;
     			root	/usr/share/nginx/html;
     			index	index.html index.html;
             }
     
             error_page 404 /404.html;
                 location = /40x.html {
             }
     
             error_page 500 502 503 504 /50x.html;
                 location = /50x.html {
             }
         }
     ```

   + 重新加载配置文件 ```nginx -s reload```

## CentOS 安装  asp.net core 

1. 导入公共库的密 ```rpm --import https://packages.microsoft.com/keys/microsoft.asc```

2. 导入.NET Core yum 存储库 

   ```rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm```

3. 安装更新库 ```yum update```

4. 安装 .NET Core ```yum install aspnetcore-sdk-2.2```

5. 查看是否安装完成 ```dotnet --info```

6. 查看当前版本 ```dotnet --version```

## CentOS 公司文件路径

/public

/public/wwwroot

/public/dotnet

## Vim 操作

1. 插入模式
2. 底行模式
3. 编辑
4. 保存
5. 退出
6. 命令
7. 

## Debian 9 开启 SSH

1. vi /etc/ssh/sshd_config
2. 找到PermitRootLogin without-password 修改为PermitRootLogin yes
3. 重启 ssh 服务 service ssh restart
4. 查看 ssh 服务状态 sudo /etc/init.d/ssh status
5. 添加开机启动 update-rc.d ssh enable
6. 关闭开机启动 update-rc.d ssh disable
7. 启用root用户：sudo passwd root

## 错误解决办法

1. iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport 5000 -j DNAT --to-destinatio

   > systemctl restart docker

2. 检测到包降级 直接从项目引用包以选择不同版本

   > 找到对应的项目直接引用高版本的包

3. 当用vmware 启动 linux虚拟机 ifconfig 没有ip4地址

   > 在vmware=>编辑=>虚拟网络编辑器
   >
   > 选择当前虚拟机的虚拟网卡，然后选择桥接模式，然后选择当前主机所使用的网卡
   >
   > 然后在Linux中执行 sudo dhclient  ens160（当前linux网卡名字）

4. mysql 找不到表名

   > vi /etc/my.cnf
   >
   > lower_case_table_names = 1 // 1 是忽略大小写 0 是严格遵守大小写

5. 