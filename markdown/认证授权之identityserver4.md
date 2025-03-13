[ToC]

# IdentityServer4

> [官网](https://identityserver.io/) 
>
> [github](https://github.com/IdentityServer)
>
> [文档](https://identityserver4.readthedocs.io/en/latest/)

## 是什么

> IdentityServer4 is an OpenID Connect and OAuth 2.0 framework for ASP.NET Core.
> 使用.NET为现代应用程序构建身份和访问控制解决方案，包括单点登录，身份管理，授权和API安全。

![img](%E8%AE%A4%E8%AF%81%E6%8E%88%E6%9D%83%E4%B9%8Bidentityserver4.assets/1468246-20190306165605583-415419374.png)


![img](%E8%AE%A4%E8%AF%81%E6%8E%88%E6%9D%83%E4%B9%8Bidentityserver4.assets/1468246-20190306180404698-802440020.png)


![img](%E8%AE%A4%E8%AF%81%E6%8E%88%E6%9D%83%E4%B9%8Bidentityserver4.assets/1468246-20190306175842023-1603947050.png)


![img](%E8%AE%A4%E8%AF%81%E6%8E%88%E6%9D%83%E4%B9%8Bidentityserver4.assets/1468246-20190306180817322-384823618.png)


![image-20200218172411280](%E8%AE%A4%E8%AF%81%E6%8E%88%E6%9D%83%E4%B9%8Bidentityserver4.assets/image-20200218172411280.png)

## 名词

  1. Identity（身份、标识）
  2. Identity Provider（身份提供）
  3. SSO（Single Sign On 单点登录）
  4. Authorization（授权）
  5. API security （API 保护）
  6. Token（令牌）
  7. Security Token Service（安全令牌服务）
  8. Claim（声明）
  9. Client（客户端）
  10. Resource（资源）
  11. Authenticate（认证）
  12. Authorizate（授权）
  13. Authorization Server（授权服务器）
  14. Scope（域）



## 相关

1. OIDC（OpenId Connect）
   + [官网](https://openid.net/connect/)
   + 定义：OpenID Connect 1.0是基于OAuth 2.0协议**实现**的简单标识层。 它允许客户端根据授权服务器执行的身份验证来验证最终用户的身份，并以可互操作且类似于REST的方式获取有关最终用户的基本配置文件信息。
2. OAuth2
   + [官网](https://oauth.net/2/)
   + 定义：OAuth 2.0是用于授权的行业标准**协议**。
3. CORS（Cross-Origin Resource Sharing 跨资源共享）
   + [W3C 定义](https://www.w3.org/TR/cors/)
   + [MDN 定义](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)
   + [阮一峰](http://www.ruanyifeng.com/blog/2016/04/cors.html)
   + 定义：跨域资源共享([CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS)) 是一种**机制**，它使用额外的 [HTTP](https://developer.mozilla.org/en-US/docs/Glossary/HTTP) 头来告诉浏览器 让运行在一个 origin (domain) 上的Web应用被准许访问来自不同源服务器上的指定的资源。
4. JWT （JSON Web Token）
   + [官网](https://jwt.io/)
   + 定义：JSON Web令牌是一种开放的**行业标准RFC 7519方法**，用于在双方之间安全地表示声明。


## 认证模式

  1. 客户端授权模式
  2. 密码授权模式
  3. 授权码授权模式
  4. 简化授权模式
  5. 混合模式（OpenID&OAuth(Hybird，JS/Vue客户端调用)）
  6. ASP.NET Core Identity
  7. 单点登录
  8. 扩展登录

## 实现服务端

1. 配置官方认证中间件(.NET Core 3.1)

   ```
   app.UseRouting();
   // 先开启认证
   app.UseAuthentication();
   // 然后开启授权
   app.UseAuthorization();
   app.UseEndpoints();
   ```

   

2. 当GrantType 为ResourceOwnerPasswordAndClientCredentials 的时候，客户端grant_type 为password或者client_credentials

   + 资源的name 一定要和 Client的AllowedScopes一致 

3. 使用QuickStart UI

   + 使用PowerShell打开项目目录

   + 执行 ```iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/IdentityServer/IdentityServer4.Quickstart.UI/master/getmaster.ps1'))```

   + 要注册静态文件路由

     ```
     services.AddMvc();
     app.UseStaticFiles();
     app.UseRouting();
     app.UseEndpoints(endpoints =>
     {
     	endpoints.MapDefaultControllerRoute();
     });
     ```

   + 

## 解释

1. Svr.Client.AllowScopes

2. Svr.Client.Claims 客户端的证件单元 在此属性上设置的值将会被直接添加到AccessToken

3. Svr.TestUser.Claims 用户的证件单元

4. ApiResource.UserClaims Api资源的用户证件单元。
   
   + API资源通过`HttpContext.User.Claims`并没有获取到我们为测试用户添加的Role Claim，那是因为我们未对API资源做配置。
   
5. Scope 验证源码

   ```
   /// <summary>
   /// Validates the required scopes.
   /// </summary>
   /// <param name="consentedScopes">The consented scopes.</param>
   /// <returns></returns>
   public bool ValidateRequiredScopes(IEnumerable<string> consentedScopes)
   {
       var identity = RequestedResources.IdentityResources.Where(x => x.Required).Select(x=>x.Name);
       var apiQuery = from api in RequestedResources.ApiResources
                      where api.Scopes != null
                      from scope in api.Scopes
                      where scope.Required
                      select scope.Name;
   
       var requiredScopes = identity.Union(apiQuery);
       return requiredScopes.All(x => consentedScopes.Contains(x));
   }
   ```

   

6. reponse_type

   + ``id_token`` requests an identity token (only identity scopes are allowed)

   + ``token`` requests an access token (only resource scopes are allowed)

   + ``id_token token`` requests an identity token and an access token

   + ``code`` requests an authorization code

   + ``code id_token`` requests an authorization code and identity token

   + ``code id_token token`` requests an authorization code, identity token and access token

     


## EndPoint

1. /connect/authorize/callback
2. /connect/authorize
3. 


## 实现资源方

1. 建立空.NET Core Web Api项目

2. 添加 Swagger 支持

   + ```Install-Package Swashbuckle.AspNetCore -Version 5.0.0```

   + ```
     services.AddControllers();
     services.AddSwaggerGen(c =>
     {
     	c.SwaggerDoc("v1", new OpenApiInfo { Title = "My API", Version = "v1" });
     });
     ```

   + ```
     app.UseSwagger();
     app.UseSwaggerUI(c =>
     {
     	c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
     });
     app.UseRouting();
     ```

   + 启用XML注释

   + ```
     // 在项目文件中添加
     <PropertyGroup>
         <GenerateDocumentationFile>true</GenerateDocumentationFile>
         <NoWarn>$(NoWarn);1591</NoWarn>
     </PropertyGroup>
     ```

   + ```
     services.AddSwaggerGen(c =>
     {
         // 添加注释
         c.IncludeXmlComments(System.IO.Path.Combine(AppContext.BaseDirectory, $"{System.Reflection.Assembly.GetExecutingAssembly().GetName().Name}.xml"));
     });
     ```

3. 引用AccessTokenValidation包

   + ```intall-package IdentityServer4.AccessTokenValidation```

4. 客户端添加Bearer认证

   ```
   services.AddAuthentication("Bearer")
       .AddIdentityServerAuthentication(option =>
       {
           option.Authority = "http://localhost:5000";
           option.ApiName = "password.api"; // 和API Resource 的Name保持一致
           option.ApiSecret = "secret";
           option.RequireHttpsMetadata = false;
       });
   ```

   ```
   app.UseRouting();
   app.UseAuthentication();
   app.UseAuthorization();
   ```

5. 客户端添加OpenId Connect认证

   + OpenID Connect也使用Scope概念。同样，Scope代表您想要保护的内容以及客户端想要访问的内容。

   + 与OAuth相比，**OIDC中的Scope不仅代表API资源，还代表用户ID，姓名或电子邮件地址等身份资源**。

   1.Authorization Server 代码

   ```
   new Client
   {
       ClientId = "mvc_implicit",//定义客户端 Id
       ClientName = "MVC Client",
       AllowedGrantTypes = GrantTypes.Implicit,
       RedirectUris = { "http://localhost:5002/signin-oidc" },
       PostLogoutRedirectUris = { "http://localhost:5002/signout-callback-oidc" },
       AllowedScopes = new string[]
       {
           IdentityServerConstants.StandardScopes.OpenId,
           IdentityServerConstants.StandardScopes.Profile,
           "client",
           "password"
       },
       AllowAccessTokensViaBrowser = true,
       AllowOfflineAccess = true,
   }
   ```
   ```
   public static IEnumerable<IdentityResource> GetIdentityResources()
   {
       return new List<IdentityResource>
           {
               new IdentityResources.OpenId(),
               new IdentityResources.Profile(),
           };
   }
   ```

   ```
   var builder = services.AddIdentityServer(options =>
       {
           options.Events.RaiseErrorEvents = true;
           options.Events.RaiseInformationEvents = true;
           options.Events.RaiseFailureEvents = true;
           options.Events.RaiseSuccessEvents = true;
       })
       .AddDeveloperSigningCredential()
       .AddInMemoryIdentityResources(Config.InMemoryConfig.GetIdentityResources())
       .AddTestUsers(Config.InMemoryConfig.GetUsers().ToList())
       .AddInMemoryApiResources(Config.InMemoryConfig.GetApiResources())
       .AddInMemoryClients(Config.InMemoryConfig.GetClients());
   ```

   

   2.Client 代码 

   ```
   JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
   services.AddAuthentication(options =>
   {
       options.DefaultScheme = "Cookies";
       options.DefaultChallengeScheme = "oidc";
   })
       .AddCookie("Cookies")
       .AddOpenIdConnect("oidc", options =>
       {
           options.SignInScheme = "Cookies";
           options.Authority = "http://localhost:5000";
           options.RequireHttpsMetadata = false;
   
           options.ClientId = "mvc_implicit";
           options.SaveTokens = true;
   
           options.ResponseType = "id_token token";
       });
   ```

   

6. 



## 证书

1. 下载

   > [openssl](https://slproweb.com/products/Win32OpenSSL.html)

2. 使用

   + 配置环境变量
   + 

   

3. 