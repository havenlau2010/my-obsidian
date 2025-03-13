[ToC]

# Spring Boot 之 Maven

## 1. Maven 是什么

> 类似于.NET 中 Nuget 包管理器，在 Java 中是一个项目管理和构建自动化管理器。Maven 使用惯例优于配置的原则。

+ Maven 默认目录

| 目录                          | 目的                            |
| ----------------------------- | ------------------------------- |
| ${basedir}                    | 存放 pom.xml和所有的子目录      |
| ${basedir}/src/main/java      | 项目的 java源代码               |
| ${basedir}/src/main/resources | 项目的资源，比如说 property文件 |
| ${basedir}/src/test/java      | 项目的测试类，比如说 JUnit代码  |
| ${basedir}/src/test/resources | 测试使用的资源                  |



## 2. 安装

1. 安装 JDK 6 及以上

2. Maven 下载 http://maven.apache.org/download.html

3. 在 环境变量 Path 中添加 Maven  

   ```E:\Program Files\Java\apache-maven-3.6.3\bin```

4. 验证是否安装成功

   ```mvn -v```

   ![image-20200201204628689](images\image-20200201204628689.png)

5. 创建一个Maven项目

   1. ```mvn archetype:generate```

      ![image-20200201223804650](images\image-20200201223804650.png)

   2. 输入archetype，这里选择maven例子 输入 7

   3. 输入 groupId，输入 com.havenlau

   4. 输入articfactId，输入 testMavenDemo

   5. 输入version，无特殊版本号，选择默认直接敲回车

   6. 输入package，默认就是groupId

   7. 最后comfirm，输入Y

      ![image-20200201224333021](images\image-20200201224333021.png)

   8. 构建程序

      ```mvn package```

   9. 使用maven运行程序

      ```java -cp target/testMavenDemo-1.0-SNAPSHOT.jar com.havenlau.App```

      ![image-20200201224823472](images\image-20200201224823472.png)

      

## 3. Maven 常见对象

### 3.1 POM
> + **Project Object Model**
> + 一个项目所有的配置都放置在 POM 文件中：定义项目的类型、名字，管理依赖关系，定制插件的行为等等。

+ 在 POM 中，groupId, artifactId, packaging, version 叫作 maven 坐标，它能唯一的确定一个项目。
+ maven 坐标，我们就可以用它来指定我们的项目所依赖的其他项目，插件，或者父项目。一般 maven 坐标写成如下的格式：
  + groupId                                       :artifactId     :packaging   :version
  + com.mycompany.helloworld :helloworld  :jar                 :1.0-SNAPSHOT


```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>havenlau</groupId>
  <artifactId>helloworld</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>

  <name>helloworld</name>
  <url>http://maven.apache.org</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>

```



### 3.2 插件

```mvn [options] [<goal(s)>] [<phase(s)>]```

+ 我们用了 mvn archetype:generate 命令来生成一个项目，这里的 archetype是一个插件，generate是目标(goal)的名字。这个命令的意思是告诉 maven 执行 archetype 插件的 generate 目标。插件目标通常会写成 **pluginId:goalId**

+ 一个目标是一个工作单元，而插件则是一个或者多个目标的集合。比如说Jar插件，Compiler插件，Surefire插件等。从看名字就能知道，Jar 插件包含建立Jar文件的目标， Compiler 插件包含编译源代码和单元测试代码的目标。Surefire 插件的话，则是运行单元测试。

+ 一个目标是一个工作单元，而插件则是一个或者多个目标的集合。比如说Jar插件，Compiler插件，Surefire插件等。从看名字就能知道，Jar 插件包含建立Jar文件的目标， Compiler 插件包含编译源代码和单元测试代码的目标。Surefire 插件的话，则是运行单元测试。

  

### 3.3 生命周期

> mvn package,这里的 package 是一个maven的生命周期阶段 (lifecycle phase )。生命周期指项目的构建过程，它包含了一系列的有序的阶段 (phase)，而一个阶段就是构建过程中的一个步骤。插件目标可以绑定到生命周期阶段上。一个生命周期阶段可以绑定多个插件目标。当 maven 在构建过程中逐步的通过每个阶段时，会执行该阶段所有的插件目标。

1. process-resources 阶段：resources:resources

2. compile 阶段：compiler:compile

3. process-classes 阶段：(默认无目标)

4. process-test-resources 阶段：resources:testResources

5. test-compile 阶段：compiler:testCompile

6. test 阶段：surefire:test

7. prepare-package 阶段：(默认无目标)

8. package 阶段：jar:jar



### 3.4 依赖管理

> 即项目中的引用关系，在POM中是用dependencies定义的。如：

```
<dependencies> 
    <dependency> 
      <groupId>junit</groupId> 
      <artifactId>junit</artifactId> 
      <version>3.8.1</version> 
      <scope>test</scope> 
    </dependency> 
  </dependencies> 
```

> 依赖传递：所谓传递依赖是指 maven 会检查被依赖的 jar 文件，把它的依赖关系纳入最终解决的依赖关系链中。

+ 在 POM 的 dependencies 部分中，scope 决定了依赖关系的适用范围。例子中 junit 的 scope 是 test，那么它只会在执行 compiler:testCompile and surefire:test 目标的时候才会被加到 classpath 中，在执行 compiler:compile 目标时是拿不到 junit 的。

+ 指定 scope 为 provided，意思是 JDK 或者容器会提供所需的jar文件。比如说在做web应用开发的时候，我们在编译的时候需要 servlet API jar 文件，但是在打包的时候不需要把这个 jar 文件打在 WAR 中，因为servlet容器或者应用服务器会提供的。

+ scope 的默认值是 compile，即任何时候都会被包含在 classpath 中，在打包的时候也会被包括进去。

  

### 3.5 库

> + 当第一次运行 maven 命令的时候，你需要 Internet 连接，因为它要从网上下载一些文件。那么它从哪里下载呢？它是从 maven 默认的远程库(http://repo1.maven.org/maven2) 下载的。这个远程库有 maven 的核心插件和可供下载的 jar 文件。
>+ 本地库是指 maven 下载了插件或者 jar 文件后存放在本地机器上的拷贝。在 Linux 上，它的位置在 ~/.m2/repository，在 Windows上，在 C:\Users\username\.m2\repository
> + 当 maven 查找需要的 jar 文件时，它会先在本地库中寻找，只有在找不到的情况下，才会去远程库中找。



## 4. 使用

### 4.1 常用命令

+ mvn package 打包
+ mvn install 把项目安装到本地库