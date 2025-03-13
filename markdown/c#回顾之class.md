[TOC]

# C# 回顾之 类

## 1.类声明

> + 开头是一组可选 attributes
> + 依次是一组可选 class-modifiers
> + 可选 partial 修饰符、关键字 class 和用于命名类的 identifier、可选 type-parameter-list
> + 可选 class-base
> + 一组可选  type-parameter-constraints-clauses
> + class-body

```
[attribute] [class-modifiers] [partial] class Identifier[<type-parameter-list>] [class-base] [type-parameter-constraints-clauses] class-body [;]
```



### 1.1 修饰符[class-modifier]

> + new、public、protected、internal、private、abstract、sealed、static
> + 同一修饰符在一个类声明中多次出现是编译时错误。
> +	new 修饰符适用于嵌套类。它指定类隐藏同名的继承成员。如果在不是嵌套类声明的类声明中使用 new 修饰符，则会导致编译时错误。
> +	public、protected、internal 和 private 修饰符将控制类的可访问性。
> +	abstract、sealed 和 static



#### 1.1.1 抽象类[abstract]
> + 抽象类不能直接实例化，并且对抽象类使用 new 运算符会导致编译时错误。虽然一些变量和值在编译时的类型可以是抽象的，但是这样的变量和值必须或者为 null，或者含有对非抽象类的实例的引用（此非抽象类是从抽象类型派生的）
> + 允许（但不要求）抽象类包含抽象成员。
> + 抽象类不能被密封
> + 当从抽象类派生非抽象类时，这些非抽象类必须具体实现所继承的所有抽象成员，从而重写那些抽象成员。


#### 1.1.2 密封类[sealed]

>+ sealed 修饰符用于防止从所修饰的类派生出其他类。如果一个密封类被指定为其他类的基类，则会发生编译时错误。
>+ 密封类不能同时为抽象类。
>+ sealed 修饰符主要用于防止非有意的派生，但是它还能促使某些运行时优化。具体而言，由于密封类永远不会有任何派生类，所以对密封类的实例的虚函数成员的调用可以转换为非虚调用来处理。



#### 1.1.3 静态类[static]

>+ 静态类不能实例化，不能用作类型，而且仅可以包含静态成员。
>+ 只有静态类才能包含扩展方法的声明
>+ 静态类不能包含 sealed 或 abstract 修饰符。(因为无法实例化静态类或从静态类派生，所以静态类的行为就好像既是密封的又是抽象的。)
>+ 静态类不能包含 class-base 规范,不能显式指定基类或所实现接口的列表。静态类隐式从 object 类型继承。
>+ 静态类只能包含静态成员，常量和嵌套类型归为静态成员。
>+ 静态类不能含有声明的可访问性为 protected 或 protected internal 的成员。
>+ 静态类没有实例构造函数。静态类中不能声明实例构造函数，并且对于静态类也不提供任何默认实例构造函数
>+ 静态类的成员并不会自动成为静态的，成员声明中必须显式包含一个 static 修饰符（常量和嵌套类型除外）。
>+ 当一个类嵌套在一个静态的外层类中时，除非该类显式包含 static 修饰符，否则该嵌套类不是静态类。
>+ **！！将静态类用作基类、成员的构成类型、泛型类型实参或类型形参约束、用于数组类型、指针类型、new 表达式、强制转换表达式、is 表达式、as 表达式、sizeof 表达式或默认值表达式！！错误**



### 1.2 分部修饰符[partial]

> 程序文本的各独立段是在不同的上下文中产生或维护



### 1.3 形参[type-parameter-list]

> 类型形参是一个简单标识符，代表一个为创建构造类型而提供的类型实参的占位符。类型形参是将来提供的类型的形式占位符。
>
> 类型实参是在创建构造类型时替换类型形参的实际类型。

```
type-parameter-list:
	<   type-parameters   >
	
type-parameters:
	attributesopt   type-parameter
	type-parameters   ,   attributesopt   type-parameter
	
type-parameter:
	identifier

```



### 1.4 基本规范[class-base]

> + 定义该类的直接基类和由该类直接实现的接口
> + 类声明中指定的基类可以是构造类类型
> + 基类本身不能是类型形参，但在其作用域中可以包含类型形参。
> + **!!类类型的直接基类不能为下列任一类型：System.Array、System.Delegate、System.MulticastDelegate、System.Enum 或 System.ValueType。!!**
> + **!!泛型类声明不能将 System.Attribute 用作直接或间接基类。!!**

```
class-base:
    :   class-type
    :   interface-type-list
    :   class-type   ,   interface-type-list
    
interface-type-list:
    interface-type
    interface-type-list   ,   interface-type

```



### 1.5 形参约束[type-parameter-constraints-clauses]

>+ 每个 type-parameter-constraints-clause 都包括标记 where，后面跟着类型形参的名称，再后面则跟着一个冒号和该类型形参的约束列表。
>+ 每个类型形参最多只能有一个 where 子句，并且 where 子句可以按任何顺序列出。
>+ where 子句中给出的约束列表可以包括以下任一组件，依次为：一个主要约束、一个或多个次要约束  以及构造函数约束 new()。
>+ 主要约束可以是类类型、引用类型约束 (reference type constraint) class，也可以是值类型约束
>  (value type constraint) struct。次要约束可以是 type-parameter，也可以是 interface-type。
>+ 引用类型约束指定用于类型形参的类型实参必须是引用类型。所有类类型、接口类型、委托类型、数组类型和已知将是引用类型（将在下面定义）的类型形参都满足此约束。
>+ 值类型约束指定用于类型形参的类型实参必须是不可以为 null 值的类型。所有不可以为 null 的结构类型、枚举类型和具有值类型约束的类型形参都满足此约束。具有值类型约束的类型形参还不能具有 constructor-constraint。
>+ 指针类型从不允许作为类型实参，并且不被视为满足引用类型或值类型约束。
>+ 如果约束是类类型、接口类型或类型形参，则该类型指定用于该类型形参的每个类型实参必须支持的最低“基类型”。
>
>

```
type-parameter-constraints-clauses:
    type-parameter-constraints-clause
    type-parameter-constraints-clauses   type-parameter-constraints-clause
    
type-parameter-constraints-clause:
	where   type-parameter   :   type-parameter-constraints
	
type-parameter-constraints:
    primary-constraint
    secondary-constraints
    constructor-constraint
    primary-constraint   ,   secondary-constraints
    primary-constraint   ,   constructor-constraint
    secondary-constraints   ,   constructor-constraint
    primary-constraint   ,   secondary-constraints   ,   constructor-constraint
    
primary-constraint:
    class-type
    class
    struct
    
secondary-constraints:
	interface-type
	type-parameter
    secondary-constraints   ,   interface-type
    secondary-constraints   ,   type-parameter
    
constructor-constraint:
	new   (   )

```

+ class-type 约束必须满足下列规则：

  >- 该类型必须是类类型。
  >- 该类型一定不能是 sealed。
  >- 该类型不能是以下类型之一：System.Array、System.Delegate、System.Enum 或 System.ValueType。
  >- 该类型一定不能是 object。由于所有类型都派生自 object，允许这样的约束没有任何作用。
  >- 给定的类型形参至多只能有一个约束可以是类类型。

+ 指定为 interface-type 约束的类型必须满足下列规则：

  >- 该类型必须是接口类型。
  >- 不能在给定的 where 子句中多次指定某个类型。

+ 指定为 type-parameter 约束的类型必须满足下列规则：

  > - 该类型必须是类型形参。
  > - 不能在给定的 where 子句中多次指定某个类型。

+ 相互依赖的类型形参之间的任何约束都必须一致。如果类型形参 S 依赖类型形参 T，则：

  > - 如果类型形参 T 用作类型形参 S 的约束，则S 依赖 (depend on) T。
  > - 如果类型形参 S 依赖类型形参 T，并且 T 依赖类型形参 U，则 S 依赖 U。

+ 如果类型形参的 where 子句包括构造函数约束（具有 new() 形式），则可以使用 new 运算符创建该类型的实例

  > - T 一定不能具有值类型约束。否则，T 被有效地密封，使得 S 将被强制为与 T 相同的类型，从而消除了使用这两个类型形参的需要。
  > - 如果 S 具有值类型约束，则 T 不能具有 class-type 约束。
  > -  如果 S 具有 class-type 约束 A，T 具有 class-type 约束 B，则必须存在从 A 到 B 的标识转换或隐式引用转换或者从 B 到 A 的隐式引用转换。
  > -  如果 S 还依赖类型形参 U，并且 U 具有 class-type 约束 A，T 具有 class-type 约束 B，则必须存在从 A 到 B 的标识转换或隐式引用转换或者从 B 到 A 的隐式引用转换

+ 如果类型形参的 where 子句包括构造函数约束（具有 new() 形式），则可以使用 new 运算符创建该类型的实例
+ 用于具有构造函数约束的类型形参的任何类型实参都必须具有公共的无形参构造函数（任何值类型都隐式地存在此构造函数），或者是具有值类型约束或构造函数约束的类型形参

### 1.6 类体[class-body]



## 2.分部类型

### 2.1 特性
> + 分部类型的特性是通过组合每个部分的特性（不指定顺序）来确定的。如果对多个部分放置同一个特性，则相当于多次对该类型指定此特性。
> + 类型形参的特性以类似的方式进行组合。

### 2.2 修饰符

> + 当分部类型声明指定了可访问性（public、protected、internal 和 private 修饰符）时，它必须与所有其他指定了可访问性的部分一致。
> + 如果某个类的一个或多个分部声明包含 abstract 修饰符，则该类被视为抽象类
> + 如果某个类的一个或多个分部声明包含 sealed 修饰符，则该类被视为密封类
> + 当 unsafe 修饰符用于某个分部类型声明时，只有该特定部分才被视为不安全的上下文

### 2.3 类型形参和约束

> + 如果在多个部分中声明泛型类型，则每个部分都必须声明类型形参。每个部分都必须有相同数目的类型形参，并且每个类型形参按照顺序有相同的名称。
> + 当分部泛型类型声明包含约束（where 子句）时，该约束必须与包含约束的所有其他部分一致。具体而言，包含约束的每个部分都必须有针对相同的类型形参集的约束，并且对于每个类型形参，主要、次要和构造函数约束集都必须等效。
> + 如果两个约束集包含相同的成员，则它们等效。如果某个分部泛型类型的任何部分都未指定类型形参约束，则该类型形参被视为无约束。

### 2.4 基类

> 当一个分部类声明包含基类说明时，它必须与包含基类说明的所有其他部分一致。

### 2.5 基接口

> + 在多个部分中声明的类型的基接口集是每个部分中指定的基接口的并集。
>
> + 一个特定基接口在每个部分中只能指定一次，但是允许多个部分指定相同的基接口。任何给定基接口的成员只能有一个实现。

### 2.6 成员

> + 除了分部方法（第 10.2.7 节），在多个部分中声明的类型的成员集仅仅是在每个部分中声明的成员集的并集。
> + 所有部分的类型声明主体共享相同的声明空间，并且每个成员的范围都扩展到所有部分的主体。
> + 任何成员的可访问性域总是包含包容类型的所有部分；

### 2.7 分部方法

> + 分部方法可以在类型声明的一个部分中定义，而在另一个部分中实现。
> + 如果所有部分都未实现分部方法，则将从组合各部分而构成的类型声明中，移除分部方法声明和所有对它的调用。
> + 分部方法不能定义访问修饰符，而隐含为 private。它们的返回类型必须是void，而且它们的形参不能带有out 修饰符。
> + 在方法声明中，仅当标识符 partial 紧靠 void 类型之前出现时，才将它识别为特殊关键字，否则，将它用作正常标识符。分部方法不能显式实现接口方法。
> + 如果方法声明体是一个分号，则称该声明是定义分部方法声明 (defining partial method declaration)。
> + 如果以 block 形式给定该声明体，则称该声明是实现分部方法声明 (implementing partial method declaration)。
> + 在类型声明的各个部分，只能有一个具有给定签名的定义分部方法声明，也只能有一个具有给定签名的实现分部方法声明。如果给定了实现分部方法声明，则必须存在相应的定义分部方法声明，并且这两个声明必须符合以下指定的内容：
>   + 这两个声明必须具有相同的修饰符（但不必采用同一顺序）、方法名、类型形参数目和形参数目。
>   + 声明中相应的形参必须具有相同的修饰符（但不必采用同一顺序）和相同的类型（类型形参名称中的模不同）。
>   + 声明中的相应类型形参必须具有相同的约束（类型形参名称中的模不同）。

```
partial class Customer
{
	string name;
	public string Name {
		get { return name; }
		set {
			OnNameChanging(value);
			name = value;
			OnNameChanged();
		}
	}
	partial void OnNameChanging(string newName);
	partial void OnNameChanged();
}

class Customer
{
	string name;
	public string Name {
		get { return name; }
		set { name = value; }
	}
}


partial class Customer
{
	partial void OnNameChanging(string newName)
	{
		Console.WriteLine(“Changing “ + name + “ to “ + newName);
	}
	partial void OnNameChanged()
	{
		Console.WriteLine(“Changed to “ + name);
	}
}

```



### 2.8 名称绑定

> 虽然可扩展类型的每个部分都必须在同一命名空间中声明，但是这些部分通常在不同的命名空间声明下编写。

```
namespace N
{
	using List = System.Collections.ArrayList;
	partial class A
	{
		List x;				// x has type System.Collections.ArrayList
	}
}

namespace N
{
	using List = Widgets.LinkedList;
	partial class A
	{
		List y;				// y has type Widgets.LinkedList
	}
}

```



## 3.类成员

> + 一个类类型的成员分为下列几种类别：
>   - 常量，表示与该类相关联的常量值
>   - 字段，即该类的变量
>   - 方法，用于实现可由该类执行的计算和操作
>   - 属性，用于定义一些命名特性以及与读取和写入这些特性相关的操作
>   - 事件，用于定义可由该类生成的通知
>   - 索引器，使该类的实例可按与数组相同的（语法）方式进行索引
>   - 运算符，用于定义表达式运算符，通过它对该类的实例进行运算
>   - 实例构造函数，用于实现初始化该类的实例所需的操作
>   - 析构函数，用于实现在永久地放弃该类的一个实例之前要执行的操作
>   - 静态构造函数，用于实现初始化该类自身所需的操作
>   - 类型，用于表示一些类型，它们是该类的局部类型

### 3.1 实例类型

> + 每个类声明都有一个关联的绑定类型,即实例类型 (instance type)。
> + 对于泛型类声明，实例类型是通过从该类型声明创建构造类型来构成的，所提供的每个类型实参替换对应的类型形参。
> + 由于实例类型使用类型形参，因此只能在类型形参的作用域中使用该实例类型；也就是在类声明的内部。
> + 对于在类声明中编写的代码，实例类型为 this 的类型。对于非泛型类，实例类型就是所声明的类。

```
class A<T>							// instance type: A<T>
{
	class B {}						// instance type: A<T>.B
	class C<U> {}					// instance type: A<T>.C<U>
}
class D {}							// instance type: D

```



### 3.2 构造类型的成员

> + 构造类型的非继承成员是通过将成员声明中的每个 type-parameter 替换为构造类型的对应 type-argument 来获得的。
> + 替换过程基于类型声明的语义含义，并不只是文本替换。

给定下面的泛型类声明

```
class Gen<T,U>
{
	public T[,] a;
	public void G(int i, T t, Gen<U,T> gt) {...}
	public U Prop { get {...} set {...} }
	public int H(double d) {...}
}

```

构造类型 Gen<int[],IComparable<string>> 具有以下成员：

```
public int[,][] a;
public void G(int i, int[] t, Gen<IComparable<string>,int[]> gt) {...}
public IComparable<string> Prop { get {...} set {...} }
public int H(double d) {...}
```

> + 在实例函数成员中，类型 pe of this 是包含这些成员的声明的实例类型
> + 泛型类的所有成员都可以直接或作为构造类型的一部分使用任何包容类 (enclosing class) 中的类型形参。
> + 当在运行时使用特定的封闭构造类型（第 4.4.2 节）时，所使用的每个类型形参都被替换成提供给该构造类型的实际类型实参。

```
class C<V>
{
	public V f1;
	public C<V> f2 = null;
	public C(V x) {
		this.f1 = x;
		this.f2 = this;
	}
}
class Application
{
	static void Main() {
		C<int> x1 = new C<int>(1);
		Console.WriteLine(x1.f1);		// Prints 1
		C<double> x2 = new C<double>(3.1415);
		Console.WriteLine(x2.f1);		// Prints 3.1415
	}
}
```



### 3.3 继承

> 一个类继承 (inherit) 它的直接基类类型的成员。继承意味着一个类隐式地将它的直接基类类型的所有成员当作自已的成员，但基类的实例构造函数、析构函数和静态构造函数除外。
>
> + 继承是可传递的。如果 C 从 B 派生，而 B 从 A 派生，则 C 将既继承在 B 中声明的成员，又继承在 A 中声明的成员
> + 派生类扩展它的直接基类。派生类能够在继承基类的基础上添加新的成员，但是它不能移除继承成员的定义。
> + 实例构造函数、析构函数和静态构造函数是不可继承的，但所有其他成员是可继承的，无论它们所声明的可访问性如何。但是，根据它们所声明的可访问性，有些继承成员在派生类中可能是无法访问的。
> + 派生类可以通过声明具有相同名称或签名的新成员来隐藏 (hide)那个被继承的成员。但是，请注意隐藏继承成员并不移除该成员，它只是使被隐藏的成员在派生类中不可直接访问。
> + 类的实例含有在该类中以及它的所有基类中声明的所有实例字段集，并且存在一个从派生类类型到它的任一基类类型的隐式转换。因此，可以将对某个派生类实例的引用视为对它的任一个基类实例的引用。
> + 类可以声明虚的方法、属性和索引器，而派生类可以重写这些函数成员的实现。这使类展示出“多态性行为”特征，也就是说，同一个函数成员调用所执行的操作可能是不同的，这取决于用来调用该函数成员的实例的运行时类型。

### 3.4 new 修饰符

> class-member-declaration 中可以使用与一个被继承的成员相同的名称或签名来声明一个成员。发生这种情况时，就称该派生类成员隐藏 (hide) 了基类成员。派生类成员的声明中可以包含一个 new 修饰符，表示派生成员是有意隐藏基成员的。

### 3.5 访问修饰符

> class-member-declaration 可以具有下列五种可能的已声明可访问性中的任意一种：public、protected internal、protected、internal 或 private。除 protected internal 组合外，指定一个以上的访问修饰符会导致编译时错误。当 class-member-declaration 不包含任何访问修饰符时，假定为 private。

### 3.6 构成类型

> 在成员声明中所使用的类型称为成员的构成类型。可能的构成类型包括常量、字段、属性、事件或索引器类型，方法或运算符的返回类型，以及方法、索引器、运算符和实例构造函数的形参类型。成员的构成类型必须至少具有与该成员本身相同的可访问性

### 3.7 静态成员和实例成员

> + 类的成员或者是静态成员 (static member)，或者是实例成员 (instance member)。一般说来，可以这样来理解：静态成员属于类类型，而实例成员属于对象（类类型的实例）。
>
> + 当字段、方法、属性、事件、运算符或构造函数声明中含有 static 修饰符时，它声明静态成员。此外，常量或类型声明会隐式地声明静态成员
> + 当字段、方法、属性、事件、索引器、构造函数或析构函数的声明中不包含 static 修饰符时，它声明实例成员。

```
class Test
{
	int x;
	static int y;
	void F() {
		x = 1;			// Ok, same as this.x = 1
		y = 1;			// Ok, same as Test.y = 1
	}
	static void G() {
		x = 1;			// Error, cannot access this.x
		y = 1;			// Ok, same as Test.y = 1
	}
	static void Main() {
		Test t = new Test();
		t.x = 1;			// Ok
		t.y = 1;			// Error, cannot access static member through instance
		Test.x = 1;		// Error, cannot access instance member through type
		Test.y = 1;		// Ok
	}
}

```



### 3.8 嵌套类型

> + 在类或结构声明内部声明的类型称为嵌套类型 (nested type)。在编译单元或命名空间内声明的类型称为非嵌套类型 (non-nested type)。

```
using System;
class A
{
	class B
	{
		static void F() {
			Console.WriteLine("A.B.F");
		}
	}
}
```

+ 完全限定名

  > 嵌套类型的完全限定名为 A.B.F();

  

+ 已声明可访问性

  > 在类中声明的嵌套类型可以具有五种形式的已声明可访问性（public、protected
  > internal、protected、internal 或 private）中的任一种，而且与其他类成员一样，默认的已声明可访问性为 private。

   >  在结构中声明的嵌套类型可以具有三种已声明可访问性（public、internal 或 private）中的任一种形式，而且与其他结构成员一样，默认的已声明可访问性为 private。

   ```
   public class List
   {
   	// Private data structure
   	private class Node
   	{ 
   		public object Data;
   		public Node Next;
   		public Node(object data, Node next) {
   			this.Data = data;
   			this.Next = next;
   		}
   	}
   	private Node first = null;
   	private Node last = null;
   	// Public interface
   	public void AddToFront(object o) {...}
   	public void AddToBack(object o) {...}
   	public object RemoveFromFront() {...}
   	public object RemoveFromBack() {...}
   	public int Count { get {...} }
   }
   ```

   

> + 隐藏
>
>    嵌套类型可以隐藏基成员。对嵌套类型声明允许使用 new 修饰符，以便可以明确表示隐藏。

   ```
   using System;
   class Base
   {
   	public static void M() {
   		Console.WriteLine("Base.M");
   	}
   }
   class Derived: Base 
   {
   	new public class M 
   	{
   		public static void F() {
   			Console.WriteLine("Derived.M.F");
   		}
   	}
   }
   class Test 
   {
   	static void Main() {
   		Derived.M.F();
   	}
   }
   
   ```

   

> + this 访问

  > 在嵌套类型内，this 不能用于引用包含它的那个类型的实例成员。当需要在嵌套类型内部访问包含它的那个类型的实例成员时，通过将代表所需实例的 this 作为一个实参传递给该嵌套类型的构造函数，就可以进行所需的访问了。

   ```
   using System;
   class C
   {
   	int i = 123;
   	public void F() {
   		Nested n = new Nested(this);
   		n.G();
   	}
   	public class Nested
   	{
   		C this_c;
   		public Nested(C c) {
   			this_c = c;
   		}
   		public void G() {
   			Console.WriteLine(this_c.i);
   		}
   	}
   }
   class Test
   {
   	static void Main() {
   		C c = new C();
   		c.F();
   	}
   }
   
   ```

   

> + 对包含类型的私有和受保护成员的访问
>
>   > 嵌套类型可以访问包含它的那个类型可访问的所有成员，包括该类型自己的具有 private 和 protected 声明可访问性的成员。

   ```
   public class Base
   {
   	private void E()
       {
       	Console.WriteLine("Base.E");
   	}
   
   	protected void F() 
       {
       	Console.WriteLine("Base.F");
   	}
   
       protected static void G()
       {
       	Console.WriteLine("Base.G");
   	}
   }
   
   public class Derived : Base
   {
       private void A() 
       {
           base.F(); // 调用基类公开函数
           Console.WriteLine("Derived.A");
       }
   
       private void B() 
       {
           Base.G(); // 调用类静态公开函数
           Console.WriteLine("Derived.B");
       }
   
       public class Nested
       {
           private void H()
           {
               new Derived().A(); // 嵌套类型调用实例private函数
               Console.WriteLine("Derived.H");
           }
   
           public void I()
           {
               this.H(); // 嵌套类型调用自身实例private函数
               Console.WriteLine("this.I");
           }
   		
           private static void GG() 
           {
               Console.WriteLine("Derived.Nested.GG");
           }
   
           public static void G()
           {
               Derived.Nested.GG();
           }
       }
   }
   
   static void TestNestType()
   {
       new Derived.Nested().I();
       Derived.Nested.G();
   }
   ```

   

> + 泛型类中的嵌套类型
>
>   > - 泛型类声明可以包含嵌套的类型声明。包容类的类型形参可以在嵌套类型中使用。嵌套类型声明可以包含仅适用于该嵌套类型的附加类型形参。
>   >
>   > - 泛型类声明中包含的每个类型声明都隐式地是泛型类型声明。在编写对嵌套在泛型类型中的类型的引用时，必须指定其包容构造类型（包括其类型实参）。但是可在外层类中不加限定地使用嵌套类型；在构造嵌套类型时可以隐式地使用外层类的实例类型。
>
>   ```
>   class Outer<T>
>       {
>           class Inner<U>
>           {
>               public static void F(T t, U u) { }
>   
>               static void F(T t)
>               {
>                   Outer<T>.Inner<string>.F(t, "abc");
>                   Inner<string>.F(t);
>                   Outer<int>.Inner<string>.F(3, "abc");
>                   // Outer.Inner<string>.F(t, "abc"); Error,Outer needs type arg
>               }
>           }
>       }
>   ```
>



### 3.9 保留成员名称

> + 为便于基础 C# 运行时的实现，对于每个属性、事件或索引器的源成员声明，实现都必须根据成员声明的种类、名称和类型保留两个方法签名。
>
> + 保留名称不会引入声明，因此它们不参与成员查找。但是，一个声明的关联的保留方法签名的确参与继承，而且可以使用 new 修饰符隐藏起来。
>
> + 保留成员名称目的：
>
>   - 使基础的实现可以通过将普通标识符用作一个方法名称，从而对 C# 语言的功能进行 get 或 set 访问。
>   - 使其他语言可以通过将普通标识符用作一个方法名称，对 C# 语言的功能进行 get 或 set 访问，从而实现交互操作。
>   - 使保留成员名称的细节在所有的
>     C# 实现中保持一致，这有助于确保被一个符合本规范的编译器所接受的源程序也可被另一个编译器接受。
>   - 析构函数的声明也会导致一个签名被保留
>
>   ```
>   class A
>   {
>   	public int P {
>   		get { return 123; }
>   	}
>   }
>   class B: A
>   {
>   	new public int get_P() {
>   		return 456;
>   	}
>   	new public void set_P(int value) {
>   	}
>   }
>   class Test
>   {
>   	static void Main() {
>   		B b = new B();
>   		A a = b;
>   		Console.WriteLine(a.P); // 123
>   		Console.WriteLine(b.P); // 123
>   		Console.WriteLine(b.get_P());// 456
>   	}
>   }
>   
>   ```

## 4.常量

> 常量 (constant) 是表示常量值（即，可以在编译时计算的值）的类成员。
>
> ```
> constant-declaration:
> 	[attributes] [constant-modifiers] const type constant-declarators;
> 	
> constant-modifiers:
> 	constant-modifier
> 	constant-modifiers   constant-modifier
> 	
> constant-modifier:
>     new
>     public
>     protected
>     internal
>     private
>     
> constant-declarators:
>     constant-declarator
>     constant-declarators,constant-declarator
>     
> constant-declarator:
> 	identifier = constant-expression
> 
> ```
>
> + constant-declaration 可包含一组 attributes、一个 new 修饰符和一个由四个访问修饰符构成的有效组合。特性和修饰符适用于所有由 constant-declaration 所声明的成员。虽然常量被认为是静态成员，但在 constant-declaration 中既不要求也不允许使用 static 修饰符。同一个修饰符在一个常量声明中多次出现是错误的。
> + constant-declaration 的 type 用于指定由声明引入的成员的类型。类型后接一个 constant-declarator 列表，该列表中的每个声明符引入一个新成员。constant-declarator 包含一个用于命名该成员的 identifier，后接一个“=”标记，然后跟一个对该成员赋值的 constant-expression
> + 在常量声明中指定的 type 必须是
>   sbyte、byte、short、ushort、int、uint、long、ulong、char、float、double、decimal、bool、string、 enum-type 或 reference-type。每个 constant-expression 所产生的值必须属于目标类型，或者可以通过一个隐式转换转换为目标类型。
> + 常量的 type 必须至少与常量本身具有同样的可访问性。
> + 常量本身可以出现在 constant-expression 中。因此，常量可用在任何需要 constant-expression 的构造中。这样的构造示例包括 case 标签、goto case 语句、enum 成员声明、属性和其他的常量声明。
> + constant-expression 是在编译时就可以完全计算出来的表达式。由于创建 string 以外的 reference-type 的非 null 值的唯一方法是应用 new 运算符，但 constant-expression 中不允许使用 new 运算符，因此，除 string 以外的 reference-types 常量的唯一可能的值是 null。
> + 如果需要一个具有常量值的符号名称，但是该值的类型不允许在常量声明中使用，或在编译时无法由 constant-expression 计算出该值，则可以改用 readonly 字段

## 5.字段

> 字段 (field) 是一种表示与对象或类关联的变量的成员。field-declaration 用于引入一个或多个给定类型的字段。
>
> ```
> field-declaration:
> 	attributesopt   field-modifiersopt   type   variable-declarators;
> 	
> field-modifiers:
>     field-modifier
>     field-modifiers   field-modifier
>     
> field-modifier:
>     new
>     public
>     protected
>     internal
>     private
>     static
>     readonly
>     volatile
>     
> variable-declarators:
>     variable-declarator
>     variable-declarators   ,   variable-declarator
>     
> variable-declarator:
>     identifier
>     identifier   =   variable-initializer
>     
> variable-initializer:
>     expression
>     array-initializer
> 
> ```
>
> + field-declaration 可以包含一组 attributes，一个new 修饰符，由四个访问修饰符组成的一个有效组合和一个static 修饰符。此外，field-declaration 可以包含一个 readonly 修饰符）或一个volatile 修饰符，但不能同时包含这两个修饰符。特性和修饰符适用于由该 field-declaration 所声明的所有成员。同一个修饰符在一个字段声明中多次出现是错误的。
> + field-declaration 的 type 用于指定由该声明引入的成员的类型。类型后接一个 variable-declarator 列表，其中每个变量声明符引入一个新成员。variable-declarator 包含一个用于命名该成员的 identifier，还可以根据需要再后接一个“=”标记，以及一个用于赋予成员初始值的 variable-initializer
> + 字段的 type 必须至少与字段本身具有同样的可访问性。
> + 使用 simple-name或member-access从表达式获得字段的值。使用 assignment修改非只读字段的值。可以使用后缀增量和减量运算符以及前缀增量和减量运算符获取和修改非只读字段的值。

> + 静态字段和实例字段
>
>   - 静态字段不是特定实例的一部分，而是在封闭类型的所有实例之间共享。不管创建了多少个封闭式类类型的实例，对于关联的应用程序域来说，在任何时候静态字段都只会有一个副本。
>   - 实例字段属于某个实例。具体而言，类的每个实例都包含了该类的所有实例字段的一个单独的集合。
>
> ```
> class C<V>
> {
> 	static int count = 0;
> 	public C() {
> 		count++;
> 	}
> 	public static int Count {
> 		get { return count; }
> 	}
> }
> 
> class Application
> {
> 	static void Main() {
> 		C<int> x1 = new C<int>();
> 		Console.WriteLine(C<int>.Count);		// Prints 1
> 		C<double> x2 = new C<double>();
> 		Console.WriteLine(C<int>.Count);		// Prints 1
> 		C<int> x3 = new C<int>();
> 		Console.WriteLine(C<int>.Count);		// Prints 2
> 	}
> }
> 
> ```
>
### 5.1 只读字段
>  + 当 field-declaration 中含有 readonly 修饰符时，该声明所引入的字段为只读字段 (readonly field)。
> 
>  + 只在下列上下文中允许对 readonly 字段进行直接赋值：
> 
>    1. 在用于引入该字段的 variable-declarator 中（通过在声明中包括一个 variable-initializer）
>    2. 对于实例字段，在包含字段声明的类的实例构造函数中；对于静态字段，在包含字段声明的类的静态构造函数中。这些也是可以将 readonly 字段作为
>       out 或 ref 形参进行传递的仅有的上下文。
> 
>  + 对常量使用静态只读字段
> 
>    > 如果需要一个具有常量值的符号名称，但该值的类型不允许在 const 声明中使用，或者无法在编译时计算出该值，则 static readonly 字段就可以发挥作用了。

>    ```
>    public class Color
>    {
>    	public static readonly Color Black = new Color(0, 0, 0);
>    	public static readonly Color White = new Color(255, 255, 255);
>    	public static readonly Color Red = new Color(255, 0, 0);
>    	public static readonly Color Green = new Color(0, 255, 0);
>    	public static readonly Color Blue = new Color(0, 0, 255);
>    	private byte red, green, blue;
>    	public Color(byte r, byte g, byte b) {
>    		red = r;
>    		green = g;
>    		blue = b;
>    	}
>    }
>    ```
>
> + 常量和静态字段只读字段的版本控制，当表达式引用常量时，该常量的值在编译时获取，但是当表达式引用只读字段时，要等到运行时才获取该字段的值。
>
```
using System;
namespace Program1
{
	public class Utils
	{
		public static readonly int X = 1;
	}
}
namespace Program2
{
	class Test
	{
		static void Main() {
			Console.WriteLine(Program1.Utils.X);
		}
	}
}

```
>    Program1 和 Program2
>    命名空间表示两个单独编译的程序。由于 Program1.Utils.X 声明为静态只读字段，因此 Console.WriteLine 语句要输出的值在编译时是未知的，直到在运行时才能获取。因此，如果更改了 X 的值并重新编译 Program1，则 Console.WriteLine 语句会输出新值，即使未重新编译 Program2 也是如此。但如果 X 为常量，则 X 的值已在编译 Program2 时获取，则该值仍不会受到 Program1 中更改的影响，除非重新编译 Program2。

### 5.2  可变字段

>    - 当 field-declaration 中含有volatile 修饰符时，该声明引入的字段为可变字段 (volatile field)。
>    - 由于采用了优化技术（它会重新安排指令的执行顺序），在多线程的程序运行环境下，如果不采取同步（如由 lock-statement所提供的）控制手段，则对于非可变字段的访问可能会导致意外的和不可预见的结果。
>    - 读取一个可变字段称为可变读取(volatile read)。可变读取具有“获取语义”；也就是说，按照指令序列，所有排在可变读取之后的对内存的引用，在执行时也一定排在它的后面。
>    - 写入一个可变字段称为可变写入(volatile write)。可变写入具有“释放语义”；也就是说，按照指令序列，所有排在可变写入之前的对内存的引用，在执行时也一定排在它的前面。

```
using System;
using System.Threading;
class Test
{
	public static int result;   
	public static volatile bool finished;
	static void Thread2() {
		result = 143;    
		finished = true; 
	}
	static void Main() {
		finished = false;
		// Run Thread2() in a new thread
		new Thread(new ThreadStart(Thread2)).Start();
		// Wait for Thread2 to signal that it has a result by setting
		// finished to true.
		for (;;) {
			if (finished) {
				Console.WriteLine("result = {0}", result);
				return;
			}
		}
	}
}
// 输出 result = 143
/* 在本示例中，方法 Main 将启动一个新线程，该线程运行方法 Thread2。该方法将一个值存储在叫做 result 的非可变字段中，然后将 true 存储在可变字段 finished 中。主线程将等待字段 finished 被设置为 true，然后读取字段 result。由于已将 finished 声明为 volatile，主线程必须从字段 result 读取值 143。如果字段 finished 未被声明为 volatile，则存储 finished 之后，主线程可看到存储 result，因此主线程从字段 result 读取值 0。将 finished 声明为 volatile 字段可以防止任何此类不一致性。*/
```

### 5.3  字段初始化

>   + 字段（无论是静态字段还是实例字段）的初始值都是字段的类型的默认值
>
> + 变量初始值设定项
>- 对于静态字段，变量初始值设定项相当于在类初始化期间执行的赋值语句。
>
>- 对于实例字段，变量初始值设定项相当于创建类的实例时执行的赋值语句。
>
```
using System;
class Test
{
	static double x = Math.Sqrt(2.0);
	int i = 100;
	string s = "Hello";
	static void Main() {
		Test a = new Test();
		Console.WriteLine("x = {0}, i = {1}, s = {2}", x, a.i, a.s);
	}
}
// 产生输出 x = 1.4142135623731, i = 100, s = Hello
// 对 x 的赋值发生在静态字段初始值设定项执行时，而对 i 和 s 的赋值发生在实例字段初始值设定项执行时。
```

>- 当初始化一个类时，首先将该类中的所有静态字段初始化为它们的默认值，然后以文本顺序执行各个静态字段初始值设定项。
>
>- 创建类的一个实例时，首先将该实例中的所有实例字段初始化为它们的默认值，然后以文本顺序执行各个实例字段初始值设定项。
>
>- 类的静态字段变量初始值设定项对应于一个赋值序列，这些赋值按照它们在类声明中出现的文本顺序执行。如果类中存在静态构造函数（第 10.12 节） \r \h ，则在静态构造函数即将执行之前，将执行静态字段初始值设定项。否则，静态字段初始值设定项在第一次使用该类的静态字段之前先被执行，但实际执行时间依赖于具体的实现。
>
```
class Test 
{ 
	static void Main() {
		Console.WriteLine("{0} {1}", B.Y, A.X);
	}
	public static int F(string s) {
		Console.WriteLine(s);
		return 1;
	}
}
class A
{
	public static int X = Test.F("Init A");
}
class B
{
	public static int Y = Test.F("Init B");
}
/*
输出：
Init A
Init B
1 1
或者
Init B
Init A
1 1
这是因为 X 的初始值设定项和 Y 的初始值设定项的执行顺序无法预先确定，上述两种顺序都有可能发生；唯一能够确定的是：它们一定会在对那些字段的引用之前发生。
*/

class Test
{
	static void Main() {
		Console.WriteLine("{0} {1}", B.Y, A.X);
	}
	public static int F(string s) {
		Console.WriteLine(s);
		return 1;
	}
}
class A
{
	static A() {}
	public static int X = Test.F("Init A");
}
class B
{
	static B() {}
	public static int Y = Test.F("Init B");
}
/*
输出必然是：
Init B
Init A
1 1
B 的静态构造函数（以及 B 的静态字段初始值设定项）必须在 A 的静态构造函数和字段初始值设定项之前运行。
*/
```

>+ 类的实例字段变量初始值设定项对应于一个赋值序列，它在当控制进入该类的任一个实例构造函数时立即执行。
> 
>  >+ 实例字段的变量初始值设定项不能引用正在创建的实例。因此，在变量初始值设定项中引用 this 是编译时错误，同样，在变量初始值设定项中通过 simple-name 引用任何一个实例成员也是一个编译时错误。

## 6.方法

## 7.属性

## 8.事件

## 9.索引器

## 10.运算符

## 11.实例构造函数

## 12.静态构造函数  

## 13.析构函数

## 14.迭代器

## 15.异步函数


```

```