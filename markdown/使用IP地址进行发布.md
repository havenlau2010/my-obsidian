## 使用IP地址进行发布


### 在AppSetting中

```
public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
            .UseUrls("http://*:80", "https://*:81")
            .UseStartup<Startup>()
            .Build();
```

### 在代码中

```
{
  "server.urls": "http://192.168.5.20:80;https://192.168.5.20:81;",
}
```

### 在命令行中

```
dotnet XXXX.dll –server.urls “http://192.168.5.20:80”
```



