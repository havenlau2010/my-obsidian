[ToC]

# 核心ERP虚拟任务开发整理

## 1.1 产品扩展

### 1.1.1 程序目录

#### 1.1.1.1 解决方案目录

> 项目名字 ```Mysoft.Cbxt(子系统汉语拼音首字母).ContractMng(一级模块名称).[Interfaces|Model|UnitTest].Plugin```

![image-20201117173627886](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117173627886.png)

#### 1.1.1.2 目录说明 

| 模块                                      | 目录                   | 说明                                                         |
| ----------------------------------------- | ---------------------- | ------------------------------------------------------------ |
| Mysoft.Cbxt.ContractMng.Plugin            |                        |                                                              |
|                                           | AppServices            | [应用服务](https://open.mingyuanyun.com/docs/platform/yun-xing-ping-tai/yin-yong-fu-wu-ceng.html) |
|                                           | DomainServices         | [领域服务](https://open.mingyuanyun.com/docs/platform/yun-xing-ping-tai/ling-yu-fu-wu-ceng.html) |
|                                           | Handlers               |                                                              |
|                                           | PublicServices         |                                                              |
|                                           | WorkFlow               |                                                              |
|                                           | Elog                   |                                                              |
|                                           | EventPublisher         |                                                              |
|                                           | EventSubscribeServices |                                                              |
|                                           | ExcelImport            |                                                              |
|                                           | Jobs                   |                                                              |
|                                           | Profile                |                                                              |
|                                           | AppInitializer.cs      |                                                              |
| Mysoft.Cbxt.ContractMng.Model.Plugin      |                        |                                                              |
|                                           | Const                  |                                                              |
|                                           | DTO                    |                                                              |
|                                           | Entities               |                                                              |
|                                           | Enum                   |                                                              |
| Mysoft.Cbxt.ContractMng.Interfaces.Plugin |                        |                                                              |
|                                           |                        |                                                              |



### 1.1.2 开发流程

> 需求：
> 1、添加业务类型必填项，根据选项动态显示 预算单信息
> 2、增加保存校验，前后端都要进行校验
> 分析：
> 1、前端需要校验，所以要扩展前端向相关模块的JS
> 2、后台也需要校验，所以也要扩展后台相关的AppService

#### 1.1.2.1 解决方案

> 对产品中成本系统的合同模块进行扩展开发

1. 在```二开整体解决方案.sln```目录下根据要二开子系统编号在产品中序号和名字建立目录及相关程序子模块

2. 成本系统在产品中的序号为02  ```/src/02 成本系统/```

3. 合同管理在成本系统中的序号为03 ```/src/02 成本系统/03 合同管理```

4. 建立```二开独立```目录 ```/src/02 成本系统/03 合同管理/01 产品扩展```

5. 在二开独立目录下按照命名要求分别新建```主程序、接口程序、实体程序、单元测试```项目

   + Mysoft.Cbxt.ContractMng.Plugin
   + Mysoft.Cbxt.ContractMng.Interfaces.Plugin
   + Mysoft.Cbxt.ContractMng.Model.Plugin
   + Mysoft.Cbxt.ContractMng.UnitTest.Plugin

6. 添加程序集引用

   > 引用的 dll 必须来自 ```..\src\00-ERP站点\bin```
   >
   > | 程序     | 引用程序集                                   |
   > | -------- | -------------------------------------------- |
   > | 主程序   |                                              |
   > |          | 1、Mysoft.Cbxt.ContractMng.Interfaces.Plugin |
   > |          | 2、Mysoft.Cbxt.ContractMng.Model.Plugin      |
   > |          | 3、Mysoft.Map6.Core                          |
   > |          | 4、Mysoft.Map6.Core.Ext                      |
   > |          | 5、Mysoft.Map6.DAL                           |
   > |          | 6、Mysoft.Map6.Data                          |
   > |          | 7、Mysoft.Map6.Platform                      |
   > |          | 8、Newtonsoft.Json                           |
   > |          | 9、Mysoft.Cbxt.ContractMng                   |
   > |          | 10、Mysoft.Cbxt.ContractMng.Model                   |
   > | 接口程序 |                                              |
   > |          | 1、Mysoft.Cbxt.ContractMng.Model.Plugin      |
   > |          | 2、Mysoft.Map6.Core                          |
   > | 实体程序 |                                              |
   > |          | 1、Mysoft.Map6.Core                          |
   > |          | 2、Mysoft.Map6.Platform                      |

7. 设置项目属性

   1. 项目属性=>生成

   ![image-20201117173324719](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117173324719.png)

8. 设置初始化

   1. 主程序 添加 ```AppInitializer``` 类

      ```c#
      internal static class AppInitializer
      {
      	public static void Init()
      	{
      
      	}
      }
      ```

   2. 主程序 Properties=>AssemblyInfo.cs

      ```c#
      [assembly: Mysoft.Map6.Core.Pipeline.ServicePlugin.PluginAssembly("*")]
      [assembly: Mysoft.Map6.Core.Web.ControllerAssembly]
      [assembly: Mysoft.Map6.Core.Common.PreApplicationStartMethod(typeof(Mysoft.Cbxt.ContractMng.Plugin.AppInitializer), "Init")]
      ```

#### 1.1.2.3 数据对象

1. 在页面建模===>>> 数据对象中添加相关字段

2. 在`Model.Plugin.Entites`中加入扩展类`BcContractEx`

   ```
   /// <summary>
   /// 补充合同扩展类
   /// </summary>
   public abstract class BcContractEx : BcContract
   {
   	/// <summary>
   	/// 业务类型
   	/// </summary>
   	[EntityColumn("x_BzType")]
   	public virtual string BzType { get; set; }
   
   	/// <summary>
   	/// 业务类型枚举
   	/// </summary>
   	[EntityColumn("x_BzTypeEnum")]
   	public virtual int BzTypeEnum { get; set; }
   }
   ```

#### 1.1.2.4 [启用扩展JS](https://open.mingyuanyun.com/docs/platform/kai-shi-qian-bi-du/xin-shou-ru-men/kuo-zhan-ye-wu-kai-fa/qian-duan-kuo-zhan-kai-fa.html)

+ 建模===>>>页面布局===>>>选择要扩展JS页面控件

  ![image-20201117175204370](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117175204370.png)

+ 页面属性===>>>自定义脚本===>>>启用扩展===>>>下载扩展模版

+ 将下载下来的模版拷贝到前端工程`/Customize/Cbxt/ContractMng/M02010302`下，最终目录为原始JS文件所在目录

+ **编译前端**，刷新下载模版页面

  ![image-20201117175842478](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117175842478.png)
+ 建议修改js文件名称，去掉前面文件路径前缀

#### 1.1.2.5 应用服务JS
> 对于产品扩展，不允许改变产品AppService.js文件

#### 1.1.2.6 扩展AppService

> 1、阅读产品代码，确定扩展模式（Before、Override、After）
> 2、如若阅读不方便，可以新建新的Service，将对应产品代码全部赋值过来，同时修改前端调用，方便调试，方便排错

#### 1.1.2.7 Handler
> 1、Handler 接口适用于文档操作Api，不允许扩展。
> 2、对于相关逻辑修改的调整，可以尝试创建新的Handler Api，前端override掉相关核心函数，指向新的Handler Api 地址


## 1.2 二开独立

### 1.2.1 程序目录

#### 1.2.1.1 解决方案目录

> 项目名字 ```Mysoft.Cbxt(子系统汉语拼音首字母).ContractMng(一级模块名称).[Interfaces|Model|UnitTest].Customize```

![image-20201116105619854](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116105619854.png)



#### 1.2.1.2 目录说明 

| 模块                                         | 目录                   | 说明 |
| -------------------------------------------- | ---------------------- | ---- |
| Mysoft.Cbxt.ContractMng.Customize            |                        |      |
|                                              | AppServices            | [应用服务](https://open.mingyuanyun.com/docs/platform/yun-xing-ping-tai/yin-yong-fu-wu-ceng.html) |
|                                              | DomainServices         | [领域服务](https://open.mingyuanyun.com/docs/platform/yun-xing-ping-tai/ling-yu-fu-wu-ceng.html) |
|                                              | Handlers               |      |
|                                              | PublicServices         |      |
|                                              | WorkFlow               |      |
|                                              | Elog                   |      |
|                                              | EventPublisher         |      |
|                                              | EventSubscribeServices |      |
|                                              | ExcelImport            |      |
|                                              | Jobs                   |      |
|                                              | Profile                |      |
|                                              | AppInitializer.cs      |      |
| Mysoft.Cbxt.ContractMng.Model.Customize      |                        |      |
|                                              | Const                  |      |
|                                              | DTO                  |      |
|                                              | Entities                  |      |
|                                              | Enum                  |      |
| Mysoft.Cbxt.ContractMng.Interfaces.Customize |                        |      |
|  |                        |      |



### 1.2.2 开发流程

> 需求：
> 1、在成本系统的合同管理模块中添加合同预算模块
> 2、实现增删查改页面
> 3、对接工作流（线上审批）

#### 1.2.2.1 解决方案

> 对产品中成本系统的合同模块进行二开

1. 在```二开整体解决方案.sln```目录下根据要二开子系统编号在产品中序号和名字建立目录及相关程序子模块
2. 成本系统在产品中的序号为02  ```/src/02 成本系统/```
3. 合同管理在成本系统中的序号为03 ```/src/02 成本系统/03 合同管理```
4. 建立```二开独立```目录 ```/src/02 成本系统/03 合同管理/02 二开独立```
5. 在二开独立目录下按照命名要求分别新建```主程序、接口程序、实体程序、单元测试```项目

   + Mysoft.Cbxt.ContractMng.Customize
   + Mysoft.Cbxt.ContractMng.Interfaces.Customize
   + Mysoft.Cbxt.ContractMng.Model.Customize
   + Mysoft.Cbxt.ContractMng.UnitTest.Customize

6. 添加程序集引用

   > 引用的 dll 必须来自 ```..\src\00-ERP站点\bin```
   | 程序     | 引用程序集                                      |
   | -------- | ----------------------------------------------- |
   | 主程序   |                                                 |
   |          | 1、Mysoft.Cbxt.ContractMng.Interfaces.Customize |
   |          | 2、Mysoft.Cbxt.ContractMng.Model.Customize      |
   |          | 3、Mysoft.Map6.Core                             |
   |          | 4、Mysoft.Map6.Core.Ext                         |
   |          | 5、Mysoft.Map6.DAL                              |
   |          | 6、Mysoft.Map6.Data                             |
   |          | 7、Mysoft.Map6.Platform                         |
   |          | 8、Newtonsoft.Json                              |
   |          |                                                 |
   | 接口程序 |                                                 |
   |          | 1、Mysoft.Cbxt.ContractMng.Model.Customize      |
   |          | 2、Mysoft.Map6.Core                             |
   | 实体程序 |                                                 |
   |          | 1、Mysoft.Map6.Core                             |
   |          | 2、Mysoft.Map6.Platform                            |

7. 设置项目属性

   1. 项目属性=>生成

      ![image-20201116140513473](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116140513473.png)

8. 设置初始化

   1. 主程序 添加 ```AppInitializer``` 类

      ```c#
      internal static class AppInitializer
      {
      	public static void Init()
      	{
      
      	}
      }
      ```
      
   2. 主程序 Properties=>AssemblyInfo.cs

      ```c#
      [assembly: Mysoft.Map6.Core.Web.ControllerAssembly]
      [assembly: Mysoft.Map6.Core.Common.PreApplicationStartMethod(typeof(Mysoft.Cbxt.ContractMng.Customize.AppInitializer), "Init")]
      ```
#### 1.2.2.2 数据对象
> 表对象命名建议加子系统缩写前缀，如 成本系统合同预算 ```cb_ContractBudget```

1. 添加字段技巧

   + 对于Key-Value类型字段建议添加两个字段，分别存储Key（GUID/Enum）、Value（Name），对应字段名称为Xxxx编码（GUID/Enum）,Xxxx，对应字段名称为XxxxCode(GUID/Enum),XxxxName
   
2. 数据对象通用命名

   | 字段             | 字段名称           |
   | :--------------- | :----------------- |
   | Name             | 名称               |
   | Code             | 编码               |
   | ParentGUID       | 父级GUID           |
   | ParentCode       | 父级编码           |
   | StartDate        | 开始日期           |
   | EndDate          | 结束日期           |
   | Remark           | 说明/备注          |
   | EffectDate       | 生效日期           |
   | ExpiryDate       | 失效日期           |
   | IsEnabled        | 是否启用           |
   | Count            | 数量               |
   | Price            | 单价               |
   | Amount           | 金额               |
   | TaxRate          | 税率               |
   | TaxPrice         | 含税单价           |
   | TaxAmount        | 税额               |
   | TotalAmount      | 合计金额           |
   | Source           | 来源               |
   | Documents        | 文档               |
   | Order            | 排序               |
   | Total***         | 合计字段           |
   | Avg***           | 平均字段           |
   | SignDate         | 签约日期           |
   | SignTime         | 签约时间           |
   | HtAmount         | 合同金额（含税）   |
   | HtInputTaxAmount | 合同进项税额       |
   | HtNoTaxAmount    | 合同金额（不含税） |
   | Price            | 单价（含税）       |
   | NoTaxPrice       | 单价（不含税）     |
   | TaxRate          | 税率               |
   | TaxAmount        | 税额               |
   | Amount           | 金额（含税）       |
   | JbrGUID      | 经办人GUID     |
   | JbrName      | 经办人名称     |
   | JbDate      | 经办日期     |
   | JbDeptGUID      | 经办部门GUID     |
   | JbDeptName      | 经办部门名称     |
   | ProjGUID      | 所属项目GUID     |
   | ProjName      | 所属项目名称     |
   | BzName      | 币种     |
   | BzUnit      | 币种单位     |
   | BUGUID | 所属业务单元 |
   | Docs | 附件 |


#### 1.2.2.3 页面导航

1. 打开建模平台

2. 定位到```导航模块```

   ![image-20201116145044914](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116145044914.png)

3. 根据模块编码和子模块数量确定模块编码，如：合同管理编码为 ```020103```,合同预算为第10个子模块，则合同预算的模块编码为 ```02010310```

#### 1.2.2.4 页面设计

1. 打开建模平台
2. 定位到```页面布局```
3. 根据页面功能需求来选择新增页面类型

   + 列表+表单（组合模版） 相当于  查询列表（单页模版）+表单（单页模版）
   + 树列表+表单（组合模版） 相当于  查询树列表（单页模版）+表单（单页模版）
   + 自定义页面
   + Aspx页面

4. 建议命名
   
   > 命名宜知名见意，以名字知晓该页面所表达的功能和业务含义
   
5. 注意：
   
   + 在2.0平台中，列表+表单（组合模版） 相当于  查询列表（单页模版）+表单（单页模版）中 行内操作按钮的样式不一致

#### 1.2.2.5 [启用自定义JS](https://open.mingyuanyun.com/docs/platform/jian-mo-ping-tai/ye-mian-jiao-hu/ye-mian-jiao-hu-js-kai-fa.html)

+ 建模===>>>页面布局===>>>选择要启用自定义JS页面控件

  ![image-20201117094150498](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117094150498.png)

+ 页面属性===>>>自定义脚本===>>>引入前端JS===>>>下载模版（如果页面ID没有修改，则按照对应命名规则修改）

+ 将下载下来的模版拷贝到前端工程`/Customize/Cbxt/ContractMng/M02010311`下，没有目录，则新建

+ **编译前端**，刷新下载模版页面

  ![image-20201117094953319](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117094953319.png)

+ 建议修改js文件名称，去掉前面文件路径前缀

#### 1.2.2.6 [启用应用服务JS](https://open.mingyuanyun.com/docs/platform/jian-mo-ping-tai/qian-hou-tai-yi-bu-diao-yong.html)

+ 生成应用服务JS

  > 打开浏览器，在地址栏输入以下形式的URL：```http://[站点]:[端口]/script/[命名控件].[应用服务类名]/proxy.aspx``` 如：```http://localhost:6070/script/Mysoft.Cbxt.ContractMng.Customize.AppServices.ContractBudgetAppService/proxy.aspx```

  ![image-20201117171224685](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117171224685.png)

+ 在前端工程`/Customize/Cbxt/ContractMng/M02010311`目录下，新建```ContractBudgetAppService.js```,将页面内容复制到该js文件中

+ 在页面JS文件中引用应用服务JS

  > 在主页面JS中```var appService = require("Mysoft.Cbxt.ContractMng.Customize.AppServices.ContractBudgetAppService");```

+ 使用应用服务JS

  ```
  return appService.Save(me.form.populateSaveData(), []).then(function (contractBudgetGUID) {
      //跳转到编辑页面
      if (editMode === 1) {
          utility.refreshWindow({"mode": 2, "oid": contractBudgetGUID}, false);
      } else {
          me.form.loadData(contractBudgetGUID);
      }
      //刷新父列表
      utility.messageTrigger(me.events.contractBudgetGridLoadEvent);
  });
  ```


### 1.2.3 列表页面

#### 1.2.3.1 过滤条件

   + 项目过滤

     > 在页面设计器，合同预算页面/页面布局/合同预算列表控件

     ![image-20201116152014501](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116152014501.png)

     >数据来源=>启用项目过滤
     >1、数据源中使用的数据对象中，必须存在一个数据对象包含ProjGuid字段，而且必须是GUID类型；
     >2、如果当前用户不是管理员， 会再根当前用户拥有权限的项目进行过滤，如果当前用户是管理员，不会进行项目权限过滤；

   + 资源化过滤

     > 数据来源=>启用资源化过滤
     > 1、数据源中使用的数据对象中，必须存在一个视图，与当前的表或视图存在关系，而且视图有UserGUID字段，才可以启用资源化过滤；
     > 2、在查询过程中，会根据当前用户的UserGUID与视图中的UserGUID进行有关联；

   + 筛选字段

     ![image-20201116154735767](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116154735767.png)

     ![image-20201116154756019](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116154756019.png)

     > 可以对类型字段、时间字段在筛选字段中进行过滤

   + 普通查询

     ![image-20201116154904322](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116154904322.png)

     ![image-20201116154919629](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116154919629.png)

     > 可以对输入字段进行过滤

   + 高级查询

     ![image-20201116155227927](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116155227927.png)

     ![image-20201116155708662](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116155708662.png)

     > 可以对时间、枚举、数字进行状态、区间查询

#### 1.2.3.2 视图列表

   + 多视图列表

     ![image-20201116160354377](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116160354377.png)

     ![image-20201116160606553](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201116160606553.png)

     > 1、在列表设计>视图中添加多视图
     > 2、在数据来源中添加各个视图对应的筛选逻辑
     > 3、在列表设计>列表属性>视图 中选择平铺和收起可以改变视图在列表页中的显示方式
     
   + 排序

     > 在视图中点击要进行排序字段，在组件属性中勾选```允许排序```

#### 1.3.3.3 操作按钮

+ 行内操作按钮一般显示逻辑

  > 已审核状态作为前置条件，才允许显示更多按钮
  
  | 操作按钮 | 命名 | 未审核 | 审核中 | 已审核 | 全部 |
  | -------- | -------- | -------- | -------- | -------- | -------- |
  | 编辑     | mEditRow | ✔ |  |  |  |
  | 详情     | mDetailRow | ✔ | ✔ | ✔ | ✔ |
  | 删除     | mDelRow | ✔ |  |  |  |
  | 更多 | mMoreRow |  |  | ✔ | ✔ |

### 1.2.4 表单页面

#### 1.2.4.1 下拉框

   + 组件===>>>下拉框
   + 数据来源-字段===>>>预算类型Enum
   + 文本字段===>>>预算类型
   + 定义备选项===>>>

     + 业务参数
     + 选择业务参数（新增）
   + 定义存储映射关系

     + 选项值-单值存储-x_ContractBudget-BudgetType
     + 选项文本-单值存储-x_ContractBudget-BudgetTypeEnum

#### 1.2.4.2. 单选框

   + 组件===>>>单选框
   + 数据来源-字段===>>>预算类型Enum
   + 文本字段===>>>预算类型
   + 定义备选项===>>>

     + 固定值
     + 新增-添加```总包-1，分包0```项
   + 定义存储映射关系

     + 选项值-单值存储-x_ContractBudget-BudgetType
     + 选项文本-单值存储-x_ContractBudget-BudgetTypeEnum

#### 1.2.4.3. 弹出页面传值

   + 组件===>>>弹出选择

   + 数据来源-字段===>>>对应主合同GUID

   + 文本字段===>>>对应主合同

   + 定义弹出行为===>>>

     + 选择页面===>>>成本公共===>>>选择页面===>>>选择合同-单选
     + 页面参数===>>>新增===>>>IsOverallContract-页面字段-预算类型Enum
     
   + 定义存储映射关系

     + 选项值-单值存储-x_ContractBudget-ContractGUID
     + 选项文本-单值存储-x_ContractBudget-ContractName
     
+ 传递额外数据到主页面

  + 启用公共页面自定义JS

  + 编写数据传递逻辑

    ```js
    var ns = {
        grid:null,
        gridId:"x_appGrid",
        // 定义待发布消息的eventId
        events:{ contractSingleSelectedEvent:"Mysoft.Cbxt.M02010000.singleContract.select" },
        /**
         *获取已选的数据
         */
        getData: function() {
            var selected = this.grid.getSelected();
            if (selected != null){
                utility.messageTrigger(this.events.contractSingleSelectedEvent, selected);
                var data = [{
                    text: selected.ContractName,
                    value: selected.ContractGUID
                }];
                return { data: data };
            }
            else {
                return [];
            }
        },
        /**
         * 弹出选择框加载后将控件值返回
         */
        setData: function(e) {
            // 接收控件值，缓存起来
            this.value = e.value;
        },
        /**
         *建模事件，页面加载完成
         */
        _pageReady:function() {
            this.grid = mapcontrol.get(this.gridId);
            // 定义 弹出选择框 getLookPopupData 方法
            window.getLookPopupData = this.getData.bind(this);
            // 定义 弹出选择框 setLookPopupData 方法
            window.setLookPopupData = this.setData.bind(this);
        }
    }
    ```

  + 编写主页面数据接收处理逻辑

    ```js
    var ns = {
        form:null,
        me:null,
        formId:"x_appForm",
        events:{ contractSingleSelectedEvent:"Mysoft.Cbxt.M02010000.singleContract.select" },
        /**
         * 监听页面消息传递事件
         */
        subscribePageMessage: function() {
            utility.messageOn(this.events.contractSingleSelectedEvent,this.contractSingleSelectedHandler);
        },
        /**
         * 选择合同（单选）事件委托
         */
        contractSingleSelectedHandler:function(evt,data) {
            me.form.get('x_BzUnit').setValue(data.BzUnit);
            me.form.get('x_BzName').setValue(data.BzName);
            me.form.get('x_ContractAmount').setValue(data.TotalAmount);
        },
        /**
         *建模事件，页面加载完成
         */
        _pageReady:function() {
            me = this;
            me.subscribePageMessage();
            me.form = mapcontrol.get(this.formId);
            //经办人部门
            var ctlJbrGuid = me.form.get("x_JbrGUID");
            var ctlDepartmentGuid = me.form.get("x_JbDeptGUID");
            var selectDepartmentId = ctlDepartmentGuid.getData();
            //绑定经办部门
            me.bindDepartmentData(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid);
        },
        /**
         * 绑定申请部门
         * @param {} selectDepartmentId 当前选择部门标识
         * @param {} ctlJbrGuid 人员组件
         * @param {} ctrlDept 部门组件
         * @returns {}
         */
        bindDepartmentData: function(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid) {
            return bindData.bindDepartmentData(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid);
        },
        // 保存事件
        _x_appForm_mSave_click:function(e){
            var formData = me.form.populateData();
            console.log(formData);
        }
    }
    ```

#### 1.2.4.4. 数据计算值

> 地产总部审核金额 = 争议金额 + 无争议金额

+ 组件===>>>数字===>>>地产总部审核金额===>>>只读模式（全部只读）

+ 组件===>>>数字===>>>争议金额 ===>>>定义事件（值改变事件）

+ 组件===>>>数字===>>>无争议金额===>>>定义事件（值改变事件）

  ```js
  /**
   * 计算地产总部审核金额
   */
  caculateDczbAuditAmount: function() {
  	var me = this;
      var disputedAmount = new mapnumber(me.form.getData("x_DisputedAmount"));
      var undisputedAmount = new mapnumber(me.form.getData("x_UndisputedAmount"));
      var dczbAuditAmount = disputedAmount.plus(undisputedAmount);
      me.form.setData("x_DczbAuditAmount",dczbAuditAmount);
  },
  // 建模事件，值改变后事件
  _x_appForm_x_DisputedAmount_valueChanged:function(e){
  	var me = this;
      me.caculateDczbAuditAmount();
  },
  // 建模事件，值改变后事件
  _x_appForm_x_UndisputedAmount_valueChanged:function(e){
  	var me = this;
      me.caculateDczbAuditAmount();
  },
  ```

> 项目核减金额 = 承包单位申报金额 - 项目审核金额

+ 组件===>>>数字===>>>项目核减金额

+ 组件===>>>数字===>>>承包单位申报金额

+ 组件===>>>数字===>>>项目审核金额===>>>数据来源（计算公式、定义公式别名、定义公式算法）===>>>只读模式（全部只读）

#### 1.2.4.5. 经办人

   + 组件===>>>自动完成-单选

   + 数据来源-字段===>>>经办人GUID

   + 默认值===>>>系统关键字+[key:本人]

   + 定义备选项===>>>

     + SQL脚本

       ```sql
       SELECT  UserName AS [text] ,
               UserGUID AS [value]
       FROM    myUser
       ```

     + 查询字段 text

   + 定义存储映射关系

     + 选项值-单值存储-x_ContractBudget-JbrGUID
     + 选项文本-单值存储-x_ContractBudget-JbrName

   + 订阅事件===>>>值改变后事件===>>>自定义动作

     ```javascript
     // 引用绑定数据通用方法
     bindData = require("Mysoft.Cbxt.Common.BindData"),
         
     // 建模事件，经办人控件值改变事件
     _x_appForm_x_JbrGUID_valueChanged: function(e) {
     	var me = this;
         var ctlJbrGuid = me.form.get("x_JbrGUID");
         var ctlDepartmentGuid = me.form.get("x_JbDeptGUID");
         var selectDepartmentId = ctlDepartmentGuid.getValue();
         //绑定经办部门
         me.bindDepartmentData(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid);
     },
         
     // 绑定部门
     bindDepartmentData: function(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid) {
     	return bindData.bindDepartmentData(selectDepartmentId, ctlJbrGuid, ctlDepartmentGuid);
     },
     ```

#### 1.2.4.6. 经办部门

   + 组件===>>>下拉框
   + 数据来源-字段===>>>经办部门GUID
   + 文本字段===>>>经办部门
   + 定义存储映射关系
     + 选项值-单值存储-x_ContractBudget-JbDeptGUID
     + 选项文本-单值存储-x_ContractBudget-JbDeptName

#### 1.2.4.7. 经办时间

   + 组件===>>>日期时间
   + 数据来源-字段===>>>经办日期
   + 显示格式===>>>日期
   + 默认值===>>>系统关键字+[key:今天]

#### 1.2.4.8. 隐藏域



#### 1.2.4.9 表单验证

> 地产总部审核金额 <= 合同金额 * 0.3

+ 表单属性===>>>定义表单校验规则===>>>地产总部审核金额校验（公司为：x_DczbAuditAmount > x_ContractAmount * 0.3）

#### 1.2.4.10 操作按钮

| 操作按钮 | 命名 | 显示逻辑 |
| -------- | -------- | -------- |
| 保存     | mSave | 编辑模式=编辑\|\|编辑模式=新增 && 审核状态=未审核 |
| 保存             | mSaveInApproving      | isWorkflowEdit=1                                  |
| 取消 | mCancel | 总是显示 |
| 发起审批（线上）     | mLaunchApproval | D&&编辑&&isWorkflow=0 |
| 提交审批（线上）     | mLaunchApprovalOnline | 审核状态=未审核&&编辑&&isWorkflow=1 |
| 审批过程（线上）     | mApprovalProcess | 审核状态<>未审核&&isWorkflowEdit<>1&&isWorkflow=0 |
| 审批通过（线下）    | mApprovalPass | 审核状态=审核中&&isWorkflow=1 |
| 审批驳回（线下）    | mApprovalReject | 审核状态<>未审核&&isWorkflow=1 |

#### 1.2.2.7 详情页面



## 1.3 开发规范

### 1.3.1 前端数值计算
> 引入 ```var mapnumber = require("mapnumber");```

| 项     | 用法                                 | 说明     |
| ---- | -------------------------------- | ---- |
| 加法 | ```mapnumber.plus(value);```     |  返回mapnumber对象    |
| 减法 | ```mapnumber.minus(value);```    |  返回mapnumber对象    |
| 乘法 | ```mapnumber.multiply(value);``` |  返回mapnumber对象    |
| 除法 | ```mapnumber.divide(value);```   |  返回mapnumber对象    |
| 求余 | ```mapnumber.mod(value);```   |  返回mapnumber对象    |
| 平方 | ```mapnumber.pow(value);```   |  返回mapnumber对象    |
| 开方 | ```mapnumber.sqrt(value);```   |  返回mapnumber对象     |
| 大于 | ```mapnumber.greaterThan(value);```   | 如果比较成立,返回true否则返回false |
| 大于等于 | ```mapnumber.greaterThanOrEqualTo(value);```   | 如果比较成立,返回true否则返回false |
| 小于 | ```mapnumber.lessThan(value);```   | 如果比较成立,返回true否则返回false |
| 小于等于 | ```mapnumber.lessThanOrEqualTo(value);```   | 如果比较成立,返回true否则返回false |
| 是否相等 | ```mapnumber.equals(value);```   | 如果比较成立,返回true否则返回false |
| 比较  | ```mapnumber.comparedTo(value);```   | 如果比较值大于被比较值,则返回1;如果比较值小于被比较值,则返回-1;<br>如果比较值等于被比较值,则返回0;如果对比的值不是有效数值返回null; |
| 是否为零  | ```mapnumber.isZero();```   | 如果比较成立,返回true否则返回false |
| 是否为负数  | ```mapnumber.isNeg();```   | 如果比较成立,返回true否则返回false  |
| 转负数  | ```ma.neg();```   | 返回mapnumber对象 |
| 求绝对值  | ```mapnumber.abs(value);```   | 返回mapnumber对象 |
| 截断   | ```mapnumber.toFixed(value);```   | 返回mapnumber对象 |
| 四舍五入  | ```mapnumber.round(value);```   | 返回mapnumber对象 |
| 向下舍入  | ```mapnumber.floor();```   | 返回mapnumber对象 |
| 向上舍入  | ```mapnumber.ceil();```   | 返回mapnumber对象 |
| 转换为字符串  | ```mapnumber.toString();```   | 返回字符串 |

### 1.3.2 函数命名规范

| 方法                | 命名                   | 示例                                          |
| :------------------ | :--------------------- | --------------------------------------------- |
| 查询                | Get***                 |                                               |
| 根据主键单例查询    | Get***ById             |                                               |
| 根据主键批量查询    | Get***ByIds            |                                               |
| 校验                | Check***               |                                               |
| 新增                | Add***                 |                                               |
| 修改                | Edit***                |                                               |
| 删除                | Delete***              |                                               |
| 保存                | Save***                |                                               |
| 取消                | Cancel***              |                                               |
| 导入                | Import***              |                                               |
| 导出                | Export***              |                                               |
| 发起审批            | LaunchApprove          |                                               |
| 审批                | ApprovePass            |                                               |
| 审批驳回            | ApproveReject          |                                               |
| 是否存在            | IsExists***            |                                               |
| 是否被使用          | IsUsed***              |                                               |
| 是否唯一            | IsUnique***            |                                               |
| 异步方法            | ***Async               |                                               |
| 实体转换            | Convert`***`By`***`    |                                               |
| 复数方法            | Get***ByIds            |                                               |
| 事务                | ***Trans               |                                               |
| 导入成功处理        | ***ImportSuccessHandle |                                               |
| 数组                | Array                  | int[] productArray                            |
| 列表                | List                   | List`<Product>`roductList                     |
| DataTable/HashTable | Table                  | HashTable productTable                        |
| 字典                | Dictionary             | Dictionary`<string,string>` productDictionary |
| 发起审批            | Approving              |                                               |
| 审批通过            | Approved               |                                               |
| 审批驳回            | UnApprove              |                                               |

### 1.3.3 弹出框（dialog）

| 名称                                                         | 类型 | 描述                                                   |
| :----------------------------------------------------------- | :--- | :----------------------------------------------------- |
| [open](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/open) | 方法 | 以弹出层方式打开指定页面                               |
| [widget](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/widget) | 方法 | 以弹出层方式显示HTML片段或者DOM元素                    |
| [close](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/close) | 方法 | 关闭窗口                                               |
| [alert](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/alert) | 方法 | 打开提示窗口                                           |
| [confirm](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/confirm) | 方法 | 打开确认窗口                                           |
| [tipSuccess](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/tipSuccess) | 方法 | 消息提示（成功类）                                     |
| [tipAlert](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/tipAlert) | 方法 | 消息提示（警示类）                                     |
| [tip](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/tip) | 方法 | 消息提示（成功\|警告）一般用于保存成功或失败等操作提示 |
| [loading](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/loading) | 方法 | 在页面显示loading浮层                                  |
| [pageLoading](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/pageLoading) | 方法 | 在页面或者指定区域中显示loading浮层                    |
| [sidePanel](https://open.mingyuanyun.com/apis/platform/fe-api/Dialog/sidePanel) | 方法 | 划出面板                                               |

### 1.3.4 JS扩展代码

#### 1.3.4.1 模版说明

```js

define("Mysoft.Cbxt.M02010302.ContractGridList.Plugin", function (require, exports, module, $product) {

    //var utility = require("utility");
    //var dialog = require("dialog");
    //var appService = require("Mysoft.xxx.xxx.AppService");

    /** 私有变量定义到这里
    var eventEnum = {
        //刷新机会列表
        OppReload: "Mysoft.Slxt.M00110616.BookingAdd.OppReload"
    }; 
    **/
    var ns = {
        /**Plugin模块中ns对象内不允许定义属性,避免和产品属性造成冲突**/
        /** 二开新增方法 **/
        _btnCancel_Click: function () {
            //调用产品模块
            //$product.checkOrder();
        },
        /** 产品方法扩展区域**/
        __module_plugins__: {
            /*_btnExample_Click: {
                before: function (arg1, $e) {
                    //$e参数在全部参数尾部, 参数仅获取时使用

                    //二开在before方法中修改参数
                    $e.setArg("arg1", "this is before")
                    //获取参数
                    var arg11 = $e.getArg("arg1")
                    //获取全部参数, { arg1: "this is before"}
                    var args = $e.getArgs()
                    $e.setData("name", "value"); //设置扩展数据, 用于传递数据到 override 或 after 流程
                    $e.setData({name: "value"}); //覆盖全部扩展数据, 只能传标准 json 数据为参数

                    //执行异步，自定义异步
                    var p = $e.beginAsync();
                    dialog.alert("确认删除？", function (action) {
                        if (action === "ok") {
                            p.resolve(args); //异步逻辑成功
                        } else {
                            p.reject(); //中断 override 或 after 执行
                        }
                    });

                    $e.setReturnValue("12"); //设置返回值后跳出aop流程, 之后的 override 或 after 不会执行
                    //return 这里return的返回值无效
                },
                override: function (arg1, $e) {
                    var name1 = $e.getData("name"); //获取before传递的扩展数据
                    var data1 = $e.getData(); //获取全部扩展数据
                    //arg1为方法的输入参数
                    $e.cancel();//中断after方法执行, 只能在同步方法内使用
                    $e.setReturnValue("返回值"); //这里的返回值在after方法中通过getReturnValue接收
                    //$e.getReturnValue();  //override内调用getReturnValue() 会抛出异常 无法获取返回值
                    //return "返回值"; return 无效
                },
                after: function (args, $e) {
                    //args为方法的输入参数

                   var returnValue =  $e.getReturnValue();//此方法可以获取产品接口的返回值
                   returnValue.count += 10;
                   $e.setReturnValue(returnValue);//设置方法返回值

                   //return //这里return的返回值无效
                }
            }*/
        }

        /****/
    }

    module.exports = ns;// source
});
```

1. 格式要求

   > 1、```define("Mysoft.Cbxt.M02010302.ContractGridList.Plugin"``` 必须是`要扩展的产品JS模块`+`.Plugin`，否则系统无法识别扩展与被扩展的关系。
>
   > 2、JS扩展模块 中多了一个 $product 对象，该对象可以访问被扩展的产品模块 公开成员的JS成员，ns 内部 成员。

2. 二开新增函数：

   > 二开新增加的函数添加位置如图，在ns内部，非___module_plugins___内部

   ![image-20201117182912276](%E6%A0%B8%E5%BF%83ERP%E5%BC%80%E5%8F%91.assets/image-20201117182912276.png)

3. 扩展函数与原始函数对应关系

   ```js
   /**
    * 校验规则
    * @param bizType 业务类型
    * @param pageMode 页面模式
    * @param e 事件源对象
    */
   baseCheckRule: function(bizType,pageMode,e) {
       me.checkUniqeRule();
   },
   /**
    * 校验唯一规则
    */
   checkUniqeRule: function() {
       
   },   
   ```

   ```js
   /** 产品方法扩展区域**/
   __module_plugins__: {
       baseCheckRule: {
           /**
            * 校验规则
            * @param p1 对应 bizType
            * @param p2 对应 pageMode
            * @param p3 对应 e
            * @param $e 扩展函数自带参数，必须有
            */
           override: function(p1,p2,p3,$e) {
               // 调用产品中的函数
               $product.checkUniqeRule();
               /**
                * 编写自定义逻辑
                */ 
           }
       }    
   }
   ```

#### 1.3.4.2 Before 模式（执行前）

> 1、**Before** 模式，在产品方法执行前调用，可以新增自己的扩展逻辑，运用于 **扩展校验**,**修改参数值** 等场景。
> 2、***修改参数***，只能通过 扩展参数**$e** 调用 **$e.setArg('参数名',值)** 的方式修改，**不能直接修改参数值**。
> 3、**取消产品方法执行**,只能通过 扩展参数**$e** 调用 **$e.cancel()** 的方式取消执行，不能使用 return 的方式取消。

```js
define("Mysoft.Cbxt.M00010104.Demo.Plugin", function (require, exports, module, $product) {
    var dialog = require('dialog');
    var ns = {
        /** 
        * 产品方法扩展区域
        */
        __module_plugins__: {
            /** 扩展产品JS对应的save方法 */
            save:{
                before:function(data,$e){
                    if(data.code.length < 6){
                        dialog.alert('Code长度不能小于6位');
                        // 取消执行
                        $e.cancel();
                    }
                    // 给参数赋一个新值
                    data.code = 'M'+data.code;
                    $e.setArg('data',data);
                }
            }            
        }
    }
    module.exports = ns;
});
```

#### 1.3.4.3 Override 模式（覆盖）

> 1、**Override** 模式，会直接对原产品方法进行重写，只要定义了 **override, 原 产品方法将不再执行**。适用于**二开与原产品需求差异大**此类型场景。
> 2、**修改返回值**,只能通过 扩展参数**$e** 调用 **$e.setReturnValue(返回值) 的方式修改返回值**，不能使用 return 返回。
> 3、**产品JS公开成员**,只能通过 模块扩展参数 **$product** 来访问 产品JS 公开的成员（对象，属性，方法）。

```js
define("Mysoft.Cbxt.M00010104.Demo.Plugin", function (require, exports, module, $product) {
    var ns = {
        /** 
        * 产品方法扩展区域
        */
        __module_plugins__: {
            /** 扩展产品JS对应的isTaxMode方法 */
            isTaxMode:{
                override:function($e){
                    // 通过 `$product` 获取产品JS公开的成员
                    var taxType = $product.form.getData("TaxType");
                    var isTax = (taxType === 2);
                    // 通过 `setReturnValue` 设置方法返回值
                    $e.setReturnValue(isTax);
                }
            }            
        }
    }
    module.exports = ns;
});
```

#### 1.3.4.4 After 模式（执行后）

> 1、**After** 模式，在产品JS方法执行完后执行。适用于在产品代码基础上追加逻辑等场景。
> 2、after 定义的方法会在 产品方法执行完成后执行，同样也可以修改返回值。 
> 3、after 模式，只能通过 **扩展参数$e 调用 $e.setReturnValue(返回值) 的方式修改返回值。**

```js
define("Mysoft.Cbxt.M00010104.Demo.Plugin", function (require, exports, module, $product) {
    var ns = {
        /** 
        * 产品方法扩展区域
        */
        __module_plugins__: {
            /** 扩展产品JS对应的isTaxMode方法 */
            appformSave:{
                after:function($e){
                    $product.form.setMode(3);
                }
            }            
        }
    }
    module.exports = ns;
});
```
#### 1.3.4.5 异步场景

> 1、**当扩展方法中存在异步请求，都视为 `异步场景`**
> 2、若产品方法不存在异步请求且存在返回值，`after` 方法内则不能使用异步请求。
>
> 3、如果**既要中断当前代码逻辑**，又要**取消产品函数的执行**，则**先$.cancel,然后return**即可

```js
var ns = {
        /** 产品方法扩展区域**/
    __module_plugins__: {
        _appForm_mSave_click: {
            before: function (evt,$e) {
                var appForm = mapcontrol.get("appForm");
                var bzType = appForm.getData("x_BzType");
                if (bzType === "预转固") {
                    // 校验是否存在合同预算单
                    var contractBudget = appForm.get("itemlist_vbrp").getData();
                    if (contractBudget.length === 0) {
                        //如果字段值为空，则弹出提示信息
                        dialog.tipAlert('未找到合同预算单！');
                        //弹出提示后，阻止产品的函数执行，终止后续操作
                        $e.cancel();
                        return;
                    }
                    // 验证合同金额是否合法
                    var dfd = $e.beginAsync();
                    var contractGUID = appForm.getData("MasterContractGUID");
                    contractBudgetAppService.GetContrctBudgetAmount(contractGUID).then(function(result) {
                        // 预算单金额
                        var budgetAmount = new mapnumber(result);
                        if(budgetAmount.greaterThan(0)){
                            // 补充合同金额
                            var totalAmount = new mapnumber(appForm.getData("TotalAmount"));
                            if(totalAmount.greaterThan(budgetAmount)) {
                                dialog.tipAlert('补充合同金额不能大于预算单金额！');
                                dfd.reject();
                            }
                            dfd.resolve();
                        } else {
                            dialog.tipAlert('未找到合同预算单！')
                            // 取消异步调用链, 不能使用 $e.cancel()
                            dfd.reject();
                        }
                    });
                }
            }
        }
    }
    /****/
}
```

#### 1.3.4.5 $e解析

| 接口                       | 名称             | 描述                                                         |
| :------------------------- | :--------------- | :----------------------------------------------------------- |
| `$e.setArg(name, value)`   | 修改参数值       | `name`须与参数名一致, `after`阶段不允许再修改参数            |
| `$e.getArg(name)`          | 获取参数值       | `name`须与扩展方法定义的参数名一致                           |
| `$e.getArgs()`             | 获取全部参数     | 返回的对象格式为 `{ '参数名1': '参数值1', '参数名2': '参数值2' }` |
| `$e.getReturnValue()`      | 获取接口返回值   | `before`, `override` 阶段不能使用                            |
| `$e.setReturnValue(value)` | 设置返回值       | 使用该方法后直接跳出流程, 同步接口返回设置的返回值, 异步接口设置回调数据 |
| `$e.beginAsync()`          | 创建异步对象     | 每个阶段只能创建一次                                         |
| `$e.cancel()`              | 取消执行后续阶段 |                                                              |

### 1.3.5 数据实体

> 1、如果数据库列名和属性名不一样，必须用**EntityColumn("列名")**特性进行映射
> 2、如果数据库表名和类名不一样，必须用**EntityName("表名")**特性进行映射
> 3、类用**Serializable**特性描述
> 4、实体类定义为抽象类，防止主动实例化对象
> 5、实体类必须定义在`Mysoft.[Cbxt].[ContractMng].Model.[Customize/Plugin]`项目内

#### 1.3.5.1 二开

> 1、必须继承自**Entity**

```c#
/// <summary>
/// 合同预算实体
/// </summary>
[Serializable]
[EntityName("x_ContractBudget")]
public abstract class ContractBudget : Entity
{
	/// <summary>
	/// 申请人GUID
	/// </summary>
	[EntityColumn("x_ApplyGUID")]
	public virtual Guid? ApplyGUID { get; set; }
	/// <summary>
	/// 申请人姓名
	/// </summary>
	[EntityColumn("x_ApplyName")]
	public virtual string ApplyName { get; set; }
    /// <summary>
	/// 预算类型
	/// </summary>
	[EntityColumn("x_BudgetType")]
	public virtual string BudgetType { get; set; }
	/// <summary>
	/// 预算类型值
	/// </summary>
	[EntityColumn("x_BudgetTypeEnum")]
	public virtual int BudgetTypeEnum { get; set; }
    /// <summary>
	/// 所属公司GUID
	/// </summary>
	[EntityColumn("x_BUGUID")]
	public virtual Guid BUGUID { get; set; }
}
```

#### 1.3.5.2 扩展

>1、必须继承自原扩展实体，命名为**原实体名+“Ex”**

```c#
/// <summary>
/// 补充合同扩展类
/// </summary>
public abstract class BcContractEx : BcContract
{
	/// <summary>
	/// 业务类型
	/// </summary>
	[EntityColumn("x_BzType")]
	public virtual string BzType { get; set; }

	/// <summary>
	/// 业务类型枚举
	/// </summary>
	[EntityColumn("x_BzTypeEnum")]
	public virtual int BzTypeEnum { get; set; }
}
```

### 1.3.6 后台服务

> 1、服务接口必须定义在`Mysoft.[Cbxt].[ContractMng].Interfaces.[Customize/Plugin]`项目内

#### 1.3.6.1 应用服务AppService

> Map中的应用服务可以理解为MVC里面的Controller，系统会自动将 AppService 中的用`ActionDescription`特性描述的public方法解析成MVC中的Action
1. AppService 类必须继承自 `AppService` 基类，
2. AppService 类必须用`[AppServiceScope("子系统名称", "子系统编码", "模块名称", "模块编码")]`特性描述
3. Api 函数必须定义为**Public**,必须定义为**虚(Virtual)方法**,必须用`[ActionDescription("操作名称", "操作编码")]`特性描述
4. 接口的**参数、返回值**只能是**值类型或DTO对象**（可正确序列化的对象），**不能是Entity**；
5. AppService服务中的方法要对入口参数进行有效性校验，如果参数为空或类型不正确，及时抛出异常，异常为**BusinessLogicException或者其子类型**；
6. **ExecutionContext.UserContext**：获取当前当前用户信息，包含Guid、Code、名称
7. AppService 中可以对**DomainService,PublicService,EntityService,CacheService,第三方接口**进行调用
8. AppService / PubAppService中**禁止前端访问**的公开方法需要加上**Forbidden**标记

```
/// <summary>
/// 合同预算应用服务
/// </summary>
[AppServiceScope("成本系统", "0201", "合同预算", "x_02010310")]
public class ContractBudgetAppService : AppService
{
	#region 注册服务
	private readonly LazyService<ContractBudgetDomainService> _contractBudgetDs = new LazyService<ContractBudgetDomainService>();

	private readonly LazyService<ContractDomainService> _contractDs = new LazyService<ContractDomainService>();
	#endregion
	/// <summary>
	/// 保存数据
	/// </summary>
	/// <param name="data"></param>
	/// <param name="customData"></param>
	/// <returns></returns>
	[ActionDescription("保存合同预算", "02")]
	public virtual Guid Save(FormEntity data, string[] customData)
	{
		if (data == null)
		{
			throw new ArgumentNullException(nameof(data));
		}

		var budget = data.Get<ContractBudget>();
		if (budget == null)
		{
			throw new ArgumentException(nameof(budget));
		}

		Guid contractGuid = budget.ContractGUID;
		if (contractGuid == Guid.Empty)
		{
			throw new ArgumentException(ContractBudgetMngLangRes.L0201_x_02010310_ContractIsNull);
		}

		Contract contract = _contractDs.Instance.GetContractById(contractGuid);
		if (contractGuid == null)
		{
			throw new ArgumentException(ContractBudgetMngLangRes.L0201_x_02010310_ContractIsNull);
		}

		budget.ApproveStatusEnum = ApproveStateEnum.Pending;
		budget.ApproveStatus = CommonLangRes.CommonApproveStateEnumPending;

		//保存前校验
		_contractBudgetDs.Instance.CheckBeforeSave(budget, contract);

		// 更新字段
		data.Update(budget);

		Guid budgetGuid = Guid.Empty;
		if (budget.EntityState == Map6.Core.EntityBase.EntityState.Created)
		{
			budgetGuid = _contractBudgetDs.Instance.InsertContractBudget(budget);
		}
		else
		{
			budgetGuid = _contractBudgetDs.Instance.UpdateContractBudget(budget);
		}

		return budgetGuid;
	}


	/// <summary>
	/// 合同预算
	/// </summary>
	/// <param name="contractGUID">合同预算标识</param>
	/// <returns>合同</returns>
	[ActionDescription("合同预算", "00")]
	public virtual ContractBudget GetContractById(Guid contractGUID)
	{
		if (contractGUID == Guid.Empty)
		{
			throw new BusinessLogicException(nameof(contractGUID));
		}
		return _contractBudgetDs.Instance.GetContractBudgetById(contractGUID);
	}

	/// <summary>
	/// 删除合同预算前校验
	/// </summary>
	/// <param name="contractBudgetGUID"></param>
	[ActionDescription("删除合同预算前校验", "00")]
	public virtual void CheckBeforeDelete(Guid contractBudgetGUID)
	{
		// 入参校验
		if (contractBudgetGUID == Guid.Empty)
		{
			throw new ArgumentNullException(nameof(contractBudgetGUID));
		}

		ContractBudget contractBudget = _contractBudgetDs.Instance.GetContractBudgetById(contractBudgetGUID);
		_contractBudgetDs.Instance.CheckBeforeDelete(contractBudget);
	}

	/// <summary>
	/// 删除合同预算
	/// </summary>
	/// <param name="contractBudgetGUID"></param>
	[ActionDescription("删除合同预算", "00")]
	public virtual void Delete(Guid contractBudgetGUID)
	{
		// 入参校验
		if (contractBudgetGUID == Guid.Empty)
			throw new ArgumentNullException(nameof(contractBudgetGUID));

		// 删除
		ContractBudget contractBudget = _contractBudgetDs.Instance.GetContractBudgetById(contractBudgetGUID);
		_contractBudgetDs.Instance.DeleteContractBudget(contractBudget);
	}
}
```

#### 1.3.6.2 公开服务PublicService

> 1、为其他子系统提供API调用接口
> 2、为第三方调用提供API调用接口。
> 3、采用DI/IoC设计思想

1. 定义接口

   ```
   using System;
   using Mysoft.Map6.Core.Service;
   using Mysoft.Slxt.ProjectPrep.Model;
   
   namespace Mysoft.Slxt.ProjectPrep.Interfaces
   {
       /// <summary>
       /// 项目准备PubliceService
       /// </summary>
       interface IProjectPrepPublicService: IPublicService
       {
           /// <summary>
           /// 获取房间信息
           /// </summary>
           /// <param name="roomId"></param>
           /// <returns></returns>
           Room GetRoom(Guid roomId);
       }
   }
   ```

2. 实现接口

   ```c#
   using Mysoft.Map6.Core.Pipeline.PipelineAttribute;
   using Mysoft.Map6.Core.Service;
   using System;
   
   namespace Mysoft.Slxt.ProjectPrep.AppServices
   {
       /// <summary>
       /// 房间AppService
       /// </summary>
       [AppServiceScope("销售系统", "0011", "房源管理", "00110103")]
       public class RoomAppService : AppService, IProjectPrepPublicService
       {
           #region 注册服务
           /// <summary>
           /// 房间领域服务
           /// </summary>
           private readonly LazyService<RoomDomainService> _roomDomainService = new LazyService<RoomDomainService>();
           #endregion
   
           /// <summary>
           /// 获取房间信息，通过房间Id
           /// </summary>
           /// <param name="roomId">房间Id</param>
           /// <returns>房间实体</returns>
           public Room GetRoom(Guid roomId)
           {
               return _roomDomainService.Instance.GetRoom(roomId);
           }
       }
   }
   ```

3. 因为是用DI/IoC思想设计，所以需要进行接口注入，平台中必须要在```AppInitializer```进行接口注入

   ```c#
   using Mysoft.Map6.Core.Pipeline;
   using Mysoft.Slxt.ProjectPrep.AppServices;
   using Mysoft.Slxt.ProjectPrep.Interfaces;
   
   namespace Mysoft.Slxt.ProjectPrep
   {
       /// <summary>
       /// 初始化类
       /// </summary>
       internal static class AppInitializer
       {
           /// <summary>
           /// 初始化：建立接口类和实现类的映射
           /// </summary>
           public static void Init()
           {
               PublicServiceContainer.Register<RoomAppService>().As<IProjectPrepPublicService>();
           }
       }
   }
   ```


#### 1.3.6.3 领域服务

> 1、**领域服务层的代码，尽量基于实体对象进行逻辑操作，而不要基于string、int等基本类型；**
> 2、**领域服务应该尽量摆脱对数据库的依赖，这样有利于做单元测试。**
> 3、DomainService 类必须继承自 `DomainService ` 基类，
> 4、方法必须标记成virtual方法，平台通过重写虚方法的方式实现扩展。 
> 5、领域服务中可以调用同子系统的DomainService、EntityService，不能跨子系统调用。

#### 1.3.6.4 数据服务

> 1、EntityService 和 RepositoryService 类似
> 2、适用于EF部分特性，事务性提交、工作单元
> 3、支持Linq查询，是否支付延迟查询（未知）
> 4、实体服务的NoLock查询类似于EF的AsNoTracking查询
> 5、XmlCommand 和 Mybatis 类似（未知）

### 1.3.7 Dto、枚举常量
> 1、必须定义在`Mysoft.[Cbxt].[ContractMng].Model.[Customize/Plugin]`项目内

#### 1.3.7.1 DTO
> 1、必须标记成Serializable并以Dto结尾

```c#
///<summary>
///认购
///</summary>
[Serializable]
[DtoDescription("楼栋信息")]
public class OrderDto
{
    ///<summary>
    /// 认购Id
    ///</summary>
    public virtual Guid OrderGUID { get; set; }

    ///<summary>
    /// 房间Id
    ///</summary>
    public virtual Guid RoomGUID { get; set; }

    ///<summary>
    /// 协议总价
    ///</summary>
    public virtual decimal CjRmbTotal { get; set; }
}
```

#### 1.3.7.2 枚举

> 1、由于Enum的定义固定，无法动态增加新成员，不利于二开扩展，因此使用静态类代替Enum以便二开扩展。
> 2、枚举值标记EnumOrder用于排序,当枚举用于下拉框等空间数据源时,会按照EnumOrder标记的数值升序。建议产品开发时将排序值设置为10，20，30等值，便于二开扩展。
> 3、枚举定义为静态类，枚举值定义为静态只读字段，类名以Enum结尾
> 4、枚举值标记MultiLanguage特性可以实现多语言,MultiLanguage参数是多语言key
> 5、枚举值必须定义成静态只读字段

```c#
namespace Mysoft.Slxt.TradeMng.Model
{
    /// <summary>
    /// 订单类型
    /// </summary>
    public static class OrderTypeEnum
    {
        /// <summary>
        /// 认购
        /// </summary>
        [MultiLanguage("TradeMng_SOrderOrderTypeEnum_0001")]
        [EnumOrder(10)]
        public static readonly int Order = 0;
        /// <summary>
        /// 小订
        /// </summary>
        [MultiLanguage("TradeMng_SOrderOrderTypeEnum_0002")]
        [EnumOrder(20)]
        public static readonly int LittleBook = 1;
        /// <summary>
        /// 预留
        /// </summary>
        [MultiLanguage("TradeMng_SOrderOrderTypeEnum_0003")]
        [EnumOrder(30)]
        public static readonly int Obligate = 2;
    }
}
```

#### 1.3.7.3 常量
> 1、常量类型要申明成以static并以Const结尾
> 2、常量字段要申明成static并readonly

```c#
/// <summary>
/// 认购证件类型
/// </summary>
public static class OrderCardTypeConst
{
    /// <summary>
    /// 军官证
    /// </summary>
    public static readonly string Ofiicer ="3";
    /// <summary>
    /// 身份证
    /// </summary>
    public static readonly string Identity = "1";
    /// <summary>
    /// 护照
    /// </summary>
    public static readonly string Passport = "2";
}
```

#### 1.3.7.4 AutoMapper

1. 定义对象映射配置

   ```
   public class TestProfile : MapProfile
   {
       public TestProfile()
       {
           // 创建实体与Dto的对象映射，并忽略Country字段
           CreateMap<Address, AddressDTO>().ForMember(x=>x.Country,opt=>opt.Ignore());
   
           // 创建Dto与实体的映射，并且包含二开字段
           CreateMapIncludeCustomField<AddressDTO, Address>();
       }
   }
   ```

2. 在初始化代码中启动映射配置

   ```
   internal static class AppInitializer
   {
   	public static void Init()
   	{
   		ObjectMapper.Options.AddProfile<TestProfile>()
   	}
   }
   ```

3. 使用示例

   ```c#
   // 实体映射到dto
   var dto = ObjectMapper.Default.Map<Dto>(entity)
   
   // dto映射到实体
   var entity2 = ObjectMapper.Default.Map<Entity>(dto)
   ```

### 1.3.8 后台扩展代码

> 1、先确定要修改的AppService类，定义为 AppServicePlugin,继承自 `PluginBase<AppService>`
> 2、确定要修改的AppService函数及修改模式（before、override、after）
> 3、定义新函数 SaveOrder[Before/After],Override模式，函数名字不变
> 4、添加PluginMethod特性，`[PluginMethod(nameof(TradeAppService.SaveOrder), PluginMode.Override)]`
> 5、Before方法与After方法必须是void方法
> 6、同一个插件类中，对同一个方法按插件的工作模式，最多只能扩展一次
> 7、同一个方法，Override模式只能扩展一次，在不同的插件类中，对同一个方法Before和After模式可以扩展多次
> 8、方法已经存在Override模式的方法扩展，Before和After模式的方法都不会执行
> 9、不支持泛型方法
> 10、只能在Befor、Override模式才能修改参数值，在Override模式下才能执行InvokeBaseMethod方法，在After模式才能获取和设置方法返回的值

#### 1.3.8.1 PluginBase

| 方法                      | 描述                            | 适用模式     |
| :------------------------ | :------------------------------ | :----------- |
| `InvokeBase`              | 执行被重写的方法                | Override模式 |
| `InvokeBase<TResult>`     | 执行被重写的方法,泛型返回值     | Override模式 |
| `GetReturnValue<TResult>` | 获取方法执行的返回值,泛型返回值 | After模式    |
| `SetReturnValue<TResult>` | 设置方法执行的返回值,泛型返回值 | After模式    |

#### 1.3.8.2 Before

```c#
using Mysoft.Map6.Core.Pipeline.ServicePlugin;
using Mysoft.Slxt.TradeMng.AppServices;
using Mysoft.Slxt.TradeMng.Model.DTO;

namespace Mysoft.Slxt.CustomerName.TradeMng.Plugin.AppServices
{
    /// <summary>
    /// 交易管理扩展
    /// </summary>
    public class TradeAppServicePlugin: PluginBase<TradeAppService>
    {
        /// <summary>
        /// 保存认购前扩展
        /// </summary>
        /// <param name="subscribeSaveDto"></param>
        [PluginMethod(nameof(TradeAppService.SaveOrder), PluginMode.Before)]
        public void SaveOrderBefore(SubscribeSaveDto subscribeSaveDto)
        {
            // 实现客户个性化需求

            // 可以对目标方法的参数进行修改
            // 只有Before、Override模式才可以修改目标方法参数，否则会抛出异常
            subscribeSaveDto.Order.QSDate = DateTime.Now;
        }
    }
}
```

#### 1.3.8.3 Override

```
using Mysoft.Map6.Core.Pipeline.ServicePlugin;
using Mysoft.Slxt.TradeMng.AppServices;
using Mysoft.Slxt.TradeMng.Model.DTO;

namespace Mysoft.Slxt.CustomerName.TradeMng.Plugin.AppServices
{
    /// <summary>
    /// 交易管理扩展
    /// </summary>
    public class TradeAppServicePlugin: PluginBase<TradeAppService>
    {
        /// <summary>
        /// 保存认购重写扩展
        /// </summary>
        /// <param name="subscribeSaveDto"></param>
        [PluginMethod(nameof(TradeAppService.SaveOrder), PluginMode.Override)]
        public void SaveOrder(SubscribeSaveDto subscribeSaveDto)
        {
            // 实现客户个性化需求

            // 可以对目标方法的参数进行修改
            // 只有Before、Override模式才可以修改目标方法参数，否则会抛出异常
            subscribeSaveDto.Order.QSDate = DateTime.Now;

            // 可以调用被重写的方法
            // 此接口只允许在Override扩展模式下调用，否则会抛出异常
            InvokeBase();
        }
    }
}
```

#### 1.3.8.4 After

```
using Mysoft.Map6.Core.Pipeline.ServicePlugin;
using Mysoft.Slxt.TradeMng.AppServices;
using Mysoft.Slxt.TradeMng.Model.DTO;

namespace Mysoft.Slxt.CustomerName.TradeMng.Plugin.AppServices
{
    /// <summary>
    /// 交易管理扩展
    /// </summary>
    public class TradeAppServicePlugin: PluginBase<TradeAppService>
    {
        /// <summary>
        /// 保存认购后扩展
        /// </summary>
        /// <param name="subscribeSaveDto"></param>
        [PluginMethod(nameof(TradeAppService.SaveOrder), PluginMode.After)]
        public void SaveOrderAfter(SubscribeSaveDto subscribeSaveDto)
        {
            // 实现客户个性化需求

            // 不可以修改目标方法的参数subscribeSaveDto，否则会抛出异常

            // 可以获取扩展方法的返回值
            // 此接口只允许在After扩展模式下调用，否则会抛出异常
            Guid orderId = GetReturnValue<Guid>();
            // 也可以设置扩展方法的返回值
            // 此接口只允许在After扩展模式下调用，否则会抛出异常
            SetReturnValue(orderId);
        }
    }
}
```



### 1.3.9 基础编码规范

#### 1.3.9.1 平台建模规范

1. 【强制】创建页面过程中，页面ID名称使用英文字母和数字，首字符为字母，禁止使用拼音，使用Pascal命名，字符控制在30以内 正例：CommissionApplyList 反例：CommissionApply / YongJinShenQin / x_List_7679

2. 【强制】创建页面过程中，页面开放级别在二开新增页面时选择`完全开放`

3. 【强制】配置类业务参数常用于业务判断、逻辑分支控制、属性配置类场景 正例：是否启用审批 / 单价保留位

4. 【强制】数据列表中，计算公式列不允许超过3个，因为超过3个后公式的计算降低SQL的执行效率，最终延长页面的加载时间，建议改成简单公式或者优化需求场景

5. 【强制】下拉选项控件中，无论是那个选项来源，定义备选项的个数不能超过50个

6. 【强制】分区多、控件多（子控件、相关列表）开启按需加载

   + 表单按需加载后无法使用 get 接口获取子控件信息，所有与子控件相关的操作统一由表单来处理
   + 表单启用按需加载后，不能随意取消按需加载，或者直接对某一个非按需加载的表单启用按需加载
   + 表单是否启用按需加载需要在完成功能开发前明确，一旦完成开发将不可随意更改状态

7. 【强制】禁止启用数据自动加载后在_pageReady中再次触发Query事件

   > 这样会造成二次加载，如果需要在_pageReady中指定过滤条件后触发Query，请关闭数据自动加载

8. 【推荐】建模数据源不允许关联包含超过5张表（包含视图中的表）

9. 【强制】拼接URL，HTML，必须使用平台工具方法utility.buildUrl, utility.tmpl。

10. 【强制】使用JavaScript原生的数值计算，请使用平台提供的 mapnumber 组件。

#### 1.3.9.2 后端性能规范

	1. 【强制】字符串比较避免不必要的大小写转换逻辑，使用String.Compare方法代替
 	2. 【强制】事务尽可能短小，减少事务持有时间（包括将查询操作放在事务外）
 	3. 【强制】尽量减小锁的粒度和锁定范围来提升系统吞吐
 	4. 【强制】使用有序GuidHelper.NewSeqGuid()代替Guid.NewGuid()

#### 1.3.9.3 数据库性能规范

1. 【强制】使用参数化查询，重用执行计划

2. 【强制】尽量使用UNION ALL而不是UNION

3. 【强制】WHERE过滤条件要符合SARG原则

   > SARG: Searchable Arguments

   搜索参数 (SARG) 可指定精确匹配、值的范围或由 AND 联接的两项或多项的连接，因此能够限制搜索范围。

   SARG格式：

   - 列 运算符 <常量或变量>
   - <常量或变量> 运算符 列

   SARG 运算符包括 =、>、<、>=、<=、IN、BETWEEN，有时还包括 LIKE（在进行前缀匹配时，如 LIKE ‘Fish%'）。

   SARG 可以包括由 AND 联接的多个条件。

   非 SARG 运算符包括：`NOT运算符 、函数调用 和 字段计算表达式。`

4. 【推荐】索引列不允许超过3个字段，索引包含列不允许超过10个字段（建议只包含关联表的过滤条件字段、排序字段）

5. 【推荐】单表索引不允许超过10个 说明：索引越多维护代价越大，影响数据插入和更新的性能

6. 【强制】非聚集索引中不需要包含聚集索引健 说明：非聚集索引中的叶子节点已经包含了聚集索引健

7. 【推荐】GuidList冗余字段设计不允许超过10个拼接

8. 【强制】尽量使用有序GUID，避免直接使用 newid()。

