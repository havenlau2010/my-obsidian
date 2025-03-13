# Open Edx

## 1. 相关网站

+ [官方网站(https://bitnami.com/stack/edx)](https://bitnami.com/stack/edx)
+ [官方文档](https://docs.edx.org.)
+ [本地化资源(https://github.com/edx/edx-platform/wiki/Internationalization-and-localization)](https://github.com/edx/edx-platform/wiki/Internationalization-and-localization)
+ [Xblock Github SDK(https://github.com/edx/xblock-sdk)](https://github.com/edx/xblock-sdk)
+ [edx-platform Github(https://github.com/edx/edx-platform)](https://github.com/edx/edx-platform)
+ [官方的Xblock入门资料](https://edx.readthedocs.io/projects/xblock-tutorial/en/latest/getting_started/index.html)



## 2. 参考资料

+ [Edx汉化](https://blog.csdn.net/u013510614/article/details/50175837)

+ [国内Edx](https://www.edustack.org/)

+ [国内Edx手册](https://www.edustack.org/manual/edx/)

+ [wwj718-docker地址](https://github.com/wwj718/edx_cypress_docker)

+ [open-edx-ebook中文版](https://www.edustack.org/manual/edx/open-edx-ebook%E4%B8%AD%E6%96%87%E7%89%88/)

+ [open-edx-学习、开发、运维相关链接整理](https://www.edustack.org/manual/edx/open-edx-%E5%AD%A6%E4%B9%A0%E3%80%81%E5%BC%80%E5%8F%91%E3%80%81%E8%BF%90%E7%BB%B4%E7%9B%B8%E5%85%B3%E9%93%BE%E6%8E%A5%E6%95%B4%E7%90%86/)

+ [简明配置指南](https://www.edustack.org/manual/edx/conf-guide/)

+ https://github.com/edx/configuration/wiki/Setting-Up-External-Authentication

+ https://openedx.atlassian.net/wiki/spaces/OpenOPS/pages/94306332/How+to+Create+admin+user+in+lms+cms+etc.

+ BIOS 启动Hyper-V

  bcdedit /set hypervisorlaunchtype auto

  bcdedit /set hypervisorlaunchtype off

## 3.使用wwj718 提供的Docker镜像部署

+ docker 命令：```docker run -itd -p 8880:80 -p 2022:22 -p 18010:18010 wwj718/edx_cypress_docker:1.22```
+ SSH 端口 2022 账号/密码 root/edx
+ LMS 端口 8880 帐号/密码 staff@example.com/edx 
+ Studio 端口 18010 帐号/密码 staff@example.com/edx 
+ 配置文件所在目录 ```/edx/app/edxapp/*.json

## 4. Edx devstack 帐号密码

### Usernames and Passwords

The provisioning script creates a Django superuser for every service.

```
Email: edx@example.com
Username: edx
Password: edx
```

The LMS also includes demo accounts. The passwords for each of these accounts is `edx`.

| Username | Email                                               |
| -------- | --------------------------------------------------- |
| audit    | [audit@example.com](mailto:audit@example.com)       |
| honor    | [honor@example.com](mailto:honor@example.com)       |
| staff    | [staff@example.com](mailto:staff@example.com)       |
| verified | [verified@example.com](mailto:verified@example.com) |

 Service URLs

Each service is accessible at `localhost` on a specific port. The table below provides links to the homepage of each service. Since some services are not meant to be user-facing, the "homepage" may be the API root.

| Service             | URL                               |
| ------------------- | --------------------------------- |
| LMS                 | http://localhost:18000/           |
| Studio/CMS          | http://localhost:18010/           |
| Credentials         | http://localhost:18150/api/v2/    |
| Catalog/Discovery   | http://localhost:18381/api-docs/  |
| E-Commerce/Otto     | http://localhost:18130/dashboard/ |
| Notes/edx-notes-api | http://localhost:18120/api/v1/    |
| Registrar           | http://localhost:18734/api-docs/  |

### Microfrontend URLs

Each microfrontend is accessible at `localhost` on a specific port. The table below provides links to each microfrontend.

| Service                | URL                     |
| ---------------------- | ----------------------- |
| Gradebook              | http://localhost:1994/  |
| Program Manager        | http://localhost:1976/  |
| Publisher App Frontend | http://localhost:18400/ |

## 5. Open Edx Component

- The Learning Management System (LMS)
- Open edX Studio
- Discussion Forums
- Open Response Assessments (ORA)
- E-Commerce
- Credentials
- Notes
- Course Discovery
- XQueue
- Open edX Search
- A demonstration Open edX course

## 6. Bitnami Open Edx

1. phpMyAdmin /phpMyAdmin

2. phpPgAdmin /phpPgAdmin

3. [在开发edX中集成第三方身份验证](https://edx.readthedocs.io/projects/edx-installing-configuring-and-running/en/latest/configuration/tpa/tpa_integrate_open/index.html)

4. 添加 OAuth2 客户端

   1. In , change the value of > to (it is by default).`lms.env.json``FEATURES``ENABLE_THIRD_PARTY_AUTH``true``false`

   2. Install the python-social-auth authentication backend specific to that provider, and determine the python module path of the backend.

      - If the provider is a [python-social-auth supported backend](http://python-social-auth.readthedocs.io/en/latest/backends/index.html#social-backends), the backend is already installed.

        To determine the python module path of the backend, locate the backend in the [list of python-social-auth backends](https://github.com/omab/python-social-auth/tree/master/social/backends), open the file for the backend, and locate the name of the class. The python module path is of the format .`social.backends..`

        For example, for GitHub, the file is and the class in that file is . The backend module path is therefore .`github.py``GithubOAuth2``social.backends.github.GithubOAuth2`

      - If the provider is not a python-social-auth supported backend, you must create a new Python package that includes the code required to implement the backend. Your python package must contain a module with a class that subclasses . For more information, see the [python-social-auth documentation](http://python-social-auth.readthedocs.io/en/latest/index.html), or see the code of the fully supported backends (such as Google or Facebook) for examples.`social.backends.oauth.BaseOAuth2`

   3. Enable the python-social-auth authentication backend specific to that provider:

      1. In the setting in , add the full path of the module to the list.`THIRD_PARTY_AUTH_BACKENDS``lms.env.json`
      2. (optional) Set the value of to match [the default value in the aws.py file](https://github.com/edx/edx-platform/blob/b3462e5b1c3cc45ad8673f3f12e84fa17ffa6b64/lms/envs/aws.py#L586-L596), and then add any additional backends you need.`THIRD_PARTY_AUTH_BACKENDS`

   4. Obtain a client ID and client secret from the provider.

   5. Add the client secret to . To do this, create a new key called if it doesn’t already exist, and then add the backend name to that key as follows.`lms.auth.json``SOCIAL_AUTH_OAUTH_SECRETS`

      > ```
      > "SOCIAL_AUTH_OAUTH_SECRETS": { "backend-name": "secret" }
      > ```

      If you are using Ansible, the variable to set is called .`EDXAPP_SOCIAL_AUTH_OAUTH_SECRETS`

   6. Restart the LMS server so that it will use the new settings.

   7. Go to . For example, on devstack, go to .`/admin/third_party_auth/oauth2providerconfig/``http://localhost:8000/admin/third_party_auth/oauth2providerconfig/`

   8. Select **Add Provider Configuration (OAuth)**.

   9. Make sure that **Enabled** is selected.

   10. Make sure that **Visible** is selected.

   11. For **Icon Class**, select one of the following options.

       - Use a generic icon by entering .`fa-sign-in`
       - Use a relevant Font Awesome icon.
       - Upload an SVG icon using the **Icon Image** field.

   12. For **Name**, enter the name of the provider.

   13. For **Backend Name**, select the backend name from the list. (If it does not appear in the list, either the setting or the setting is not configured correctly.)`ENABLE_THIRD_PARTY_AUTH``THIRD_PARTY_AUTH_BACKENDS`

   14. For **Client ID**, enter the client ID that you noted earlier.

   15. Leave **Client Secret** blank. Open edX sets the secret through , which is more secure.`lms.auth.json`

   16. Select **Save**.

5. 集成 My OAuth

   1. lms.env.json => FEATURES => ENABLE_THIRD_PARTY_AUTH:true
   2. /opt/bitnami/apps/edx/venvs/edxapp/lib/python2.7/site-packages/social_core/backends/github.py

6. 重启组件

   1. sudo /opt/bitnami/ctlscript.sh restart apache

## 7. 开启 SSH

1. 找到PermitRootLogin without-password 修改为PermitRootLogin yes
2. 重启 ssh 服务 service ssh restart
3. 查看 ssh 服务状态 sudo /etc/init.d/ssh status
4. 添加开机启动 update-rc.d ssh enable
5. 关闭开机启动 update-rc.d ssh disable
6. 启用root用户：sudo passwd root

## Debian 开启 SSH
   ```
   sudo rm -f /etc/ssh/sshd_not_to_be_run
   sudo systemctl enable ssh
   sudo systemctl start ssh
   ```
## Ubuntu 开启 SSH
   ```
   sudo mv /etc/init/ssh.conf.back /etc/init/ssh.conf
   sudo start ssh
   ```

## 8. PUTTY 开启代理

1. Connection=>SSH=>Tunnels
2. Source Port 填写需要被代理的 IP 和 端口 如 要访问虚拟机上的localhost:80
3. Destination 填写主机上映射的 IP 和端口 如我用8080来映射Source Port 的 80 端口 则是localhost:8080
4. 点击Add

## 9. Bitnami FAQ
>  https://docs.bitnami.com/virtual-machine/faq