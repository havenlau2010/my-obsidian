# Asp.Net Core 之 Docker

## VS 添加 Docker 支持

1. 创建项目（勾选启用Docker支持，Docker平台选择Linux）

   ![image-20200302163100483](asp.net%20core%20%E4%B9%8Bdocker.assets/image-20200302163100483.png)

2. 历史项目添加 Docker 支持

   + 项目属性右键=>添加**容器支持**=>选择**Linux**

3. 添加Docker-Compose支持

   + 项目属性右键=>添加**容器业务流程协调程序支持**=>选择**Docker-Compose**=>选择**Linux**

4. Dockerfile 生成文件解析

   ```
   # 安装Asp.Net Core 开发时（生成，包含CLI）环境
   # 此示例将此映像用于生成应用。 此映像包含带有命令行工具 (CLI) 的 .NET Core SDK。 此映像对本地开发、调试和单元测试进行了优化。
   FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
   # 转到开发时环境的目录 /app
   WORKDIR /app
   # 开放80端口供外部程序访问
   EXPOSE 80
   # 安装Asp.Net Core 运行时环境 此映像包含 ASP.NET Core 运行时和库，并针对在生产中运行应用进行了优化。 
   # 此映像专为部署和应用启动的速度而设计，相对较小，因此优化了从 Docker 注册表到 Docker 主机的网络性能。
   FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
   # 转到当前运行时环境的目录/src
   WORKDIR /src
   # 复制项目依赖项到当前工作目录文件夹下=> /src/CoreMVC.Docker/
   COPY ["CoreMVC.Docker/CoreMVC.Docker.csproj", "CoreMVC.Docker/"]
   # 还原项目依赖项
   RUN dotnet restore "CoreMVC.Docker/CoreMVC.Docker.csproj"
   # 拷贝文件
   COPY . .
   # 转到该目录下
   WORKDIR "/src/CoreMVC.Docker"
   # 生成项目，输出到 /app/build目录下
   RUN dotnet build "CoreMVC.Docker.csproj" -c Release -o /app/build
   
   FROM build AS publish
   RUN dotnet publish "CoreMVC.Docker.csproj" -c Release -o /app/publish
   
   FROM base AS final
   WORKDIR /app
   COPY --from=publish /app/publish .
   ENTRYPOINT ["dotnet", "CoreMVC.Docker.dll"]
   ```


## 在本地Docker 调试项目

1. [官网地址](https://docs.microsoft.com/zh-cn/visualstudio/containers/edit-and-refresh?view=vs-2019)

2. 使用Docker模式启动项目

3. 和其他调试模式一样

4. > 在开发周期中，Visual Studio 在你更改 Dockerfile 后仅重新生成容器映像和容器本身。 如果不更改 Dockerfile，Visual Studio 将重复使用以前运行的容器。
   >
   > 如果你手动修改了容器，并希望使用干净的容器映像重启，请使用 Visual Studio 中的“Build” > “Clean”命令，然后按常规操作生成 。

## Asp.Net Core MVC 项目发布到本地Registy

## Asp.Net Core MVC 连接数据库项目发布到本地Registy

## Asp.Net Core Angular 项目发布到本地Registy

+ 在 Dockerfile 文件 中添加 

  ```
  RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
  RUN apt-get install -y nodejs
  ```

## Dockfile 说明

1. docker build 命令使用 Dockerfile 文件来创建容器映像。
2. FROM 关键字需要完全限定的 Docker 容器映像名称。 Microsoft 容器注册表（MCR，mcr.microsoft.com）是 Docker Hub 的联合，可托管可公开访问的容器。 dotnet/core 段是容器存储库，其中 aspnet 段是容器映像名称。 该映像使用 3.1 进行标记，它用于版本控制。
3. ```docker build -t counter-image -f Dockerfile .```解析
    + docker build 命令中的 . 指示 Docker 在当前文件夹中查找 Dockerfile。
    + 此命令生成映像，并创建指向相应映像的本地存储库“counter-image” 。
4. ```COPY bin/Release/netcoreapp3.1/publish/ App/``` 解析
    + COPY 命令指示 Docker 将计算机上的指定文件夹复制到容器中的文件夹。 在此示例中，“publish”文件夹被复制到容器中的“App”文件夹 。
5. ```WORKDIR /App``` 解析 
    + WORKDIR 命令将容器内的当前目录更改为“App” 。
6. ```ENTRYPOINT ["dotnet", "NetCore.Docker.dll"]``` 解析
    + ENTRYPOINT 指示 Docker 将容器配置为可执行文件运行。 在容器启动时， ENTRYPOINT 命令运行。 当此命令结束时，容器也会自动停止。
7. ```docker attach --sig-proxy=false container_name(id)``` 解析
    + 连接到运行中的容器来查看其输出
8. 
   

  