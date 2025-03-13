
## 将OVA文件导入到Hyper-V

    1.  解压ova文件
    2.  cd 到 virtualbox安装目录 ```cd 'E:\Program Files\Oracle\VirtualBox\'```` 
    3.  执行转换命令 ``` .\VBoxManage.exe clonemedium 'G:\Tools\vmware\bitnami-edx-ironwood.2-5-linux-debian-9-x86_64\bitnami-edx-ironwood.2-5-linux-debian-9-x86_64-disk1.vmdk' 'G:\Tools\vmware\edx.vhd' --format VHD```
    4.  导入 VHD 文件到hyper-v
        + your machine name > 右键 > 新建 > 虚拟机 > 指定名称和位置 > 指定代数[默认第一代] > 分配内存 > 配置网络 > 连接虚拟硬盘[使用现有虚拟硬盘] > 完成

## WIN10 启动 WSL

1. 启用windows虚拟机平台和windows linux subssyetm(系统管理员权限在PowerShell中执行)
   
```
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
   Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

2. wsl 相关命令
	+ wsl -l -v
	+ wsl --set-version Ubuntu  2
	+ wsl --set-default-version 2
3. 