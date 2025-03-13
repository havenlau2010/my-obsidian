









[TOC]

## 1.	查询表达式

> 查询表达式 (query expression) 为查询提供一种类似于关系和分层查询语言（如 SQL 和 XQuery）的语言集成语法。


> 1. 初始 from 子句后面可以跟零个或者多个 from、let、where、join 或 orderby 子句。
> 2. 每个 from 子句都是一个生成器，该生成器将引入一个包括序列 (sequence) 的元素的范围变量 (range variable)。
> 3. 每个 let 子句都会引入一个范围变量，以表示通过前一个范围变量计算的值。
> 4. 每个 where 子句都是一个筛选器，用于从结果中排除项。
> 5. 每个 join 子句都将指定的源序列键与其他序列的键进行比较，以产生匹配对。
> 6. 每个 orderby 子句都会根据指定的条件对各项进行重新排序。而最后的 select 或 group 子句根据范围变量来指定结果的表现形式。
> 7. 最后，可以使用 into 子句来“连接”查询，方法是将某一查询的结果视为后续查询的生成器。

## 2.	分类

1. query-expression

   `from-clause   query-body`

2. from-clause

   `from   typeopt   identifier   in   expression `

3. query-body

   `query-body-clausesopt   select-or-group-clause   query-continuationopt`

4. query-body-clauses

   1. `query-body-clause`
   2. `query-body-clauses query-body-clause` 

5. query-body-clause

   1. `from-clause`
   2. `let-clause`
   3. `where-clause`
   4. `join-clause`
   5. `join-into-clause`
   6. `orderby-clause`

6. let-clause

   `let identifier = expression`

7. where-clause

   `where  boolean-expression`

8. join-clause

   `join typeopt identifier in expression on expression equals expression`

9. join-into-clause

   `join typeopt identifier in expression on expression equals expression into identifier`

10. orderby-clause

    `orderby orderings`

11. orderings

    1. `ordering`
    2. `ordering,ordering`

12. ordering-direction

    1. `ascending`
    2. `descending`

13. select-or-group-clause

    1. `select-clause`
    2. `group-clause`

14. select-clause

    `select expression`

15. group-clause

    `group expression by expression`

16. query-continuation

    `into identifier query-body`



## 3.	多义性

> 1. 查询表达式上下文关键字：from、where、join、on、equals、into、let、orderby、ascending、descending、select、group 和 by。
> 2. 查询表达式是以“from identifier”开头后接除“;”、“=”或“,”之外的任何标记的任何表达式。
> 3. 如果要使用关键字作为简单名称使用，在其前缀上加上“@select”

## 4.	转换

> C# 语言不指定查询表达式的执行语义。而是将查询表达式转换为遵循查询表达式模式的方法调用。具体而言，查询表达式将转换为对具有以下名称的方法的调用：Where、Select、SelectMany、Join、GroupJoin、OrderBy、OrderByDescending、ThenBy、ThenByDescending、GroupBy 和 Cast。

### 4.1	转换规则
> 1. 从查询表达式到方法调用的转换是一种句法映射，在执行任何类型绑定或重载决策之前发生。
> 2. 查询表达式的处理方式为：重复应用以下转换，直到不可能进一步缩减。
> 3. 转换按应用顺序列出：每一部分都假设前面部分的转换已彻底执行，一旦某个部分彻底执行，之后在同一查询表达式的处理过程中便不再重新访问该部分。
> 4. 不允许对查询表达式中的范围变量进行赋值。但允许 C# 实现在某些时候可以不实施此限制，因为对于此处介绍的句法转换方案，有些时候可能根本无法实施此限制。
> 5. 某些转换使用由 * 指示的透明标识符注入范围变量。

### 4.2	转换示例

#### 1. 带继续符的查询表达式

   + ```
     from … into x … 
     转换为 
     from x in (from … ) …
     ```

   + ```
     from c in customers 
     group c by c.Country into g
     select new {Country = g.key,CustCount = g.Count()}
     转换为
     from g in 
     	from c in customers
     	group c by c.Country
     select new {Country = g.key,CustCount = g.Count()}
     最终转换为
     customers.
     GroupBy(c=>c.Country)
     Select(g=>new { Country = g.key,CustCount = g.Count() })
     ```

#### 2. 显示范围变量类型

   > 显式范围变量类型对于查询实现非泛型 IEnumerable 接口的集合很有用，但对于实现泛型 IEnumerable<T> 接口的集合没什么用处。

   + 显式指定范围变量类型的 from 子句

     ```
     from T x in e
     转换为
     from x in ( e ) . Cast < T > ( )
     ```

   + 显式指定范围变量类型的 join 子句

     ```
     join T x in e on k1 equals k2
     转换为
     join x in ( e ) . Cast < T > ( ) on k1 equals k2
     ```

   + 转换查询没有显式范围变量类型

     ```
     from Customer c in customers
     where c.City == "London"
     select c
     转换为
     from c in customers.Cast<Customer>()
     where c.City == "London"
     select c
     最终转换为
     customers.
     Cast<Customer>().
     Where(c => c.City == "London")
     ```

#### 3. 退化查询表达式
> 退化查询表达式是平常选择源的元素的查询表达式。后面的转换阶段会移除由其他转换步骤引入的退化查询，方法是用其源替换这些退化查询。
```
from x in e select x 转换为 ( e ) . Select ( x => x )
from c in customers select c 转换为 customers.Select(c=>c)
```

#### 4. from、let、where、join和orderby子句

   + 带有另一个 from 子句且后接一个 select 子句的查询表达式

     ```
     from x1 in e1
     from x2 in e2
     select v
     转换为
     ( e1 ) . SelectMany( x1 => e2 , ( x1 , x2 ) => v )
     ```

     

   + 带有另一个 from 子句且后接除 select 以外的任何子句的查询表达式

     ```
     from x1 in e1
     from x2 in e2
     …
     转换为
     from * in ( e1 ) . SelectMany( x1 => e2 , ( x1 , x2 ) => new { x1 , x2 } )
     …
     ```

     

   + 带有 let 子句的查询表达式

     ```
     from x in e
     let y = f
     …
     转换为
     from * in ( e ) . Select ( x => new { x , y = f } )
     …
     ```

     

   + 带有 where 子句的查询表达式

     ```
     from x in e
     where f
     …
     转换为
     from x in ( e ) . Where ( x => f )
     …
     ```

     

   + 带有 join 子句（不含into）且后接select 子句的查询表达式

     ```
     from x1 in e1
     join x2 in e2 on k1 equals k2
     select v
     转换为
     ( e1 ) . Join( e2 , x1 => k1 , x2 => k2 , ( x1 , x2 ) => v )
     ```

     

   + 带有 join 子句（不含 into）且后接除 select 子句之外的其他内容的查询表达式

     ```
     from x1 in e1
     join x2 in e2 on k1 equals k2 
     …
     转换为
     from * in ( e1 ) . Join(
     	e2 , x1 => k1 , x2 => k2 , ( x1 , x2 ) => new { x1 , x2 })
     …
     ```

     

   + 带有 join 子句（含 into）且后接 select 子句的查询表达式

     ```
     from x1 in e1
     join x2 in e2 on k1 equals k2 into g
     select v
     转换为
     ( e1 ) . GroupJoin( e2 , x1 => k1 , x2 => k2 , ( x1 , g ) => v )
     ```

   + 带有 join 子句（含into）且后接除select 子句之外的其他内容的查询表达式

     ```
     from x1 in e1
     join x2 in e2 on k1 equals k2 into g
     …
     转换为
     from * in ( e1 ) . GroupJoin(
     	e2 , x1 => k1 , x2 => k2 , ( x1 , g ) => new { x1 , g })
     …
     ```

     

   + 带有 orderby 子句的查询表达式

     ```
     from x in e
     orderby k1 , k2 , … , kn
     …
     转换为
     from x in ( e ) . 
     OrderBy ( x => k1 ) . 
     ThenBy ( x => k2 ) .
      … . 
     ThenBy ( x => kn )
     …
     ```

     

#### 5. 示例

   + ```
     from c in customers
     from o in c.Orders
     select new { c.Name, o.OrderID, o.Total }
     转换为
     customers.
     SelectMany(c => c.Orders,
     	 (c,o) => new { c.Name, o.OrderID, o.Total }
     )
     ```

   + ```
     from c in customers
     from o in c.Orders
     orderby o.Total descending
     select new { c.Name, o.OrderID, o.Total }
     转换为
     from * in customers.
     	SelectMany(c => c.Orders, (c,o) => new { c, o })
     orderby o.Total descending
     select new { c.Name, o.OrderID, o.Total }
     其最终转换为
     customers.
     SelectMany(c => c.Orders, (c,o) => new { c, o }).
     OrderByDescending(x => x.o.Total).
     Select(x => new { x.c.Name, x.o.OrderID, x.o.Total })
     ```

   + ```
     from o in orders
     let t = o.Details.Sum(d => d.UnitPrice * d.Quantity)
     where t >= 1000
     select new { o.OrderID, Total = t }
     转换为
     from * in orders.
     	Select(o => new { o, t = o.Details.Sum(d => d.UnitPrice * d.Quantity) })
     where t >= 1000 
     select new { o.OrderID, Total = t }
     其最终转换为
     orders.
     Select(o => new { o, t = o.Details.Sum(d => d.UnitPrice * d.Quantity) }).
     Where(x => x.t >= 1000).
     Select(x => new { x.o.OrderID, Total = x.t })
     
     ```

   + ```
     from c in customers
     join o in orders on c.CustomerID equals o.CustomerID
     select new { c.Name, o.OrderDate, o.Total }
     转换为
     customers.Join(orders, c => c.CustomerID, o => o.CustomerID,
     	(c, o) => new { c.Name, o.OrderDate, o.Total })
     ```

   + ```
     from c in customers
     join o in orders on c.CustomerID equals o.CustomerID into co
     let n = co.Count()
     where n >= 10
     select new { c.Name, OrderCount = n }
     转换为
     from * in customers.
     	GroupJoin(orders, c => c.CustomerID, o => o.CustomerID,
     		(c, co) => new { c, co })
     let n = co.Count()
     where n >= 10 
     select new { c.Name, OrderCount = n }
     其最终转换为
     customers.
     GroupJoin(orders, c => c.CustomerID, o => o.CustomerID,
     	(c, co) => new { c, co }).
     Select(x => new { x, n = x.co.Count() }).
     Where(y => y.n >= 10).
     Select(y => new { y.x.c.Name, OrderCount = y.n)
     ```

   + ```
     from o in orders
     orderby o.Customer.Name, o.Total descending
     select o
     具有最终转换
     orders.
     OrderBy(o => o.Customer.Name).
     ThenByDescending(o => o.Total)
     
     ```

#### 6. select子句

   ```
   from x in e select v
   转换为
   ( e ) . Select ( x => v )
   
   当 v 为标识符 x 时，转换仅为
   ( e )
   
   from c in customers.Where(c => c.City == “London”)
   select c
   仅转换为
   customers.Where(c => c.City == “London”)
   ```

#### 7. groupby子句

   ```
   from x in e group v by k
   转换为
   ( e ) . GroupBy ( x => k , x => v )
   
   当 v 为标识符 x 时，转换为
   ( e ) . GroupBy ( x => k )
   
   from c in customers
   group c.Name by c.Country
   转换为
   customers.
   GroupBy(c => c.Country, c => c.Name)
   ```

#### 8. 透明标识符

   > 1. 某些转换使用由 * 指示的透明标识符注入范围变量。透明标识符不是合适的语言功能；它们在查询表达式转换过程中仅作为中间步骤存在。
   > 2. 当查询转换注入透明标识符时，进一步的转换步骤将透明标识符传播到匿名函数和匿名对象初始值设定项中。
   > 3. 透明标识符始终与匿名类型一起引入，目的是以一个对象的成员的形式捕获多个范围变量。

   + ```
     from c in customers
     from o in c.Orders
     orderby o.Total descending
     select new { c.Name, o.Total }
     
     转换为
     from * in customers.
     	SelectMany(c => c.Orders, (c,o) => new { c, o })
     orderby o.Total descending
     select new { c.Name, o.Total }
     
     进一步转换为
     customers.
     SelectMany(c => c.Orders, (c,o) => new { c, o }).
     OrderByDescending(* => o.Total).
     Select(* => new { c.Name, o.Total })
     
     在清除透明标识符后等效于
     customers.
     SelectMany(c => c.Orders, (c,o) => new { c, o }).
     OrderByDescending(x => x.o.Total).
     Select(x => new { x.c.Name, x.o.Total })
     
     ```

   + ```
     from c in customers
     join o in orders on c.CustomerID equals o.CustomerID
     join d in details on o.OrderID equals d.OrderID
     join p in products on d.ProductID equals p.ProductID
     select new { c.Name, o.OrderDate, p.ProductName }
     转换为
     from * in customers.
     	Join(orders, c => c.CustomerID, o => o.CustomerID, 
     		(c, o) => new { c, o })
     join d in details on o.OrderID equals d.OrderID
     join p in products on d.ProductID equals p.ProductID
     select new { c.Name, o.OrderDate, p.ProductName }
     进一步缩减为
     customers.
     Join(orders, c => c.CustomerID, o => o.CustomerID, (c, o) => new { c, o }).
     Join(details, * => o.OrderID, d => d.OrderID, (*, d) => new { *, d }).
     Join(products, * => d.ProductID, p => p.ProductID, (*, p) => new { *, p }).
     Select(* => new { c.Name, o.OrderDate, p.ProductName })
     其最终转换为
     customers.
     Join(orders, c => c.CustomerID, o => o.CustomerID,
     	(c, o) => new { c, o }).
     Join(details, x => x.o.OrderID, d => d.OrderID,
     	(x, d) => new { x, d }).
     Join(products, y => y.d.ProductID, p => p.ProductID,
     	(y, p) => new { y, p }).
     Select(z => new { z.y.x.c.Name, z.y.x.o.OrderDate, z.p.ProductName })
     
     ```

## 5.模式

> 查询表达式模式 (Query expression pattern) 建立了一种方法模式，类型可以实现该模式来支持查询表达式。因为查询表达式通过句法映射转换为方法调用，所以类型在如何实现查询表达式模式方面具有很大灵活性。

+ 支持查询表达式模式的泛型类型 C<T> 的建议形式如下所示。

  ```
  delegate R Func<T1,R>(T1 arg1);
  delegate R Func<T1,T2,R>(T1 arg1, T2 arg2);
  class C
  {
  	public C<T> Cast<T>();
  }
  class C<T> : C
  {
  	public C<T> Where(Func<T,bool> predicate);
  	public C<U> Select<U>(Func<T,U> selector);
  	public C<V> SelectMany<U,V>(Func<T,C<U>> selector,
  		Func<T,U,V> resultSelector);
  	public C<V> Join<U,K,V>(C<U> inner, Func<T,K> outerKeySelector,
  		Func<U,K> innerKeySelector, Func<T,U,V> resultSelector);
  	public C<V> GroupJoin<U,K,V>(C<U> inner, Func<T,K> outerKeySelector,
  		Func<U,K> innerKeySelector, Func<T,C<U>,V> resultSelector);
  	public O<T> OrderBy<K>(Func<T,K> keySelector);
  	public O<T> OrderByDescending<K>(Func<T,K> keySelector);
  	public C<G<K,T>> GroupBy<K>(Func<T,K> keySelector);
  	public C<G<K,E>> GroupBy<K,E>(Func<T,K> keySelector,
  		Func<T,E> elementSelector);
  }
  class O<T> : C<T>
  {
  	public O<T> ThenBy<K>(Func<T,K> keySelector);
  	public O<T> ThenByDescending<K>(Func<T,K> keySelector);
  }
  class G<K,T> : C<T>
  {
  	public K Key { get; }
  }
  ```

  