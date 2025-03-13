[ToC]

# spring boot 之 配置 VS Code

## 1. 扩展

1. Spring Boot Extension Pack
2. Java Extension Pack
3. Language Support for Java(TM) by Red Hat
4. Java Debugger for Visual Studio Code

## 2. 配置Maven

 1. ![image-20200202173548753](images\image-20200202173548753.png)

 2. 添加java 和 maven的设置

    ```
    "java.home":"E:\\Program Files\\Java\\jdk1.8.0_241", // java.home的路径配置
    "java.configuration.maven.userSettings": "E:\\Program Files\\Java\\apache-maven-3.6.3\\conf\\settings.xml", // Maven setting路径配置
    "maven.executable.path": "E:\\Program Files\\Java\\apache-maven-3.6.3\\bin\\mvn.cmd",// Maven 可执行文件路径配置
    "maven.terminal.useJavaHome": true,
        "maven.terminal.customEnv": [
            {
                "environmentVariable": "JAVA_HOME",
                "value": "E:\\Program Files\\Java\\jdk1.8.0_241"
            }
        ],
    "java.maven.downloadSources": true
    ```

    ## 3. 创建Spring Boot 项目

    1. Ctrl+Shift+P->spring

       ![image-20200202201352330](images\image-20200202201352330.png) 

       选择使用语言（Java）

       输入 groupId（com.havenlau）

       输入项目名称（mydemo）

       选择Spring Boot版本（2.2.4）

       选择需要引用的包

       ![image-20200202202632819](image-20200202202632819.png)

    2. 生成后的项目目录如下：

       ![image-20200202202942463](image-20200202202942463.png)

    ## 4. 运行 Spring Boot 项目
    
    1. 新增测试文件
    
       ![image-20200202203853965](images\image-20200202203853965.png)
    
    2. 调试
    
       > 按 F5 或者 点击左侧小虫子按钮
    
       ![image-20200202212931862](images\image-20200202212931862.png)
    
       
    
    3. 报错解决办法
    
       ![image-20200202204303227](image-20200202204303227.png)
    
       > 没有配置正确的launch.json
    
       ```
       "configurations": [
               {
                   "type": "java",
                   "name": "Debug (Launch)",
                   "request": "launch",
                   "cwd": "${workspaceFolder}",
                   "console": "internalConsole",
                   "stopOnEntry": false,
                   "mainClass": "",
                   "args": ""
               },
               {
                   "type": "java",
                   "name": "Debug (Launch)-DemoApplication<demo>",
                   "request": "launch",
                   "cwd": "${workspaceFolder}",
                   "console": "internalConsole",
                   "stopOnEntry": false,
                   "mainClass": "com.havenlau.demo.DemoApplication",
                   "args": "",
                   "projectName": "demo"
               },
               {
                   "type": "java",
                   "name": "Debug (Attach)",
                   "request": "attach",
                   "hostName": "localhost",
                   "port": 8080
               }
           ]
       ```
    
       
    
    4. 打开浏览器输入 http://localhost:8080
    
       ![image-20200202213103233](image-20200202213103233.png)
    
       > 因为没有配置默认启动控制器，所以Error Page
    
    5. 打开浏览器输入 http://localhost:test
    
       > 1. 进入断点
    
       ![image-20200202213244804](image-20200202213244804.png)
    
       > 2. F5放掉断点，正确输出
    
       ![image-20200202213352390](image-20200202213352390.png)
    
    6. 添加默认页面
    
       1. 将上面的HomeController.java 重命名为 RestApiController.java
    
          ![image-20200202215042929](image-20200202215042929.png) 
    
       2. 新建 HomeController.java
    
          ```
          @Controller
          public class HomeController {
          
              @RequestMapping("/") // localhost:8080/ 就可以直接访问
              public String Index(HashMap<String,Object> map){
                  String strMsg = "Hello world,Spring Boot Demo.";
                  map.put("index", strMsg);
                  return "/index"; // 返回 index action
              }
          }
          ```
    
          
    
       3. 在templates 文件夹下 新建 index.html
    
          ```
          <!DOCTYPE html>
          <html lang="cn" xmlns:th="http://www.w3.org/1999/xhtml">
          <head>
              <meta charset="UTF-8"/>
              <title>第一个HTML页面</title>
          </head>
          <body>
          <h1>Hello Spring Boot!!!</h1>
          <p th:text="${index}"></p>
          </body>
          </html>
          ```
    
          ![image-20200202215345144](image-20200202215345144.png)



