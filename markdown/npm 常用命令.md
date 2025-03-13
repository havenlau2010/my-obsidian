# **npm** 简述

## 快速入门
1. 	安装npm和管理npm版本
> [npm安装](<https://nodejs.org/en/>)

2. 	更新npm           	
>	1.	npm -v
>	2.	npm install npm@latest -g
>	3.	npm install npm@next -g

3. 使用淘宝镜像
4. 安装一个包
>	1.	npm install <package_name> 
>	2.	使用 package.json 安装包
>		1.	创建一个package.json 
>		2.	执行命令 npm init 

5. 卸载本地包
>	npm uninstall <package_name>
6. 更新本地包
>	npm update(在package.json文件所在目录) 
8. 操作package.json
>新增  npm install <package_name> --save
>更新 npm update --save
>卸载 npm uninstall --save <package_name>
9. 操作全局包
>新增 npm install -g <package_name> 
>更新 npm update -g <package_name> 
>卸载 npm uninstall -g <package_name>

10.最新包
>新增 npm install -g <package_name>@latest

11.特定版本包
>新增 npm install -g <package_name>@1.1.1

12.范围内版本包
>新增 npm install -g <package_name>@">=0.1.0 <0.3.0"

## 命令行
1. build	构建一个包
>npm build [<package-folder>]

2. config	管理npm 配置文件
    1. npm config set <key><value> [-g|--global]
    2. npm config get <key>
    3. npm config delete <key>
    4. npm config list [-l] [--json]
    5. npm config edit   
    6. npm get <key>
    7. npm set <key><value> [-g|--global]

3. start 执行脚本
>  npm start [-- <args>]

4. help 帮助
> npm help <term> [<term..>]

5. 

## npm用法



## 配置 npm

## 故障排除

