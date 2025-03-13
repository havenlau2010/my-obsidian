---

---

[TOC]

# bsti backend specification

## 1. 术语

### 1.1 帕斯卡名法（Pascal）

   > 将标识符的首字母和后面连接的每个单词的首字母都大写。例：BackColor

### 1.2 驼峰命名法（Camel）

   > 标识符的首字母小写，而每个后面连接的单词的首字母都大写。例：backColor

### 1.3 匈牙利命名法

   > 变量名＝属性＋类型＋对象描述。例：tmpStrBackColor

## 2. 代码风格

### 2.1 列宽

  > 代码列宽控制在120字符左右。

### 2.2 缩进

+ 缩进应该是每行一个Tab(4个空格)，不要在代码中使用Tab字符。

+ 代码段与代码段之间的缩进保持一致

### 2.3 空格

  > 空格是为了将不同作用的定义区分开，以便提高代码的可阅读性。
  > + 关键字和左括符 “(” 应该用空格隔开。如：```while (true)```
  > + 多个参数用逗号隔开，每个逗号后都应加一个空格。```public int Add(int firstNumber, int lastNumber){}```
  >
  > + 除了 . 之外，所有的二元操作符都应用空格与它们的操作数隔开。一元操作符、++及--与操作数间不需要空格。如：
  >
  > ```C#
      bool isExists = true;
      int deletedNum = 0;
      int existsNum = 0;
      if (!isExists)
      {
          deletedNum++;
          existsNum = existsNum > 0 ? existsNum - 1 : existsNum;
      }
  ```

      var result = from a in T.Table select a;
  ```

  >
  >+ 语句中的表达式之间用空格隔开 如：```for(int index = 0; index++; index < length){}```
  >+ 中括号使用不需要添加空格 如： ```list[0]```



### 2.4 换行

  > 当表达式超出或即将超出规定的列宽，遵循以下规则进行换行
  >
  > + 在逗号后换行
  > + 在操作符前换行
  > + 规则1优先于规则2



### 2.5 空行

  > 空行是为了将逻辑上相关联的代码分块，以便提高代码的可阅读性。
  >
  > **在以下情况下使用两个空行**
  >
  > + 接口和类的定义之间。
  > + 枚举和类的定义之间。
  > + 类与类的定义之间。
  >
  > **在以下情况下使用一个空行**
  >
  > - 方法与方法、属性与属性之间。
  > - 方法中变量声明与语句之间。
  > - 方法与方法之间。
  > - 方法中不同的逻辑块之间。
  > - 方法中的返回语句与其他的语句之间。
  > - 属性与方法、属性与字段、方法与字段之间。
  > - 注释与它注释的语句间不空行，但与其他的语句间空一行。



### 2.6 括号()

  + 左括号“(”不要紧靠关键字，中间用一个空格隔开。如：```while (true)```
  + 左括号“(”与方法名之间不要添加任何空格。如 ```public int Add(int firstNumber, int lastNumber){}```
  + 没有必要的话不要在返回语句中使用()。



### 2.7 花括号{}

  - 左花括号 “{” 放于关键字或方法名的下一行并与之对齐。如：

  - 左花括号 “{” 要与相应的右花括号 “}”对齐。

  - 通常情况下左花括号 “{”单独成行，不与任何语句并列一行。

  - if、while、do语句后一定要使用{}，即使{}号中为空或只有一条语句。

  - 右花括号 “}” 后建议加一个注释以便于方便的找到与之相应的 {。如:

    ```C#
    while (true)
    {
        bool isValid = true;
        if (isValid)
        {
        } // if valid
        else
        {
        } // not valid
    } // end loop
  ```



### 2.8 注释

  - 单行注释,在闭合的右花括号后注释该闭合所对应的起点。双斜杠后留一个空格 再输入注释内容 如：

    ```C#
    /// <summary>
    /// 状态
    /// </summary>
    private int status = 0;
    
    while (true)
    {
        // 是否验证通过
        bool isValid = true;
        if (isValid)
        {
            // step 1
            // step 1.1
            
            // step 2
    
        } // if valid
        else
        {
    
        } // not valid
    } // end loop
    ```

  - 多行注释
  
    ```
    /*
    SignalR 连接逻辑
    */
    ```
  
  - 文档型注释
  
    ```C#
    // If compiling from the command line, compile with: -doc:YourFileName.xml
    
    /// <summary>
    /// Class level summary documentation goes here.
    /// </summary>
    /// <remarks>
    /// Longer comments can be associated with a type or member through
    /// the remarks tag.
    /// </remarks>
    public class TestClass : TestInterface
    {
        /// <summary>
        /// Store for the Name property.
        /// </summary>
        private string _name = null;
    
        /// <summary>
        /// The class constructor.
        /// </summary>
        public TestClass()
        {
            // TODO: Add Constructor Logic here.
        }
    
        /// <summary>
        /// Name property.
        /// </summary>
        /// <value>
        /// A value tag is used to describe the property value.
        /// </value>
        public string Name
        {
            get
            {
                if (_name == null)
                {
                    throw new System.Exception("Name is null");
                }
                return _name;
            }
        }
    
        /// <summary>
        /// Some other method.
        /// </summary>
        /// <returns>
        /// Return values are described through the returns tag.
        /// </returns>
        /// <seealso cref="SomeMethod(string)">
        /// Notice the use of the cref attribute to reference a specific method.
        /// </seealso>
        public int SomeOtherMethod()
        {
            return 0;
        }
    }
    ```
  
    
  
  - 对于有代码管理（git）的代码,修改记录(修改人和修改日期)可以不作为注释加入到代码中
  
  - 如果需要用到region对代码进行组织，建议重构代码

    

## 3. 声明

  - 一行只建议作一个声明，并按字母顺序排列（for 循环例外）。如：

    ```C#
     int a = 0, ab = 0; // 不推荐
     int b = 0;
     int level; // 推荐
     int size; // 推荐
     int x, y; // 不推荐
    ```

  - 严格禁止不同层次间的变量重名，如：
  
    ```C#
    /// <summary>
    /// 状态
    /// </summary>
    private string status = "";

    public string GetStatus() 
    {
        int statusNum = 0;
        string status = statusNum == 1 ? "正常" : "无效";
        return status;
    }
    ```

  - 字段的声明
    
    + 不要使用是 public 或 protected 的实例字段。
  - 初始化
    
    + 建议在变量声明时就对其做初始化。


## 4. 命名

### 4.1 概述

  > 名称应该说明“什么”,而不是“如何”。通过避免使用公开基础实现（它们会发生改变）的名称，可以保留简化复杂性的抽象层。例如，可以使用```GetNextStudent()```，而不是 ```GetNextArrayElement()```

+ 命名原则

  > 足够短,表现力强,见名知意

+ 推荐命名方法

  + 避免容易被主观解释的难懂的名称，如方面名 `AnalyzeThis()`，或者属性名 `xxK8`。这样的名称会导致多义性。
  + 在类属性的名称中包含类名是多余的，如 `Book.BookTitle`。而是应该使用 `Book.Title`。
  + 只要合适，在变量名的末尾或开头加计算限定符`（Avg、Sum、Min、Max、Index）`。
  + 在变量名中使用互补对，如 `min/max、begin/end` 和 `open/close`。
  + 布尔变量名应该包含 `Is`，这意味着 `Yes/No` 或 `True/False` 值，如 `isFileFound`。
  + 在命名状态变量时，避免使用诸如 `Flag` 的术语。状态变量不同于布尔变量的地方是它可以具有两个以上的可能值。不是使用 `documentFlag`，而是使用更具描述性的名称，如 `documentFormatType`。
  + 即使对于可能仅出现在几个代码行中的生存期很短的变量，仍然使用有意义的名称。仅对于短循环索引使用单字母变量名，如 i 或 j。 可能的情况下，尽量不要使用原义数字（幻数）或原义字符串，如`for (int i = 1; i < 7; i++)`。而是使用命名常数，如 `for (int i = 1; i < NUM_DAYS_IN_WEEK; i++)` 以便于维护和理解。

### 4.2 大小写

- 组织名缩写使用大写
- 两个或者更少字母组成的标识符使用大写。例：

  ```C#
  using BSTI.Vls.Core;
  using System.IO;
  ```

- 大写场景
  
  | 标识符     | 大小写      | 示例      |
  | ---- | ---- | ---- |
  | 类            | Pascal | AppDomain   |
  | 枚举类型      | Pascal | ErrorLevel  |
  | 枚举值        | Pascal | FatalError  |
  | 事件          | Pascal | ValueChange  |
  | 异常类        | Pascal | WebException 注意: 总是以 Exception 后缀结尾。 |
  | 只读的静态字段  | Pasca | RedValue  |
  | 接口          | Pascal | IDisposable 注意: 总是以 I 前缀开始。  |
  | 方法          | Pascal | ToString  |
  | 命名空间      | Pascal | System.Drawing  |
  | 属性          | Pascal | BackColor  |
  | 公共实例字段   | Pascal | RedValue 注意: 应优先使用属性。  |
  | 受保护的实例字 | Camel | redValue 注意: 应优先使用属性。  |
  | 私有的实例字段 | Camel | redValue  |
  | 参数         | Camel  | typeName  |
  | 方法内的变量  | Camel | backColor     |

### 4.3 缩写

- 不要将缩写或缩略形式用作标识符名称的组成部分。例如，使用 GetWindow，而不要使用GetWin。
- 不要使用计算机领域中未被普遍接受的缩写。
- 在适当的时候，使用众所周知的缩写替换冗长的词组名称。例如，用 UI 作为 User Interface 缩写，用 OLAP 作为 On-line Analytical Processing 的缩写。
- 在使用缩写时，对于超过两个字符长度的缩写请使用 Pascal 大小写或 Camel 大小写。例如- - 使用 HtmlButton；但是，应当大写仅有两个字符的缩写，如：System.IO，而不是 System.Io。
- 不要在标识符或参数名称中使用缩写。如果必须使用缩写，对于由多于两个字符所组成的缩写请使用Camel 大小写。

### 4.4 命名空间

- 命名命名空间时的一般性规则是使用公司名称，后跟技术名称和可选的功能与设计，如：
  ```CompanyName.TechnologyName[.Feature][.Design]```
  ```using BSTI.Vls.Service.Implement;```
- 命名空间使用Pascal大小写。
- TechnologyName 指的是该项目的英文缩写或软件名。
- 命名空间和类不能使用同样的名字。例如，有一个类被命名为Debug后，就不要再使用Debug作为一个名称空间名。

### 4.5 类

- 使用 Pascal 大小写。
- 用名词或名词短语命名类。
- 使用全称避免缩写，除非缩写已是一种公认的约定，如URL、HTML
- 不要使用类型前缀，如在类名称上对类使用 C 前缀。例如，使用类名称 FileStream，而不是CFileStream。
- 不要使用下划线字符 (_)。
- 有时候需要提供以字母 I 开始的类名称，虽然该类不是接口。只要 I 是作为类名称组成部分的整个单词的第一个字母，这便是适当的。例如，类名称 IdentityStore 是适当的。在适当的地方，使用复合单词命名派生的类。派生类名称的第二个部分应当是基类的名称。例如，ApplicationException 对于从名为 Exception 的类派生的类是适当的名称，原因ApplicationException 是一种Exception。请在应用该规则时进行合理的判断。例如，Button 对于从 Control 派生的类是适当的名称。尽管按钮是一种控件，但是将 Control 作为类名称的一部分将使名称不必要地加长。
- 例子:

  ```C#
  public class FileStream
  public class Button
  public class String
  ```

### 4.6 接口

- 用名词或名词短语，或者描述行为的形容词命名接口。例：
- 使用 Pascal 大小写。
- 少用缩写。
- 给接口名称加上字母 I 前缀，以指示该类型为接口。在定义类/接口对（其中类是接口的标准实现）时使用相似的名称。两个名称的区别应该只是接口名称上有字母 I 前缀。
- 不要使用下划线字符 (_)。
- 例子:

  ```C#
  public interface IComponent{}
  public interface IDelete{}
  public interface IAudited{}
  public class Component: IComponent{}
  ```

### 4.7 属性类

- 属性类总是将后缀 Attribute 添加到自定义属性类。例：

  ```C#
  public class ExceptionHandlerAttribute: ExceptionFilterAttribute{}
  public class ErrorLogAttribute: ExceptionFilterAttribute{}
  ```

### 4.8 枚举

- 枚举 (Enum) 值类型从 Enum 类继承。

- 对于 Enum 类型和值名称使用 Pascal 大小写。

- 少用缩写。

- 不要在 Enum 类型名称上使用 Enum 后缀。

- 对大多数 Enum 类型使用单数名称，但是对作为位域的 Enum 类型使用复数名称。

- 总是将 FlagsAttribute 添加到位域 Enum 类型。

- 所有对于枚举类型值的判断，建议使用枚举值判断，例如：

  ```c#
  if(userType == Enum.UserType.Student.Value())
  {
      // student logic
  }
  
  switch (userType)
      case Enum.UserType.Student:
  		break;
      case Enum.UserType.Teacher:
  		break;
      case Enum.UserType.Admin:
  		break;
  	default:
  		break;
  ```

  
### 4.9 参数

- 使用描述性参数名称。参数名称应当具有足够的描述性，以便参数的名称及其类型可用于在大多数情况下确定它的含义。
- 对参数名称使用 Camel 大小写。
- 使用描述参数的含义的名称，而不要使用描述参数的类型的名称。开发工具将提供有关参数的类型的有意义的信息。因此，通过描述意义，可以更好地使用参数的名称。
- 不要给参数名称加匈牙利语类型表示法的前缀，仅在适合使用它们的地方使用它们。
- 不要使用保留的参数。保留的参数是专用参数，如果需要，可以在未来的版本中公开它们。相反，如果在类库的未来版本中需要更多的数据，请为方法添加新的重载。
- 例子:

  ```C#
  Type GetType(string typeName)
  /// <summary>
  /// 获取wwwroot路径
  /// </summary>
  /// <param name="relativePath">相对路径</param>
  public static string GetWebRootPath( string relativePath ) 
  {
      if( string.IsNullOrWhiteSpace( relativePath ) )
      {
          return string.Empty;
      }
      
      var rootPath = Web.WebRootPath;
      if( string.IsNullOrWhiteSpace( rootPath ) )
      {
          return Path.GetFullPath( relativePath );
      }
      
      string webRootPath = $"{Web.WebRootPath}\\{relativePath.Replace( "/", "\\" ).TrimStart( '\\' )}";
      
      return webRootPath;
      
  }
  ```

### 4.10 方法

- 使用动词或动词短语命名方法。动词+[名词|形容]

- 使用 Pascal 大小写。

- 例如：

  ```C#
  DoSomething()
  RemoveAll()
  GetMaxScore()
  Invoke()
  ```

### 4.11 属性

- 使用名词或名词短语命名属性。[形容词]+名词

- 使用 Pascal 大小写。

- 考虑用与属性的基础类型相同的名称创建属性。例如，如果声明名为 `Color` 的属性，则属性的类型同样应该是 Color。

- 例如：

  ```C#
  public enum Color
  {
      White,
      Red,
      Black
  }
  
  public class Control
  {
      public int Width {get;set;}
  
    public int Height {get;set;}
      
      public Color BackColor {get;set;}
      
      public Color BackgroundColor {get;set;}
      
      public string BackgroundImage {get;set;}
  }
  ```
  

### 4.12 事件

- 对事件处理程序名称使用 `EventHandler` 后缀。

- 指定两个名为 `sender` 和 `e` 的参数。`sender` 参数表示引发事件的对象。`sender` 参数始
  终是 `object` 类型的，即使在可以使用更为特定的类型时也如此。与事件相关联的状态封装
  在名为 `e` 的事件类的实例中。对 `e` 参数类型使用适当而特定的事件类。

- 用 `EventArgs` 后缀命名事件参数类。

- 考虑用动词命名事件。

- 使用动名词（动词的“ing”形式）创建表示事件前的概念的事件名称，用过去式表示事
  件后。例如，可以取消的 `Close` 事件应当具有 `Closing` 事件和 `Closed` 事件。不要使用
  `BeforeXxx/AfterXxx` 命名模式。

- 不要在类型的事件声明上使用前缀或者后缀。例如，使用 `Close`，而不要使用 `OnClose`。

- 通常情况下，对于可以在派生类中重写的事件，应在类型上提供一个受保护的方法（称为
  `OnXxx`）。此方法只应具有事件参数 `e`，因为发送方总是类型的实例。

- 例如：

  ```
  public delegate void MouseEventHandler(object sender, MouseEventArgs e);

  public class MouseEventArgs : EventArgs 
  {
      int x;
      int y;

      public MouseEventArgs(int x, int y) 
      {
          this.x = x;
          this.y = y; 
      }
      
      public int X
      {
          get
          {
              return x;
          }
      }
      
      public int Y
      {
          get
          {
              return y;
          }
      }
  }
  ```

  

### 4.13 常量

- 所有单词大写，多个单词之间用 "_" 隔开。 如：

  ```C#
  public const string INPUT_STRING = "XXX";
  ```

  

### 4.14 字段

- private、protected 使用 Camel 大小写。

- 严禁使用public 修饰字段。

- 拼写出字段名称中使用的所有单词。仅在开发人员一般都能理解时使用缩写。

  ```C#
  class TestClass
  {
      string url;
      string destinationUrl;
  }
  ```

- 不要对字段名使用匈牙利语表示法。好的名称描述语义，而非类型。

- 不要对字段名或静态字段名应用前缀。具体说来，不要对字段名称应用前缀来区分静态和非静态字段。例如，应用 `g_` 或 `s_` 前缀是不正确的。

- 对预定义对象实例使用公共静态只读字段。如果存在对象的预定义实例，则将它们声明为对象本身的公共静态只读字段。使用 Pascal 大小写，原因是字段是公共的。

  ```C#
  public struct Color
  {
      public static readonly Color Red = new Color(0x0000FF);
  
      public Color(int rgb)
      {
          // Insert code here.
      }
  
      public Color(byte r, byte g, byte b)
      {
          // Insert code here.
      }
  
      public byte RedValue 
      {
          get
          {
              return Color;
          }
      }
  }
  ```

  

### 4.15 静态字段

- 使用名词、名词短语或者名词的缩写命名静态字段。
- 使用 Pascal 大小写。
- 建议尽可能使用静态属性而不是公共静态字段。

### 4.16 集合

- 集合是一组组合在一起的类似的类型化对象，如哈希表、查询、堆栈、字典和列表，集合的命名建议用复数。

### 4.17 措词

- 避免使用与常用的 .NET 框架命名空间重复的类名称。例如，不要将以下任何名称用作类名称：System、Collections、Forms 或 UI。有关 .NET 框架命名空间的列表，请参阅类库。
- 另外，避免使用与C#语言关键字冲突的标识符。

## 5. 语句

### 5.1 单行语句

- 每行最多包含一个语句。如：

  ```C#
  a++; // 推荐
  b--; // 推荐
  a++; b--; // 不推荐
  ```

### 5.2 复合语句

- 复合语句是指包含"父语句{子语句;子语句;}"的语句

- 子语句要缩进。

- 左花括号“{” 在复合语句父语句的下一行并与之对齐，单独成行。

- 即使只有一条子语句要不要省略花括号“ {}”。 如：

  ```
  while (d += s++)
  {
      n++;
  }
  ```

### 5.3 return 语句

- return语句中不使用括号，除非它能使返回值更加清晰。如：

  ```C#
  return;
  return myDisk.size();
  return (size ? size : defaultSize);
  ```

### 5.4 if、if-else、if else-if 语句

```C#
if (condition)
{
    statements;
}
else if (condition)
{
    statements;
}
else
{
    statements;
}
```



### 5.5 for、foreach语句

+ **for 语句使用格式**

  ```
  for (initialization; condition; update)
  {
      statements;
  }
  ```

+ **空的 for 语句**（所有的操作都在`initialization`、`condition` 或 `update`中实现）使用格式

  ```
  for (initialization; condition; update); // update user id
  ```

+ **foreach 语句使用格式**

  ```
  foreach (object obj in array)
  {
      array.Remove(0);
      statements;
  }
  ```

+ 在循环过程中不要修改循环计数器。

+ 对每个空循环体给出确认性注释。

### 5.6 while 语句

```
while (condition);
```



### 5.7 do-while 语句

```
do
{
    statements;
} while (condition);
```



### 5.8 switch-case 语句

```
switch (condition)
{
    case 1:
        statements;
        break;

    case 2:
        statements;
        break;

    default:
        statements;
        break;
}
```

*注意：*

- 语句switch中的每个case各占一行。
- 为所有switch语句提供default分支。
- 所有的非空 case 语句必须用 break; 语句结束。

### 5.9 try-catch-finally 语句

```
try
{
    statements;
}
catch (ExceptionClass e)
{
    statements;
}
finally
{
    statements;
}
```



### 5.10 表达式

- 避免在表达式中用赋值语句
- **避免对浮点类型做等于或不等于判断**


### 5.11 类型转换

- 尽量避免强制类型转换。
- 如果不得不做类型转换，尽量用显式方式。



## 6. 开发建议
1. 类内函数、属性和变量的调用在前面加上this.

2. 静态元素(元素包括变量和方法)的调用，一定要加类名避免阅读混乱。

3. 引用类型转换：使用as运算符，优点是转换不成功时，返回值为null，不抛出异常。

4. 避免在循环中创建对象，在需要逻辑分支中创建对象，使用常量避免创建对象

5. 避免循环次数为1的循环。

6. 使用变量保存中间数据，而不是每次都计算，避免不必要的损失性能。

7. 在需要大量字符串连接的时候，使用StringBuilder类。

8. 如果能计算出字符串长度的话，则按这个长度来设定StringBuilder类Buffer 的初值。

9. 在需要使用格式化字符串时，使用String.Format而不是使用字符串相加。

10. 尽量避免数据类型转换，避免装箱和拆箱，使用值类型的ToString方法

11. 浮点运算Float并不比Double要快，当转换为Int时，Double可能更高。

12. 右移和预计算优化是有效的

13. 减少冗余运算和无用的重复调用

14. 善用Hashtable，当数据量极大时Hashtable的扩容消耗极其惊人，一般使用Dict就足够了。

15. 在资源不再使用时手动释放，不要等待GC的回收，GC并不总是靠谱。

16. 只要可能，就缓存数据和页输出

17. 使用缓存考虑命中率，选择合适的缓存策略

18. 异常处理的最重要原则就是：**不要吃掉异常**。

19. **除非要处理，否则就不要捕获异常**

20. 如果有可能，禁用Session

21. 反射是一项很好用的技术，很方便，但不要滥用。

22. 一个.cs源文件至多定义两个类型

    1. 如果两个类型的关系是紧密相关的，比如 产品、产品类型，此时Product类，和ProductType枚举可以定义在同一个Product.cs文件中。
    2. 但不能在一个.cs文件中出现两个不相关的类型定义，例如将 Product类和Reseller类（分销商）定义在一个BasicInfo.cs文件中。

23. 类型名称和源文件名称必须一致

    1. 当类型命名为Product时，其源文件命名只能是Product.cs。

25. 调用类型内部其他成员，需加this；调用父类成员，需加base

26. 类型内部的私有和受保护字段，使用Camel风格命名，但加“_”前缀

27. 类型成员的排列顺序

    字段：私有字段、受保护字段

    属性：私有属性、受保护属性、公有属性

    事件：私有事件、受保护事件、公有事件

    构造函数：参数数量最多的构造函数，参数数量中等的构造函数，参数数量最少的构造函数

    方法：重载方法的排列顺序与构造函数相同，从参数数量最多往下至参数最少。

28. 委托和事件的命名

    委托以EventHandler作为后缀命名，例如 SalesOutEventHandler。

    事件以其对应的委托类型，去掉EventHandler后缀，并加上On前缀构成。

29. 返回bool类型的方法、属性的命名

    如果方法返回的类型为bool类型，则其前缀为Is、Can或者 Try

30. 常见集合类型后缀命名

    | 标识符               | 大小写     | 示例                                       |
    | -------------------- | ---------- | ------------------------------------------ |
    | 数组                 | Array      | int[] productArray                         |
    | 列表                 | List       | List<Product> productList                  |
    | DataTable/HashTable  | Table      | HashTable productTable                     |
    | 字典                 | Dictionary | Dictionay<string,string> productDictionary |
    | EF中的DbSet /DataSet | Set        | DbSet<Product> productSet                  |

31. 常见后缀命名

    | 标识符         | 大小写     | 示例         | 示例说明          |
    | --------------| ----------| ------------|------------|
    | 数组           | Array     | int[] productArray                    |数组           |
    | 费用相关 | Cost | ShipCost | 运输费 |
    | 价格相关 | Price | ProductUnitPrice | 产品单价 |
    | 消息相关 | Message（弃用Note） | SuccessMessage | 成功消息 |
    | 日期相关 | Date（弃用Time） | OrderDate | 下单日期 |
    | 计数、数量相关 | Count（弃用Time） | LoginCount | 登录次数 |
    | 链接地址相关 | Url | BlogUrl | 博客链接 |
    | 图片相关 | Image | SignImage | 签名图片 |
    | 金额相关 | Amount | PrepaidAmount | 预付款 |
    | 点数、积分相关 | Point | MemberPoint | 会员积分 |
    | 记录、日志相关 | Record（弃用Log） | ErrorRecord | 错误记录 |
    | 配置相关 | Config | DataBaseConfig | 数据库配置 |
    | 状态相关 | Status | OrderStatus | 订单状态 |
    | 模式、方式相关 | Mode | OpenMode | 打开方式 |
    | 种类相关 | Category / Type 二选一 | UserCategory | 用户种类 |
    | 工厂类相关 | Factory | ConnectionFactory | 连接工厂 |
    | 启用相关 | Enabled | ExportEnabled | 开启导出 |
    | 流相关 | Stream | UploadStream | 上传流 |
    | 读取器相关 | Reader | ExcelReader | Excel读取器 |
    | 写入器相关 | Writer | ExcelWriter | Excel写入器 |
    | 适配器相关 | Adapter | IntroOPAdapter | IntroOP适配器 |
    | 提供器相关 | Provider | MemebershipProvider | 会员信息提供器 |
    | 包装器相关 | Wrapper | ProductWrapper | Product包装器 |
    | 连接相关 | Connection | ExcelConnection | Excel连接 |

32. 常见类型命名

    | **类型**   | **命名**                       | **类型**      | **命名**                         |
    | ---------- | ------------------------------ | ------------- | -------------------------------- |
    | 客户       | Customer                       | 分销商        | Reseller                         |
    | 零售商     | Retailer                       | 经销商/批发商 | Dealer                           |
    | 用户       | UserInfo（User为数据库关键字） | 订单          | OrderInfo（Order为数据库关键字） |
    | 供应商     | Supplier                       | 管理员        | Admin                            |
    | 密码       | Password                       | 会员          | Member                           |
    | 评论       | Remark（弃用Comment）          | 文章          | Article                          |
    | 新闻       | News                           | 发票          | Invoice                          |
    | 导入       | Import                         | 导出          | Export                           |
    | 公司、企业 | Company（弃用Enterprise）      | 产品          | Product                          |
    | 省份       | Province                       | 城市          | City                             |
    | 区县       | District                       | 地址          | Address                          |
    | 角色       | Role（弃用Group）              | 权限          | Authority（弃用Permission）      |
    | 仓库       | Warehouse                      | 工厂          | Plant                            |
    | 登录       | Login（弃用SignIn）            | 登出          | LogOut（弃用SignOut）            |
    | 创建       | Create（弃用Add）              | 编辑          | Edit                             |
    | 更新       | Update                         | 删除          | Remove（弃用Delete）             |
    | 照片       | Photo                          | 图片          | Image                            |

33. 常见字段、属性命名

    | **类型**    | **名称**                            | **类型**         | **名称**                |
    | ----------- | ----------------------------------- | ---------------- | ----------------------- |
    | Id（int型） | Id（“d”小写，弃用ID）               | GuidId（Guid型） | Id                      |
    | Name        | 名称                                | Title            | 标题                    |
    | Remark      | 备注、描述（弃用Memo、Description） | Category         | 种类（弃用Class、Type） |
    | Linkman     | 联系人                              |                  |                         |

34. Roslyn 规范

    1. 命名规则

       1. 不要命名“Reserved”枚举值，避免命名“Reserved”枚举值。如果添加“Reserved”值，则在产品的较新版本中实际用到该值时，将在进行删除时导致重大更改。
       2. 字符串组合词应采用正确的大小写，避免从字典中现有的分立词条创建组合词。例如，不要创建诸如“StopWatch”或“PopUp”之类的组合词。这些词条在字典中已收录，其正确的大小写应为“Stopwatch”和“Popup”。
       3. 标识符应以大小写之外的差别进行区分，所使用的名称不应仅通过大小写差别来保持其唯一性。不论使用区分大小写的语言还是不区分大小写的语言，组件都必须完全可用。如果除大小写外其他上下文均相同，则不区分大小写的语言将无法区分两个名称，因此组件必须避免出现这种情况。
       4. 标识符的大小写应当正确，类型、命名空间和成员标识符应采用 Pascal 大小写格式。参数标识符应采用 Camel 大小写格式。这些标识符内由两个字母组成的首字母缩略词应全部大写，例如，应采用 System.IO，而不是 System.Io。由三个或更多个字母组成的首字母缩略词应采用 Pascal 大小写格式，例如，应采用 System.Xml，而不是 System.XML。Pascal 大小写格式约定每个单词的首字母大写，如 BackColor。Camel 大小写格式约定第一个单词的首字母小写，所有后续单词的首字母都大写，如 backgroundColor。尽管有些由两个字母组成的首字母缩略词习惯采用不完全大写形式，但不能因此而排斥此规则。例如，“DbConnection”很常见，但并不正确，应采用 DBConnection。为了与现有的非托管符号方案兼容，可能需要违反此规则。但一般来说，这些符号在使用它们的程序集之外不可见。
       5. 标识符应具有正确的后缀，扩展特定基类型的类型具有指定的名称后缀。例如，扩展 Attribute 的类型应具有“Attribute”后辍，如 ObsoleteAttribute。此规则检查扩展几种基类型扩展的类型，这些基类型包括 Attribute、Exception、EventArgs、IMembershipPermission、Stream 等。对于那些不扩展某些基类型的类型，不应使用保留的名称后缀。对于类型和成员，不应使用“Ex”或“New”来将它们与早期版本的 API 区分，而应使用数值后缀(如“2”)或提供一个更能体现其意义的后缀。具体的类型实现和成员不应以“Impl”结尾。对于成员，应考虑使用所建议的“Core”来替代“Impl”或者根本不采用任何后缀。
       6. 不要将类型名用作枚举值的前缀，组成枚举类型的单个枚举值不应以类型名作为前缀。
       7. 事件不应具有 before 或 after 前缀，应分别为事前事件和事后事件使用现在时和过去时，避免使用“Before”和“After”。例如，应使用 Closing 和 Closed，而不应使用 BeforeClose 和 AfterClose。
       8. Flags 枚举应采用复数形式的名称，带有 FlagsAttribute 标记的枚举应采用复数形式的名称。
       9. 标识符应具有正确的前缀，使用字母“I”作为接口名称的前缀来表明该类型是一个接口，如 IFormattable。使用字母“T”作为泛型类型参数名称的前缀并为它们提供说明性名称，如 Dictionary&lt;TKey, TValue&gt;，但如果一个“T”已足以说明这是一个泛型类型参数名称，如 Collection&lt;T&gt;，则不必这样做。对于接口名称和类型参数名称应使用 Pascal 大小写格式。请慎用缩写词。不要使用下划线字符。在定义一对类/接口时(其中类是接口的标准实现)，请务必使用相似的名称。两者之间的差别仅在于接口名称带有字母 I 前缀，如 Component 和 IComponent。
       10. 标识符不应与关键字冲突，应避免使用与保留的语言关键字冲突的标识符。如果使用保留的语言关键字作为标识符，则会使其他语言的使用者很难使用您的 API。
       11. 标识符不应包含类型名称，应避免在参数和成员中使用特定于某一种语言的类型名称，避免在参数中使用数据类型标识符。类型名对于所有开发人员来说可能不够直观。建议选用通用名称，如“value”。如果不足以区分，应确保采用 .NET Framework 库中定义的类型名，并完全避免采用特定于某一种语言的类型名称。例如，特定于 C# 的类型名有“float”(如果通用名称不足以区分，则使用“Single”)和“ulong”(如果通用名称不足以区分，则使用“UInt64”)等等。
       12. 属性名不应与 get 方法冲突。发现与某一属性同名的 Get 方法。Get 方法和属性的名称应能够明确区分其功能上的差异。

    2. 数据流规则

       1. 如果某个类型继承自一个可释放类型，则该类型必须从其自身的Dispose方法内调用其基类的Dispose方法

    3. 设计规则

       1. 不要在泛型类型中声明静态成员，调用泛型类型的静态成员的语法很复杂，因为必须为每个调用指定类型参数。
       2. 具有可释放字段的类型应该是可释放的，声明可释放成员的类型也应实现 IDisposable。如果该类型没有任何非托管资源，请不要在其上实现终结器。
       3. 不要公开泛型列表，不要在对象模型中公开 List&lt;T&gt;。应使用 Collection&lt;T&gt;、ReadOnlyCollection&lt;T&gt; 或 KeyedCollection&lt;K,V&gt;。List&lt;T&gt; 应通过实现来使用，而不是在对象模型 API 中使用。List&lt;T&gt; 针对性能进行了优化，但代价是需要长期进行版本管理。例如，如果将 List&lt;T&gt; 返回到客户端代码，您将无法再在客户端代码修改集合时收到通知。
       4. 泛型方法应提供类型参数，以下方法令人难以理解，在这些方法中，类型参数无法从参数中推理出来，因此必须在方法调用中定义。如果方法带有类型化为泛型方法类型参数的形参，则这些方法支持推理；如果方法没有类型化为泛型方法类型参数的形参，则这些方法不支持推理。
       5. 避免泛型类型的参数过多，避免泛型类型的类型参数在两个以上，因为如果类型的参数列表很长，用户将难以理解其中各项参数的含义。
       6. 不要将泛型类型嵌套在成员签名中，避免如下的 API: 要求用户以另一个泛型类型为类型实参来实例化一个泛型类型。这样的语法过于复杂。
       7. 枚举应具有零值，通常，枚举应具有零值。如果使用 Flags 特性修饰枚举，则该枚举应该具有一个值为零、表示空状态的成员。可选择“None”作为该成员的名称。对于带 Flags 特性的枚举来说，值为零的成员是可选的，但如果存在则始终应名为“None”。该值应指示尚未在相应枚举中设置任何值。如果将值为零的成员用于其他目的，则与 Flags 特性的用法相反，因为对于该成员来说，AND 和 OR 运算符无效。
       8. 集合应实现泛型接口，非泛型强类型集合应实现泛型集合接口之一。这样可以更好地将集合与泛型 API 集成。
       9. 考虑将基类型作为参数传递，如果仅使用参数的基类中的方法和属性，则将基类型用作方法的参数可以提高这些方法的重复利用率。例如，如果仅调用 Stream.Read()，则使用 Stream 而不是 FileStream 作为参数，这可以使该方法适用于所有类型的流，而不仅仅适用于 File 流。
       10. 抽象类型不应具有构造函数，抽象类型的公共构造函数没有意义，因为您无法创建抽象类型的实例。
       11. 重载加法方法和减法方法时重载相等运算符，重载加运算符和减运算符时，请确保以一致的方式定义相等运算符(==)。
       12. 定义特性参数的访问器，为命名参数和位置参数提供访问器。特性的每个位置参数都应声明一个名称相同但大小写不同的只读属性。每个命名参数都应提供一个名称相同但大小写不同的读/写属性。
       13. 避免使用类型极少的命名空间，命名空间一般应具有五个以上的类型。
       14. 避免使用 out 参数，使用 out 参数可能表示存在设计缺陷。虽然有时允许使用 out 参数，但频繁使用这些参数则表示设计没有遵守托管代码的设计原则。
       15. 索引器不应是多维的，索引器(带索引的属性)应使用单值作为索引值(可以是整数或字符串类型)。多维索引器会显著降低库的可用性。例如，public object this [int index1, int index2] 不是一个直观的索引器。
       16. 在适用处使用属性，在大多数情况下，应使用属性而不是 Get/Set 方法。在下列情况下，方法比属性更可取: 第一，执行的是转换操作，操作开销大或具有显著的副作用；第二，执行的顺序很重要；第三，连续两次调用成员得到的结果不同；第四，静态成员却返回了可变的值；第五，成员返回了数组。
       17. 用形参数组替换重复的实参，同一类型实参的几个实例最好作为参数数组实参来实现。一般说来，如果某个成员声明了三个以上同一类型的实参，便可以考虑使用形参数组。
       18. 不应使用默认形参，某些编程语言不支持默认形参。用提供默认实参的方法重载来替换默认形参。
       19. 枚举存储应为 Int32，使用小于 Int32 的类型基本上没有好处。如果出现下列情况，您可能需要使用大于 Int32 的类型: 1) 枚举值为标志，已存在或将存在多个值(&amp;amp;gt;32)；2) 该类型要与 Int32 不同，以便向后兼容。应避免使用非整型的基础类型。
       20. 不要捕捉一般异常类型，不应捕捉 Exception 或 SystemException。捕捉一般异常类型会使库用户看不到运行时问题，并会使调试复杂化。您应该仅捕捉自己可以进行适当处理的异常。
       21. 实现标准异常构造函数，正确实现一个自定义异常需要多个构造函数。缺少构造函数会使您的异常在某些情况下无法使用。例如，在 XML Web services 中处理异常需要序列化构造函数。
       22. 接口方法应可由子类型调用，定义的显式方法实现具有私有可访问性。除非基类提供了具有相应可访问性的备用方法，否则从具有显式方法实现的类派生，并选择在类中重新声明它们的类不能调入基类实现。如果重写的基类方法已被显式接口实现所隐藏，则为了调入基类实现，派生类必须将基指针强制转换为相关接口。但是，通过此引用调用基类实现时，实际调用的将是派生类实现，这会导致递归调用，并最终导致堆栈溢出。
       23. 嵌套类型不应是可见的，不要使用 public、protected 或 protected internal (Protected Friend)等嵌套类型作为类型的分组方式。使用命名空间实现此目的。嵌套类型仅在极为有限的情况下才是最佳设计。此外，不是所有的用户都能清楚地了解嵌套类型成员的可访问性。枚举数不受此规则限制。
       24. ICollection 实现含有强类型成员，实现 ICollection 的类型还应提供一种 CopyTo，其第一个参数被设置为强类型，强类型就是除对象数组或 System.Array 以外的类型。显式实现该接口成员，并使这种强类型的对象成为公共的。实现基于对象的新集合(如二叉树)时，可以忽略此规则的冲突，此时，基于集合的类型将决定什么是强类型。这些类型应公开强类型成员。
       25. 重写可比较类型中的方法，实现 IComparable 的类型应重新定义等于运算符和比较运算符，以便在整个类型中使小于、大于和等于的含义保持一致。
       26. 枚举数应强类型化，实现 IEnumerator 的类型还应提供 Current 属性的一种返回 Object 以外的类型的版本。显式实现该接口成员，并使将这种强类型版本设置为公共的。
       27. 列表已强类型化，IList 实现还应提供强类型的 IList 成员，即这些成员应为方法参数、属性参数指定非 Object 类型并返回类型。显式实现这些接口成员，并使这些强类型的对象成员成为公共的。实现基于对象的新集合(如链接列表)时，可以忽略此规则的冲突，此时，基于集合的类型将决定什么是强类型。这些类型应公开强类型成员。
       28. 避免使用空接口，接口应包含指定一组行为的成员。若要对类进行标记，请使用特性而不是空接口。
       29. 提供 ObsoleteAttribute 消息，ObsoleteAttribute.Message 属性提供在对过时的类型或成员进行编译时所显示的文本消息。此消息应提供有关过时元素的替代项的信息。
       30. 将整型或字符串参数用于索引器，索引器(索引属性)应将整型或字符串类型用于索引值。这些类型易于使用，并且常用于索引数据结构；使用其他类型会显著降低库的可用性。例如，public char this [int index] 是字符串类型的索引器的 C# 签名。
       31. 属性不应是只写的，只写属性通常表示设计有缺陷。
       32. 不要通过引用来传递类型，虽然有时允许使用引用参数，但频繁的使用这些参数则表示设计没有遵守托管代码的设计原则。
       33. 不要对引用类型重载相等运算符，包括重写 System.Object.Equals 的引用类型在内的大多数引用类型都不会重写相等运算符(==)。大多数语言提供此运算符的默认实现。
       34. 不要在密封类型中声明受保护的成员，密封类型不能扩展，而受保护的成员只有在可以扩展声明类型时才有用。因此，密封类型不应声明受保护的成员。
       35. 不要在密封类型中声明虚拟成员，不能扩展密封类型，虚拟成员只有在您可以扩展声明类型时才是有用的。
       36. 不要声明可见实例字段，在其声明类型的外部可见的实例字段会限制您更改这些数据项的实现详细信息的能力。请改用属性。属性不会降低可用性或性能，并且能够提供灵活性，因为它们隐藏了基础数据的实现详细信息。
       37. 应密封静态容器类型，静态容器类型不提供派生实例可以扩展的功能。从这种类型继承表示设计有缺陷。
       38. 静态容器类型不应具有构造函数，不需要创建只定义静态成员的类型的实例。如果没有指定构造函数，许多编译器都会自动添加公共的默认构造函数。为了避免出现这种情况，可能需要添加一个空的私有构造函数。
       39. URI 参数不应为字符串，如果某个参数的名称中包含“uri”、“url”或“urn”，并且该参数被类型化为字符串，则应将该参数的类型改为 System.Uri，除非有一个重载方法已将该参数类型化为 URI。
       40. URI 返回值不应是字符串，如果某函数的名称中包含“uri”、“url”或“urn”，并且返回类型为字符串，则应将返回类型更改为 System.Uri。
       41. URI 属性不应是字符串,如果某属性的名称包含“uri”、“url”或“urn”，并且该属性被类型化为字符串，则应将其更改为 System.Uri。
       42. 字符串 URI 重载调用 System.Uri 重载,如果一个方法通过用字符串替换 System.Uri 参数来重载另一个方法，则该字符串重载只是从该字符串生成一个 URI 对象，然后将结果传递给字符串重载。
       43. 类型不应扩展某些基类型,最好不要扩展某些基类型，即，宁愿扩展这些基类型的更佳备选项，也不扩展这些基类型。
       44. 不要隐藏基类方法,如果在派生类中定义一个方法，该方法与在基类中定义的方法同名，但参数的类型化较弱，则将妨碍对基类中定义的方法的访问。

    4. 可维护性规则

       1. 变量名不应与字段名相同,在同一个范围内，实例字段和变量名不应相同。
       2. 避免过度继承,深度嵌套的对象层次结构会增加理解和维护代码的难度
       3. 避免过度复杂,过于复杂的方法实现会增加理解和维护代码的难度
       4. 检查令人误解的字段名,检查字段名，按照惯例，字段名会指示字段是实例字段还是静态字段，但实际上并非如此。此规则会对前缀为“s”的实例字段以及前缀为“m_”的静态字段引发。
       5. 避免使用无法维护的代码,类耦合度较高、圈复杂度较高和/或程序较长的类型和方法可能很难维护。
       6. 避免过度类耦合度,类耦合度较高的类型和方法很难维护。

    5. 性能规则

       1. 避免进行不必要的强制转换，由于进行强制转换会产生相关的开销，因此请尽可能避免重复强制转换。
       2. 在合适的位置使用文本，如果在运行时不必计算值，则与使用 InitOnly 字段相比，优先使用文本。虽然字段 {0} 声明为“static readonly”，但它是用常量值“{1}”初始化的。请将此字段标记为“const”。
       3. 移除未使用的局部变量，移除方法实现中未使用过的或只赋过值的局部变量。
       4. 避免过多的局部变量，方法实现中包含的局部变量不应超过 64 个。局部变量应为 64 个或更少，以便运行时能以最高效率注册局部变量。如果局部变量数量超过 64 个，将不基于流分析注册局部变量，这可能导致性能降低。
       5. 以内联方式初始化引用类型的静态字段，声明静态字段时，应初始化这些字段。初始化显式静态构造函数中的静态数据将导致代码性能较差。
       6. 避免使用未调用的私有代码，存在对外部不可见的未调用代码，该代码不是已知的运行时入口点。如果错误地引发此冲突，请向 Visual Studio 代码分析团队发送问题报告。
       7. 避免未实例化的内部类，检测到显然从未实例化过的内部类。此规则不会尝试检测后期绑定创建，并且，如果某一类型的实例都是以这种方法(例如，通过 Activator.CreateInstance 或将类型作为参数传递给 TypeConverter 构造函数)创建的，则将产生误报。
       8. 避免使用非密封特性，密封特性类型可以提高性能。在对自定义特性进行反射期间，密封特性类型可以提高性能。
       9. 与多维数组相比，首选使用交错数组，多维数组可能对性能有负面影响。如有可能，请使用交错数组。
       10. 重写值类型上的 Equals 和相等运算符，与自定义实现相比，默认 System.ValueType 实现的性能可能要差一些。
       11. 属性不应返回数组，返回数组的属性容易降低代码的效率。请考虑使用集合或将其转换为方法。
       12. 使用字符串长度测试是否有空字符串，若要测试是否有空字符串，请检查 String.Length 是否等于零。对于如 "".Equals(someString) 和 String.Empty.Equals(someString) 之类的构造，其效率低于字符串长度测试。请使用 someString.Length == 0 检查来替换它们。
       13. 将成员标记为 static，不访问实例数据或调用实例方法的方法可标记为 Static (在 Visual Basic 中为 Shared)。这样，编译器会向这些成员发出非虚拟调用站点，以防止在运行时对每个调用进行旨在确保当前对象指针为非 null 的检查。这样可以使对性能比较敏感的代码获得显著的性能提升。在某些情况下，无法访问当前对象实例表明存在正确性问题。
       14. 避免未使用的私有字段

    6. 安全规则

       1. 不要声明只读可变引用类型，可变引用类型的只读声明不会阻止对字段的实例数据进行修改。例如，由于使用只读引用可以修改 StringBuilder 封装的数据，因此只读 StringBuilder 字段声明毫无意义。
       2. 数组字段不应为只读，引用数组的只读字段可能无法提供预期的效果。将引用数组的字段设为只读会阻止更改该字段的值。请注意，该数组中的元素可以更改。如果不考虑是否保护数组的内容，则可以忽略此冲突。
       3. 检查有关值类型的声明性安全，结构上的 Demand 或 LinkDemand 不能阻止创建该结构的实例。
       4. 检查可见的事件处理程序，某个事件处理程序似乎对外部可见或某个安全请求所修饰的可见方法中正在公开 EventArgs 参数。在事件处理程序函数中公开敏感功能可能会出现问题；安全请求可能不会按预期执行。
       5. 受保护的类型不应公开字段，必须使用安全性检查而不是 LinkDemand 来保护字段。
       6. 密封满足私有接口的方法，对外部可见且实现非公共接口的类型应是不可扩展的。如果类型扩展具有非公共接口的公共类型，则这些类型会重写接口成员。这可能危及对象行为或造成安全漏洞。
       7. 保护序列化构造函数，具有受安全请求保护的构造函数的可序列化类型，必须将相同的安全请求应用于序列化构造函数。请使用声明性安全应用该请求。
       8. 静态构造函数应为私有，非私有的静态构造函数可能导致意外的行为，尤其是在多次执行该构造函数的情况下。如果类型声明静态数据但没有显式声明静态构造函数，则可能发生此冲突。在这种情况下，某些编译器将生成外部可见的静态构造函数。
       9. 在外部 try 块中包装易受攻击的 finally 子句，还原与安全相关的状态的 finally 子句应包装在外层 try 块中。这样可以防止堆栈上方的异常筛选器在安全环境可被还原之前执行。位于受保护 try 块之后和关联的 finally 块之前、在第一遍运行代码表达式的异常筛选器表示一个可能的安全漏洞。finally 子句中的不安全功能(应防止出现)的示例包括: 对断言权限调用 RevertAssert，取消临时模拟，反转内部标志绕过安全性检查以及还原与某个线程关联的区域性。

    7. 用法规则

       1. 检查未使用的参数，检查在非虚方法的方法主体中未使用的参数，以确保不存在应该访问这些参数的情况。未使用的参数会带来维护和性能开销。有时，与该规则冲突可能说明方法中存在实现 Bug，即，该参数实际上应该已在方法主体中使用了。如果该参数由于向后兼容性而必须存在，请忽略关于此规则的警告。
       2. 不要忽略方法结果，对于返回新的字符串实例的方法，应将其结果赋予变量并随后使用。如果未将创建新对象的方法(如 String.ToLower())的结果赋给变量，则该调用便浪费了。
       3. 不要引发保留的异常类型，用户代码不应创建和引发某些类型的异常，即属于运行时保留的异常类型或太通用的异常类型。太通用的异常类型包括 Exception、SystemException 和 ApplicationException。运行时保留的异常类型包括 ThreadAbortException、OutOfMemoryException、ExecutionEngineException 和 IndexOutOfRangeException。
       4. 以内联方式初始化值类型的静态字段，不要在值类型上声明显式静态构造函数。在显式静态构造函数中初始化静态数据将导致在元数据中未标记为“beforefieldinit”的值类型。在这种情况下，不能始终保证在调用该值类型上的实例成员前，调用该静态构造函数。
       5. 非常量字段不应是可见的，除非您使用锁来小心地管理对静态字段的访问，否则这些字段应为常量。如果使用静态变量而不保证它们是线程安全的，则可能威胁到执行状态。此规则适用于托管代码库。如果分析的程序集是用户，则忽略此规则冲突通常是安全的。
       6. 不要在构造函数中调用可重写的方法，不应通过构造函数调用类中定义的虚方法。如果某个派生类已重写该虚方法，则将在调用派生类的构造函数前，调用此派生类重写后的方法。
       7. 重写 Equals 时重写 GetHashCode，重写 Equals 时，必须也重写 GetHashCode 以保证哈希表的行为正确。
       8. 在异常子句中不引发异常，在异常子句中引发异常会显著增加调试难度。在 finally 和 fault 子句中引发的异常将隐藏在相应的 try 块中引发的异常。在筛选器中引发的异常将被忽略，在处理时将被视为筛选器已经返回 false。
       9. 不要递减继承成员的可见性，使用私有实现从继承类重写公共方法是不正确的，除非类型是密封的或该方法被标记为 Final。在继承树中，中途隐藏方法签名不是正确的做法。
       10. 成员不应只是返回类型不同，对于开发人员和工具来说，相同类型中仅返回类型不同的方法是很难正确识别的。扩展类型时，请确保不要定义只有类型与基类型方法不同的新方法。
       11. 重载相等运算符时重写 Equals 方法，重定义相等运算符的类型还应重定义 Equals 以确保这些成员返回相同的结果。这有助于确保依赖于 Equals 的类型(如 ArrayList 和 Hashtable)按预期方式运行以及确保与相等运算符保持一致。
       12. 集合属性应为只读，返回集合的属性应为只读，以确保用户无法完全替换后备存储。用户通过对集合调用相关方法仍然可以修改集合的内容。请注意，XmlSerializer 类对反序列化只读集合具有专门的支持。有关详细信息，请参见 XmlSerializer 概述。
       13. 实现序列化构造函数，该构造函数签名接受与 ISerializable.GetObjectData 所用参数相同的参数(即 SerializationInfo 实例和 StreamingContext 实例)。对于非密封类，该构造函数应为 protected，对于密封类，它应为 private。未能实现序列化构造函数将导致反序列化失败，并引发 SerializationException。
       14. 对可变数量的参数使用 params，不要使用 varargs 调用约定接受可变数量的参数。在托管环境中，"params" 和 "ParamArray" 关键字提供此功能。
       15. 重写 ValueType.Equals 时应重载相等运算符，重定义 System.Object.Equals 的值类型还应重定义相等运算符以确保这些成员返回相同的结果。这有助于确保依赖于 Equals 的类型(如 ArrayList 和 Hashtable)按预期方式运行且与相等运算符保持一致。
       16. 传递 System.Uri 对象，而不传递字符串，如果有两个重载方法，一个采用 System.Uri，另一个采用 System.String，则库代码永远不会调用基于字符串的重载方法。
       17. 标记所有不可序列化的字段，所有无法直接序列化的字段都应具有 NonSerializedAttribute 特性。对于具有 SerializableAttribute 特性的类型，都不应包含没有 SerializableAttribute 特性的类型字段，除非这些字段用 NonSerializedAttribute 进行了标记。
       18. 正确实现序列化方法，标记有 OnSerializing、OnSerialized、OnDeserializing 或 OnDeserialized 的方法必须是私有的非泛型方法，返回 void (Visual Studio 中为 Sub)，并且采用类型为 StreamingContext 的单个参数。
       19. 正确测试 NaN，与“Single.NaN”或“Double.NaN”(非数字)的直接比较始终返回 true (表示不相等)，对于其他所有比较，始终返回 false；请使用“Single.IsNaN”或“Double.IsNaN”来检查浮点值是否为 NaN。

## 7. Util 框架使用规范

### 7.1 Presentation

#### 7.1.1 Api 介绍

1. 继承自QueryControllerBase

   | 接口名称                                             | 接口含义               | Http请求方式 | 调用范例                                   |
   | ---------------------------------------------------- | ---------------------- | ------------ | ------------------------------------------ |
   | GetAsync( string id )                                | 获取单个实例           | GET          | /api/customer/1                            |
   | PagerQueryAsync( TQuery query )                      | 分页查询               | GET          | /api/customer?name=a&order=createTime desc |
   | QueryAsync( TQuery query )                           | 查询                   | GET          | /api/customer/query?name=a                 |
   | GetItemsAsync( TQuery query )                        | 获取项列表(**未实现**) | GET          | /api/customer/items?name=a                 |
   | void PagerQueryBefore( TQuery query )                | 分页查询前操作         |              |                                            |
   | dynamic ToPagerQueryResult( PagerList<TDto> result ) | 转换分页查询结果       |              |                                            |
   | void QueryBefore( TQuery query )                     | 查询前操作             |              |                                            |
   | dynamic ToQueryResult( List<TDto> result )           | 转换查询结果           |              |                                            |
   | Item ToItem( TDto dto )                              | 将Dto转换为列表项      |              |                                            |

2. 继承自CurdControllerBase

   | 接口名称                                                    | 接口含义     | Http请求方式 | 调用范例             |
   | ----------------------------------------------------------- | ------------ | ------------ | -------------------- |
   | CreateAsync( [FromBody] TCreateRequest request )            | 创建         | POST         | /api/customer        |
   | UpdateAsync( string id, [FromBody] TUpdateRequest request ) | 修改         | PUT          | /api/customer/1      |
   | DeleteAsync( string id )                                    | 删除单个实体 | DELETE       | /api/customer/1      |
   | BatchDeleteAsync( [FromBody] string ids )                   | 批量删除     | POST         | /api/customer/delete |
   | SaveAsync( [FromBody] SaveModel request )                   | 批量保存     | POST         | /api/customer/save   |
   | void CreateBefore( TCreateRequest dto )                     | 创建前操作   |              |                      |
   | void UpdateBefore( TUpdateRequest dto )                     | 修改前操作   |              |                      |

3. TreeControllerBase

   | 接口名称                                                     | 接口含义                   | Http请求方式 | 调用范例               |
   | ------------------------------------------------------------ | -------------------------- | ------------ | ---------------------- |
   | GetAsync( string id )                                        | 获取单个实例               | Get          | /api/customer/1        |
   | DeleteAsync( string id )                                     | 删除单个实体               | DELETE       | /api/customer/1        |
   | BatchDeleteAsync( [FromBody] string ids )                    | 批量删除                   | POST         | /api/customer/delete   |
   | Enable( [FromBody] string ids )                              | 启用                       | POST         | /api/customer/enable   |
   | Disable( [FromBody] string ids )                             | 冻结                       | POST         | /api/customer/disable  |
   | SwapSortAsync( [FromBody] string ids )                       | 交换排序                   | POST         | /api/customer/swapSort |
   | FixAsync( [FromBody] TQuery parameter )                      | 修正排序                   | POST         | /api/customer/fix      |
   | QueryAsync( TQuery query )                                   | 查询                       | GET          | /api/role?name=a       |
   | void QueryBefore( TQuery query )                             | 查询前操作                 |              |                        |
   | void InitParam( TQuery query )                               | 初始化参数                 |              |                        |
   | Task<ZorroTreeResult> FirstLoad( TQuery query )              | 首次加载                   |              |                        |
   | Task<ZorroTreeResult> SyncFirstLoad                          | 同步首次加载               |              |                        |
   | void ProcessData( List<TDto> data, TQuery query )            | 数据处理                   |              |                        |
   | ZorroTreeResult ToResult( List<TDto> data, bool async = false ) | 转换为树形结果             |              |                        |
   | AsyncFirstLoad( TQuery query )                               | 异步首次加载               |              |                        |
   | LoadChildren( TQuery query )                                 | 加载子节点                 |              |                        |
   | AsyncLoadChildren( TQuery query )                            | 异步加载子节点             |              |                        |
   | GetAsyncLoadChildrenQuery( TQuery query )                    | 获取异步加载子节点查询参数 |              |                        |
   | SyncLoadChildren( TQuery query )                             | 同步加载子节点             |              |                        |
   | GetSyncLoadChildrenQuery( TQuery query )                     | 获取同步加载子节点查询参数 |              |                        |
   | Search( TQuery query )                                       | 搜索                       |              |                        |

4. 基类属性和方法

   | 名称                                                         | 接口含义     | 类型 |
   | ------------------------------------------------------------ | ------------ | ---- |
   | Log                                                          | 日志         | 属性 |
   | ILog GetLog()                                                | 获取日志操作 | 函数 |
   | IActionResult Success( dynamic data = null, string message = null ) | 返回成功消息 | 函数 |
   | IActionResult Fail( string message )                         | 返回失败消息 | 函数 |

#### 7.1.2 规范

 	1. 对于有增删查改业务的对象，继承自CurdControllerBase
 	2. 对于只有查询业务的对象，继承自QueryControllerBase
 	3. 对于有增删查改业务的树形结构对象，继承自TreeControllerBase
 	4. 对于继承自CurdControllerBase的Api，继承自CrudControllerBase<TDto, TCreateRequest, TUpdateRequest, TQuery>基类
 	5. 对void CreateBefore( TCreateRequest dto )可以重写，添加创建业务对象前操作逻辑
 	6. 对void UpdateBefore( TUpdateRequest dto )可以重写，添加修改业务对象前操作逻辑
 	7. 对于非预期的处理，使用Fail(message)函数进行返回，不要直接抛出异常

### 7.2 Service

#### 7.2.1 Dtos

##### 7.2.1.1 CreateRequest

1. 继承自RequestBase，否则Dto的Required、Length等自验证特性无效
2. 命名建议为CreateObjectRequest
3. 只包含用户需要输入信息的属性，不包含Id、CreationTime、CreatorId、LastModificationTime、LastModifierId、IsDeleted、Version等属性

##### 7.2.1.2 UpdateRequest

1. 继承自RequestBase，否则Dto的Required、Length等自验证特性无效
2. 命名建议为UpdateObjectRequest
3. 只包含用户需要输入信息的属性，不包含CreationTime、CreatorId、LastModificationTime、LastModifierId等属性,包含Id，Version、IsDeleted属性

##### 7.2.1.3 Dto

1. 继承自DtoBase，否则Dto的Required、Length等自验证特性无效
2. 命名建议为ObjectDto
3. 只包含用户需要输入信息的属性，不包含CreationTime、CreatorId、LastModificationTime、LastModifierId、IsDeleted等属性,包含Id，Version属性

##### 7.2.1.4 其他

1. 扩展属性要和数据实体名称保持一致

2. 扩展实体属性前**必须**用```virtual```描述，具有外键恭喜得，必须用[ForeignKey( "RoleId" )]标识

3. 非扩展实体属性注释需要备注扩展自实体表的具体实体字段

4. 可空属性,慎用可空属性，Dto中可空属性意味着前端可以不提供数据

5. Dto属性范围，调用方需要什么属性，就输出什么属性，不需要的属性尽量减少输出。

   ```C#
   public class User: AggregateRoot<User>
   {
       /// <summary>
       /// 用户编码
       /// </summary>
       [DisplayName( "用户编码" )]
       [Required( ErrorMessage = "用户编码不能为空" )]
       [StringLength( 60, ErrorMessage = "用户编码输入过长，不能超过60位" )]
       public string Code { get; set; }
       
       /// <summary>
       /// 用户名称
       /// </summary>
       [DisplayName( "用户名称" )]
       [Required( ErrorMessage = "用户名称不能为空" )]
       [StringLength( 200, ErrorMessage = "用户名称输入过长，不能超过200位" )]
       public string Name { get; set; }
   
       /// <summary>
       /// 角色标识
       /// </summary>
       [DisplayName( "角色标识" )]
       [Required( ErrorMessage = "角色标识不能为空" )]
       public string RoleId { get; set; }
       
       /// <summary>
       /// 角色
       /// </summary>
       [DisplayName( "角色" )]
       [ForeignKey( "RoleId" )]
       public virtual Role Role { get; set; }
       
       /// <summary>
       /// 用户类型
       /// </summary>
       [DisplayName( "用户类型" )]
       public int UserType { get; set; }
       
       /// <summary>
       /// 生日
       /// </summary>
       [DisplayName( "生日" )]
       public DateTime? Birth { get; set; }
       
       /// <summary>
       /// 启用
       /// </summary>
       [DisplayName( "启用" )]
       [Required( ErrorMessage = "启用不能为空" )]
       public bool Enabled { get; set; }
   }
   
   public class UserDto: DtoBase
   {
       /// <summary>
       /// 用户编码
       /// </summary>
       [Display( Name = "用户编码" )]
       [Required( ErrorMessage = "用户编码不能为空" )]
       [StringLength( 60, ErrorMessage = "用户编码输入过长，不能超过60位" )]
       public string Code { get; set; }
       
       /// <summary>
       /// 用户名称
       /// </summary>
       [Display( Name = "用户名称" )]
       [Required( ErrorMessage = "用户名称不能为空" )]
       [StringLength( 200, ErrorMessage = "用户名称输入过长，不能超过200位" )]
       public string Name { get; set; }
   
       /// <summary>
       /// 角色标识
       /// </summary>
       [Display( Name = "角色标识" )]
       [Required( ErrorMessage = "角色标识不能为空" )]
       public string RoleId { get; set; }
       
       /// <summary>
       /// 角色
       /// </summary>
       [Display( Name = "角色" )]
       public virtual Role Role { get; set; }
       
       /// <summary>
       /// 角色编码 
       /// 扩展自角色（Role）实体 RoleCode 属性
       /// </summary>
       [Display( Name = "角色编码" )]
       public string RoleCode { get; set; }
       
       /// <summary>
       /// 联系方式
       /// </summary>
       [DisplayName( "联系方式" )]
       public string[] Phones { get; set; }
       
       /// <summary>
       /// 启用
       /// </summary>
       [DisplayName( "启用" )]
       [Required( ErrorMessage = "启用不能为空" )]
       public bool Enabled { get; set; }
   }
   
   
   public class CreateUserRequest: RequestBase
   {
       /// <summary>
       /// 用户编码
       /// </summary>
       [Display( Name = "用户编码" )]
       [Required( ErrorMessage = "用户编码不能为空" )]
       [StringLength( 60, ErrorMessage = "用户编码输入过长，不能超过60位" )]
       public string Code { get; set; }
       
       /// <summary>
       /// 用户名称
       /// </summary>
       [Display( Name = "用户名称" )]
       [Required( ErrorMessage = "用户名称不能为空" )]
       [StringLength( 200, ErrorMessage = "用户名称输入过长，不能超过200位" )]
       public string Name { get; set; }
   
       /// <summary>
       /// 角色标识
       /// </summary>
       [Display( Name = "角色标识" )]
       [Required( ErrorMessage = "角色标识不能为空" )]
       public string RoleId { get; set; }
       
       /// <summary>
       /// 用户类型
       /// </summary>
       [DisplayName( "用户类型" )]
       public int UserType { get; set; }
       
       /// <summary>
       /// 生日
       /// </summary>
       [DisplayName( "生日" )]
       public DateTime? Birth { get; set; }
       
       /// <summary>
       /// 联系方式
       /// </summary>
       [DisplayName( "联系方式" )]
       public string[] Phones { get; set; }
   }
   ```

#### 7.2.2 Queries

##### 7.2.2.1 QueryParameter

1. 查询对象继承自QueryParameter

2. 对于字符串属性要在属性中去除左右空格,敏感字过滤[暂不考虑]

3. 对于int、bool等非必须过滤属性必须定义为可空类型

4. 对于允许多状态检索属性必须定义为数组类型

5. 不可对标识进行检索，要获取单条数据，请调用其对应接口

   ```c#
   /// <summary>
   /// 用户查询实体
   /// </summary>
   public class UserQuery : QueryParameter 
   {
       private string _code = string.Empty;
       /// <summary>
       /// 编码
       /// </summary>
       [Display( Name = "用户编码" )]
       public string Code 
       {
           get => _code == null ? string.Empty : _code.Trim();
           set => _code = value;
       }
       
       private string _name = string.Empty;
       /// <summary>
       /// 用户名称
       /// </summary>
       [Display( Name = "用户名称" )]
       public string Name 
       {
           get => _name == null ? string.Empty : _name.Trim();
           set => _name = value;
       }
       
       /// <summary>
       /// 启用
       /// </summary>
       [Display( Name = "启用" )]
       public bool? Enabled { get; set; }
       
       /// <summary>
       /// 起始创建时间
       /// </summary>
       [Display( Name = "起始创建时间" )]
       public DateTime? BeginCreationTime { get; set; }
       
       /// <summary>
       /// 结束创建时间
       /// </summary>
       [Display( Name = "结束创建时间" )]
       public DateTime? EndCreationTime { get; set; }
       
       /// <summary>
       /// 创建人编号
       /// </summary>
       [Display( Name = "创建人编号" )]
       public Guid? CreatorId { get; set; }
       
       /// <summary>
       /// 用户类型
       /// </summary>
       [DisplayName( "用户类型" )]
       public int[] UserType { get; set; }
   }
   ```
   
   

#### 7.2.3 Implements

##### 7.2.3.1 Api 介绍

1. ServiceBase : IService

   | 类型 | 名称                                                   | 含义             |
   | ---- | ------------------------------------------------------ | ---------------- |
   | 属性 |                                                        |                  |
   |      | ILog Log => _log ??= GetLog();                         | 当前注入日志实例 |
   | 方法 |                                                        |                  |
   |      | virtual ILog GetLog()                                  | 获取日志操作     |
   |      | virtual ISession Session => Sessions.Session.Instance; | 获取用户会话     |

2. QueryServiceBase : ServiceBase, IQueryService

   | 类型 | 名称                                         | 含义               |
   | ---- | -------------------------------------------- | ------------------ |
   | 属性 |                                              |                    |
   |      | virtual bool IsTracking => false;            | 查询时是否跟踪对象 |
   | 方法 |                                              |                    |
   |      | virtual TDto ToDto( TEntity entity )         | 转换为数据传输对象 |
   |      | virtual async Task<List<TDto>> GetAllAsync() | 获取全部           |
   |      | virtual async Task<TDto> GetByIdAsync( object id ) |通过编号获取|
   |      | virtual async Task<List<TDto>> GetByIdsAsync( string ids ) |通过编号列表获取|
   |      | async Task<List<TDto>> QueryAsync( TQueryParameter parameter ) |查询|
   |      | IQueryable<TEntity> ExecuteQuery( TQueryParameter parameter ) |执行查询|
   |      | virtual IQueryBase<TEntity> CreateQuery( TQueryParameter parameter ) |创建查询对象|
   |      | IQueryable<TEntity> Filter( IQueryBase<TEntity> query ) |过滤|
   |      | virtual IQueryable<TEntity> Filter( IQueryable<TEntity> queryable, TQueryParameter parameter ) |过滤|
   |      | virtual async Task<PagerList<TDto>> PagerQueryAsync( TQueryParameter parameter ) |分页查询|
   
3. CrudServiceBase : DeleteServiceBase, ICrudService

   | 类型 | 名称                                                         | 含义       |
   | ---- | ------------------------------------------------------------ | ---------- |
   | 属性 |                                                              |            |
   |      |                                                              |            |
   | 方法 |                                                              |            |
   |      | virtual async Task<string> CreateAsync( TCreateRequest request ) | 创建       |
   |      | async Task CreateAsync( TEntity entity )                     | 创建实体   |
   |      | virtual Task CreateBeforeAsync( TEntity entity )             | 创建前操作 |
   |      | virtual Task CreateAfterAsync( TEntity entity )              | 创建后操作 |
   |      | virtual async Task<TEntity> FindOldEntityAsync( TKey id )    | 查找旧实体 |
   |      | virtual async Task UpdateAsync( TUpdateRequest request ) | 修改 |
   |      | async Task UpdateAsync( TEntity entity ) | 修改实体 |
   |      | virtual Task UpdateBeforeAsync( TEntity entity ) | 修改前操作 |
   |      | virtual Task UpdateAfterAsync( TEntity entity, ChangeValueCollection changeValues ) | 修改后操作 |
   |      | virtual async Task SaveAsync( TRequest request ) | 保存 |
   |      | virtual bool IsNew( TRequest request, TEntity entity ) | 是否创建 |
   |      | void CommitAfter() | 提交后操作 |
   |      | virtual async Task<List<TDto>> SaveAsync( List<TDto> creationList, List<TDto> updateList,List<TDto> deleteList ) | 批量保存 |
   |      | virtual void SaveBefore( List<TEntity> creationList, List<TEntity> updateList, List<TEntity> deleteList ) | 保存前操作 |
   |      | virtual async Task DeleteChildsAsync( TEntity parent ) | 删除子节点集合 |
   |      | async Task DeleteEntityAsync( TEntity entity ) | 删除实体 |
   |      | virtual void SaveAfter( List<TEntity> creationList, List<TEntity> updateList, List<TEntity> deleteList ) | 保存后操作 |
   |      | virtual List<TDto> GetResult( List<TEntity> creationList, List<TEntity> updateList ) | 获取结果 |
   |      | virtual TEntity ToEntity( TRequest request ) | 转换为实体 |
   |      | virtual TEntity ToEntityFromCreateRequest( TCreateRequest request ) | 创建参数转换为实体 |
   |      | virtual TEntity ToEntityFromUpdateRequest( TUpdateRequest request ) | 修改参数转换为实体 |
   |      | virtual TEntity ToEntityFromDto( TDto request ) | 参数转换为实体 |
   
4. DeleteServiceBase : QueryServiceBase, IDeleteService

   | 类型 | 名称                              | 含义     |
   | ---- | --------------------------------- | -------- |
   | 属性 |                                   |          |
   |      | string EntityDescription { get; } | 实体描述 |
   | 方法 |                                   |          |
   |      | virtual void DeleteBefore( List<TEntity> entities ) | 删除前操作 |
   |      | virtual void DeleteAfter( List<TEntity> entities ) | 删除后操作 |
   |      | virtual async Task DeleteAsync( string ids ) | 删除 |

##### 7.2.3.2 规范

1. 通用规范
   + 函数尽可能定义成异步的
   + 函数命名格式为[C[reate]、U[pdate]、R(Q)[etrieve]、D[elete]Object][s][Async]
2. Create
   + 对字段验证，请重载 ```virtual Task CreateBeforeAsync( TEntity entity )```
   + 创建 virtual async Task<string> CreateAsync( TCreateRequest request )
   + 创建 async Task CreateAsync( TEntity entity )
   + 保存 virtual async Task SaveAsync( TRequest request )
3. Delete
   + 删除，async Task DeleteEntityAsync( TEntity entity )
   + 删除子节点集合，virtual async Task DeleteChildsAsync( TEntity parent )
4. Query
   + 获取全部 virtual async Task<List<TDto>> GetAllAsync()      
   + 通过编号获取 virtual async Task<TDto> GetByIdAsync( object id )  
   + 通过编号列表获取 virtual async Task<List<TDto>> GetByIdsAsync( string ids )     
   + 查询 async Task<List<TDto>> QueryAsync( TQueryParameter parameter )     
   + 执行查询 IQueryable<TEntity> ExecuteQuery( TQueryParameter parameter )     
   + 创建查询对象 virtual IQueryBase<TEntity> CreateQuery( TQueryParameter parameter )     
   + 过滤 IQueryable<TEntity> Filter( IQueryBase<TEntity> query )     
   + 过滤 virtual IQueryable<TEntity> Filter( IQueryable<TEntity> queryable, TQueryParameter parameter )     
   + 分页查询 virtual async Task<PagerList<TDto>> PagerQueryAsync( TQueryParameter parameter )  
5. Update
   + 对字段验证，请重载 ```virtual Task UpdateBeforeAsync( TEntity entity )```
   + 创建 virtual async Task<string> UpdateAsync( TUpdateRequest request )
   + 创建 async Task UpdateAsync( TEntity entity )
   + 保存 virtual async Task SaveAsync( TRequest request )
6. 批量操作
   + 对字段验证，请重载 ```virtual void SaveBefore( List<TEntity> creationList, List<TEntity> updateList, List<TEntity> deleteList )```
   + 批量保存，请重载 virtual async Task<List<TDto>> SaveAsync( List<TDto> creationList, List<TDto> updateList,List<TDto> deleteList )
7. 实体转换
   + 转换为数据传输对象 virtual TDto ToDto( TEntity entity )  
   + 转换为实体 virtual TEntity ToEntity( TRequest request )      
   + 创建参数转换为实体 virtual TEntity ToEntityFromCreateRequest( TCreateRequest request )     
   + 修改参数转换为实体 virtual TEntity ToEntityFromUpdateRequest( TUpdateRequest request )     
   + 参数转换为实体 virtual TEntity ToEntityFromDto( TDto request )  

#### 7.2.4 Repository

##### 7.2.4.1 QueryStoreBase

> QueryStoreBase : IQueryStore

| 类型 | 名称                                              | 含义               |
| ---- | ------------------------------------------------- | ------------------ |
| 属性 |                                                   |                    |
|      |                                                              |                     |
| 方法 |                                                   |                    |
|      | virtual Util.Datas.Sql.ISqlQuery CreateSqlQuery() | 创建Sql查询对象    |
|      | IQueryable<TEntity> FindAsNoTracking()            | 获取未跟踪查询对象 |
|      | IQueryable<TEntity> Find()                        | 获取查询对象       |
|      | IQueryable<TEntity> Find( ICriteria<TEntity> criteria ) | 查询 |
|      | IQueryable<TEntity> Find( Expression<Func<TEntity, bool>> predicate ) | 查询 |
|      | virtual TEntity Find( object id ) | 查找实体 |
|      | virtual async Task<TEntity> FindAsync( object id ) | 查找实体 |
|      | virtual List<TEntity> FindByIds( params TKey[] ids ) | 查找实体列表 |
|      | virtual List<TEntity> FindByIds( IEnumerable<TKey> ids ) | 查找实体列表 |
|      | virtual List<TEntity> FindByIds( string ids ) | 查找实体列表 |
|      | virtual async Task<List<TEntity>> FindByIdsAsync( params TKey[] ids ) | 查找实体列表 |
|      | virtual async Task<List<TEntity>> FindByIdsAsync( IEnumerable<TKey> ids ) | 查找实体列表 |
|      | virtual async Task<List<TEntity>> FindByIdsAsync( string ids ) | 查找实体列表 |
|      | virtual TEntity FindByIdNoTracking( TKey id ) | 查找未跟踪单个实体 |
|      | virtual async Task<TEntity> FindByIdNoTrackingAsync( TKey id ) | 查找未跟踪单个实体 |
|      | virtual List<TEntity> FindByIdsNoTracking( params TKey[] ids ) | 查找实体列表,不跟踪 |
|      | virtual List<TEntity> FindByIdsNoTracking( IEnumerable<TKey> ids ) | 查找实体列表,不跟踪 |
|      | virtual List<TEntity> FindByIdsNoTracking( string ids ) | 查找实体列表,不跟踪 |
|      | virtual async Task<List<TEntity>> FindByIdsNoTrackingAsync( params TKey[] ids ) | 查找实体列表,不跟踪 |
|      | virtual async Task<List<TEntity>> FindByIdsNoTrackingAsync( IEnumerable<TKey> ids) | 查找实体列表,不跟踪 |
|      | virtual async Task<List<TEntity>> FindByIdsNoTrackingAsync( string ids ) | 查找实体列表,不跟踪 |
|      | virtual TEntity Single( Expression<Func<TEntity, bool>> predicate ) | 查找单个实体 |
|      | virtual async Task<TEntity> SingleAsync( Expression<Func<TEntity, bool>> predicate) | 查找单个实体 |
|      | virtual List<TEntity> FindAll( Expression<Func<TEntity, bool>> predicate = null ) | 查找实体列表 |
|      | virtual List<TEntity> FindAllNoTracking( Expression<Func<TEntity, bool>> predicate = null ) | 查找实体列表,不跟踪 |
|      | virtual async Task<List<TEntity>> FindAllAsync( Expression<Func<TEntity, bool>> predicate = null ) | 查找实体列表 |
|      | virtual async Task<List<TEntity>> FindAllNoTrackingAsync( Expression<Func<TEntity, bool>> predicate = null ) | 查找实体列表,不跟踪 |
|      | virtual bool Exists( Expression<Func<TEntity, bool>> predicate ) | 判断是否存在 |
|      | virtual bool Exists( params TKey[] ids ) | 判断是否存在 |
|      | virtual async Task<bool> ExistsAsync( Expression<Func<TEntity, bool>> predicate ) | 判断是否存在 |
|      | virtual async Task<bool> ExistsAsync( params TKey[] ids ) | 判断是否存在 |
|      | virtual int Count( Expression<Func<TEntity, bool>> predicate = null ) | 查找数量 |
|      | virtual async Task<int> CountAsync( Expression<Func<TEntity, bool>> predicate = null ) | 查找数量 |
|      | virtual List<TEntity> Query( IQueryBase<TEntity> query ) | 查询 |
|      | IQueryable<TEntity> Query( IQueryable<TEntity> queryable, IQueryBase<TEntity> query ) | 获取查询结果 |
|      | virtual async Task<List<TEntity>> QueryAsync( IQueryBase<TEntity> query ) | 查询 |
|      | virtual List<TEntity> QueryAsNoTracking( IQueryBase<TEntity> query ) | 查询，不跟踪实体 |
|      | virtual async Task<List<TEntity>> QueryAsNoTrackingAsync( IQueryBase<TEntity> query ) | 查询，不跟踪实体 |
|      | virtual PagerList<TEntity> PagerQuery( IQueryBase<TEntity> query ) | 分页查询 |
|      | virtual async Task<PagerList<TEntity>> PagerQueryAsync( IQueryBase<TEntity> query ) | 分页查询 |
|      | virtual PagerList<TEntity> PagerQueryAsNoTracking( IQueryBase<TEntity> query ) | 分页查询 |
|      | virtual async Task<PagerList<TEntity>> PagerQueryAsNoTrackingAsync( IQueryBase<TEntity> query ) | 分页查询 |


##### 7.2.4.2 StoreBase

> StoreBase : QueryStoreBase, IStore

| 类型 | 名称                                                | 含义       |
| ---- | --------------------------------------------------- | ---------- |
| 属性 |                                                     |           |
|      |      |      |
| 方法 |      |      |
|      | virtual void Add( TEntity entity ) | 添加实体 |
|      | virtual void Add( IEnumerable<TEntity> entities ) | 添加实体集合 |
|      | virtual async Task AddAsync( TEntity entity ) | 添加实体 |
|      | virtual async Task AddAsync( IEnumerable<TEntity> entities ) | 添加实体集合 |
|      | virtual void Update( TEntity entity ) | 修改实体 |
|      | virtual Task UpdateAsync( TEntity entity ) | 修改实体 |
|      | virtual void Update( IEnumerable<TEntity> entities ) | 修改实体集合 |
|      | virtual async Task UpdateAsync( IEnumerable<TEntity> entities ) | 修改实体集合 |
|      | virtual void Remove( object id ) | 移除实体 |
|      | virtual async Task RemoveAsync( object id ) | 移除实体 |
|      | virtual void Remove( TEntity entity ) | 移除实体 |
|      | virtual async Task RemoveAsync( TEntity entity ) | 移除实体 |
|      | virtual void Remove( IEnumerable<TKey> ids ) | 移除实体集合 |
|      | virtual async Task RemoveAsync( IEnumerable<TKey> ids ) | 移除实体集合 |
|      | virtual void Remove( IEnumerable<TEntity> entities ) | 移除实体集合 |
|      | virtual async Task RemoveAsync( IEnumerable<TEntity> entities ) | 移除实体集合 |

#### 7.2.5 SqlQuery
| 类型 | 名称                                                         | 含义             |
| ---- | ------------------------------------------------------------ | ---------------- |
| 属性 |                                                              |                  |
|      |                                                              |                  |
| 方法 |                                                              |                  |
|      | Expression<Func<TEntity, bool>> GetPredicate()               | 获取查询条件     |
|      | string GetOrder()                                            | 获取排序条件     |
|      | IPager GetPager()                                            | 获取分页         |
|      | IQuery<TEntity, TKey> Where( ICriteria<TEntity> criteria )   | 添加查询条件     |
|      | IQuery<TEntity, TKey> Where( Expression<Func<TEntity, bool>> predicate ) | 添加查询条件     |
|      | IQuery<TEntity, TKey> WhereIf( Expression<Func<TEntity, bool>> predicate, bool condition ) | 添加查询条件     |
|      | IQuery<TEntity, TKey> WhereIfNotEmpty( Expression<Func<TEntity, bool>> predicate ) | 添加查询条件     |
|      | IQuery<TEntity, TKey> Between<TProperty>( Expression<Func<TEntity, TProperty>> propertyExpression, int? min, int? max, Boundary boundary = Boundary.Both ) | 添加范围查询条件 |
|      | IQuery<TEntity, TKey> Between<TProperty>( Expression<Func<TEntity, TProperty>> propertyExpression, double? min, double? max, Boundary boundary = Boundary.Both ) | 添加范围查询条件 |
|      | IQuery<TEntity, TKey> Between<TProperty>( Expression<Func<TEntity, TProperty>> propertyExpression, decimal? min, decimal? max, Boundary boundary = Boundary.Both ) | 添加范围查询条件 |
|      | IQuery<TEntity, TKey> Between<TProperty>( Expression<Func<TEntity, TProperty>> propertyExpression, DateTime? min, DateTime? max, bool includeTime = true, Boundary? boundary = null ) | 添加范围查询条件 |
|      | IQuery<TEntity, TKey> OrderBy<TProperty>( Expression<Func<TEntity, TProperty>> expression, bool desc = false ) | 添加排序         |
|      | IQuery<TEntity, TKey> OrderBy( string propertyName, bool desc = false ) | 添加排序         |
|      | IQuery<TEntity, TKey> And( Expression<Func<TEntity, bool>> predicate ) | 与连接           |
|      | IQuery<TEntity, TKey> And( IQuery<TEntity, TKey> query )     | 与连接           |
|      | IQuery<TEntity, TKey> Or( params Expression<Func<TEntity, bool>>[] predicates ) | 或连接           |
|      | IQuery<TEntity, TKey> Or( IQuery<TEntity, TKey> query )      | 或连接           |


### 7.3 Domain

#### 7.3.1 Models

1. 领域对象数据结构必须要和表结构一致，包括属性的类型和命名

### 7.4 Data

#### 7.4.1 Mappings

 1. 对于表和数据实体之间的映射

    ```c#
    protected override void MapTable( EntityTypeBuilder<Role> builder ) 
    {
    	builder.ToTable( "sys_Role", "dbo" );
        builder.ToTable( "sys_Role");
    }
    ```

 2. 对于数据实体属性和表字段之间的映射

    ```c#
    protected override void MapProperties( EntityTypeBuilder<Role> builder ) 
    {
    	builder.Property( t => t.Id ).HasColumnName( "role_id" );
       	builder.Property( t => t.RoleName ).HasColumnName( "role_name" );
       	builder.Property( t => t.RoleCode ).HasColumnName( "role_code" );
    	builder.Property( t => t.Path ).HasColumnName( "path" );
    	builder.Property( t => t.Level ).HasColumnName( "level" );
    	builder.Property( t => t.IsAdmin ).HasColumnName( "is_admin" );
    	builder.HasQueryFilter( t => t.IsDeleted == false );
    }
    ```

 3. 对于自增长主键数据实体属性和表字段之间的映射

    ```c#
    protected override void MapProperties( EntityTypeBuilder<Role> builder ) 
    {
    	builder.Property( t => t.Id )
            .HasColumnName( "role_id" )
            .HasAnnotation("MySql:ValueGenerationStrategy",
                           Microsoft.EntityFrameworkCore.Metadata.MySqlValueGenerationStrategy.IdentityColumn);
       	builder.Property( t => t.RoleName ).HasColumnName( "role_name" );
       	builder.Property( t => t.RoleCode ).HasColumnName( "role_code" );
    	builder.Property( t => t.Path ).HasColumnName( "path" );
    	builder.Property( t => t.Level ).HasColumnName( "level" );
    	builder.Property( t => t.IsAdmin ).HasColumnName( "is_admin" );
    	builder.HasQueryFilter( t => t.IsDeleted == false );
    }
    ```

    