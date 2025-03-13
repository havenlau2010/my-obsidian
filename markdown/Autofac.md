# Autofac

Autofac 是一款IoC框架，比较于其他的IoC框架，如 Spring.Net,Unity,Castle等等所包含的，它很轻量级，性能上非常高。
[官方网站](http://autofac.org/)
[源码](https://github.com/autofac/Autofac)

## 控制反转(IoC/Inverse Of Control)

    调用者不再创建被调用者的实例，由Autofac框架实现（容器创建）所以称为控制反转。

## 依赖注入(DI/Dependence injection)

    容器创建好实例后再注入调用者称为依赖注入。

## 如何将Autofac 整合到应用里面

    1.  按照IoC的思想构建应用
    2.  添加Autofac引用
    3.  在Startup处 创建 ContainerBuilder，注册要注入的组件
    4.  创建容器，保存 以备后续使用
    5.  应用执行阶段，从容器中创建一个生命周期，从此在生命周期作用域内解析组件实例

## 安装 Autofac

`Install-Package Autofac`

## 注入方法

    > 扫描类型 RegisterAssemblyTypes() 注册，接受一个或者多个程序集的数组，程序集必须是public的
    > 扫描模块 RegisterAssemblyModules() 注册，名字是什么，就执行哪个,它通过Autofac 模块提供的程序集扫描，创建模块实例，然后使用当前container builder 注册他们。

## 注入模式

1. 使用ContainerBuilder
   
    ```

    fun(x:Int,y:Int):Int{
        return x+y  
    }

   ```

2. 使用统一的注入接口类
