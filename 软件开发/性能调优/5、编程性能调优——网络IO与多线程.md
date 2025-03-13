一、IO与网络性能优化

I/O 的速度要比内存速度慢，尤其在大数据时代背景下，I/O 的性能问题更是尤为突出，I/O 读写已经成为很多应用场景下的系统性能瓶颈。

1.传统IO问题及优化

(1)传统 I/O 的性能问题

①多次内存复制

在传统 I/O 中，我们可以通过 InputStream 从源数据中读取数据流输入到缓冲区里，通过 OutputStream 将数据输出到外部设备（包括磁盘、网络）。

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOtO0THKaSQjMpwMnMRIicIc59fGJ4KXwM11jG4nRW2rTh0rwzibft46Ug/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

- JVM 会发出 read() 系统调用，并通过 read 系统调用向内核发起读请求；
    
- 内核向硬件发送读指令，并等待读就绪；
    
- 内核把将要读取的数据复制到指向的内核缓存中；
    

  

    操作系统内核将数据复制到用户空间缓冲区，然后 read 系统调用返回。在这个过程中，数据先从外部设备复制到内核空间，再从内核空间复制到用户空间，这就发生了两次内存复制操作。这种操作会导致不必要的数据拷贝和上下文切换，从而降低 I/O 的性能。

②阻塞

在传统 I/O 中，InputStream 的 read() 是一个 while 循环操作，它会一直等待数据读取，直到数据就绪才会返回。如果没有数据就绪，这个读取操作将会一直被挂起，用户线程将会处于阻塞状态。

在少量连接请求的情况下，使用这种方式没有问题，响应速度也很高。但在发生大量连接请求时，就需要创建大量监听线程，这时如果线程没有数据就绪就会被挂起，然后进入阻塞状态。一旦发生线程阻塞，这些线程将会不断地抢夺 CPU 资源，从而导致大量的 CPU 上下文切换，增加系统的性能开销。

(2)优化 I/O

在 JDK 1.4 中原来的 I/O 包和 NIO 已经很好地集成了。 java.io.* 已经以 NIO 为基础重新实现了，所以现在它可以利用 NIO 的一些特性。例如， java.io.* 包中的一些类包含以块的形式读写数据的方法，这使得即使在更面向流的系统中，处理速度也会更快。

可以看到，1.4后的IO经过了集成。所以NIO的好处，集中在其他特性上，而非速度:

- 分散与聚集读取 
    
- 文件锁定功能 
    
- 网络异步IO
    

  

2.序列化与反序列化

当前大部分后端服务都是基于微服务架构实现的。服务按照业务划分被拆分，实现了服务的解耦，但同时也带来了新的问题，不同业务之间通信需要通过接口实现调用。两个服务之间要共享一个数据对象，就需要从对象转换成二进制流，通过网络传输，传送到对方服务，再转换回对象，供服务方法调用。这个编码和解码过程我们称之为序列化与反序列化。

在大量并发请求的情况下，如果序列化的速度慢，会导致请求响应时间增加；而序列化后的传输数据体积大，会导致网络吞吐量下降。所以一个优秀的序列化框架可以提高系统的整体性能。

减少序列化(避免RPC)，如果无法减少替换java序列化的方法

(1)java序列化的实现原理

    Java 提供了一种序列化机制，这种机制能够将一个对象序列化为二进制形式（字节数组），用于写入磁盘或输出到网络，同时也能从网络或磁盘中读取字节数组，反序列化成对象，在程序中使用。JDK 提供的两个输入、输出流对象 ObjectInputStream 和 ObjectOutputStream，它们只能对实现了 Serializable 接口的类的对象进行反序列化和序列化。

具体实现序列化的是 writeObject 和 readObject，通常这两个方法是默认的，当然也可以在实现 Serializable 接口的类中对其进行重写，定制一套属于自己的序列化与反序列化机制。

另外，Java 序列化的类中还定义了两个重写方法：writeReplace() 和 readResolve()，前者是用来在序列化之前替换序列化对象的，后者是用来在反序列化之后对返回对象进行处理的。

(2)Java 序列化的缺陷

①无法跨语言

现在的系统设计越来越多元化，很多系统都使用了多种语言来编写应用程序。而 Java 序列化目前只适用基于 Java 语言实现的框架，其它语言大部分都没有使用 Java 的序列化框架，也没有实现 Java 序列化这套协议。因此，如果是两个基于不同语言编写的应用程序相互通信，则无法实现两个应用服务之间传输对象的序列化与反序列化。

②易被攻击

对象是通过在 ObjectInputStream 上调用 readObject() 方法进行反序列化的，这个方法其实是一个神奇的构造器，它可以将类路径上几乎所有实现了 Serializable 接口的对象都实例化。这也就意味着，在反序列化字节流的过程中，该方法可以执行任意类型的代码，这是非常危险的。

对于需要长时间进行反序列化的对象，不需要执行任何代码，也可以发起一次攻击。攻击者可以创建循环对象链，然后将序列化后的对象传输到程序中反序列化，这种情况会导致 hashCode 方法被调用次数呈次方爆发式增长, 从而引发栈溢出异常。例如下面这个案例就可以很好地说明。

```
Set root = new HashSet();  
Set s1 = root;  
Set s2 = new HashSet();  
for (int i = 0; i < 100; i++) {  
   Set t1 = new HashSet();  
   Set t2 = new HashSet();  
   t1.add("foo"); // 使 t2 不等于 t1  
   s1.add(t1);  
   s1.add(t2);  
   s2.add(t1);  
   s2.add(t2);  
   s1 = t1;  
   s2 = t2;   
}
```

后续解决方案

很多序列化协议都制定了一套数据结构来保存和获取对象。例如，JSON 序列化、ProtocolBuf 等，它们只支持一些基本类型和数组数据类型，这样可以避免反序列化创建一些不确定的实例。虽然它们的设计简单，但足以满足当前大部分系统的数据传输需求。

可以通过反序列化对象白名单来控制反序列化对象，可以重写 resolveClass 方法，并在该方法中校验对象名字。

```
@Override
protected Class resolveClass(ObjectStreamClass desc) throws IOException,ClassNotFoundException {
	if (!desc.getName().equals(Bicycle.class.getName())) {

	throw new InvalidClassException(
	"Unauthorized deserialization attempt", desc.getName());
	}
	return super.resolveClass(desc);
}
```

③序列化后的流太大

序列化后的二进制流大小能体现序列化的性能。序列化后的二进制数组越大，占用的存储空间就越多，存储硬件的成本就越高。如果我们是进行网络传输，则占用的带宽就更多，这时就会影响到系统的吞吐量。

Java 序列化实现的二进制编码完成的二进制数组大小，比 ByteBuffer 实现的二进制编码完成的二进制数组大小要大上几倍。因此，Java 序列后的流会变大，最终会影响到系统的吞吐量。

```
User user = new User();
user.setUserName("test");
user.setPassword("test");

ByteArrayOutputStream os =new ByteArrayOutputStream();
ObjectOutputStream out = new ObjectOutputStream(os);
out.writeObject(user);

byte[] testByte = os.toByteArray();
System.out.print("ObjectOutputStream 字节编码长度：" + testByte.length + "\n");
```

```
ByteBuffer byteBuffer = ByteBuffer.allocate( 2048);

byte[] userName = user.getUserName().getBytes();
byte[] password = user.getPassword().getBytes();
byteBuffer.putInt(userName.length);
byteBuffer.put(userName);
byteBuffer.putInt(password.length);
byteBuffer.put(password);

byteBuffer.flip();
byte[] bytes = new byte[byteBuffer.remaining()];
System.out.print("ByteBuffer 字节编码长度：" + bytes.length+ "\n");
```

ObjectOutputStream 字节编码长度：99

ByteBuffer 字节编码长度：16

④序列化性能太差

序列化的速度也是体现序列化性能的重要指标，如果序列化的速度慢，就会影响网络通信的效率，从而增加系统的响应时间。Java 序列化中的编码耗时要比 ByteBuffer 长很多

```
  User user = new User();
  user.setUserName("test");
  user.setPassword("test");
  
  long startTime = System.currentTimeMillis();
  
  for(int i=0; i<1000; i++) {
    ByteArrayOutputStream os =new ByteArrayOutputStream();
      ObjectOutputStream out = new ObjectOutputStream(os);
      out.writeObject(user);
      out.flush();
      out.close();
      byte[] testByte = os.toByteArray();
      os.close();
  }

  
  long endTime = System.currentTimeMillis();
  System.out.print("ObjectOutputStream 序列化时间：" + (endTime - startTime) + "\n");
```

```
long startTime1 = System.currentTimeMillis();
for(int i=0; i<1000; i++) {
ByteBuffer byteBuffer = ByteBuffer.allocate( 2048);

    byte[] userName = user.getUserName().getBytes();
    byte[] password = user.getPassword().getBytes();
    byteBuffer.putInt(userName.length);
    byteBuffer.put(userName);
    byteBuffer.putInt(password.length);
    byteBuffer.put(password);
    
    byteBuffer.flip();
    byte[] bytes = new byte[byteBuffer.remaining()];
}
long endTime1 = System.currentTimeMillis();
System.out.print("ByteBuffer 序列化时间：" + (endTime1 - startTime1)+ "\n");
```

ObjectOutputStream 序列化时间：29

ByteBuffer 序列化时间：6

(3)解决方案

目前业内优秀的序列化框架有很多，而且大部分都避免了 Java 默认序列化的一些缺陷。例如，最近几年比较流行的 FastJson、Kryo、Protobuf、Hessian 等。我们完全可以找一种替换掉 Java 序列化，推荐使用 Protobuf 序列化框架。

3.减少编码

Java 的编码运行比较慢，这是 Java 的一大硬伤。在很多场景下，只要涉及字符串的操作 （如输入输出操作、I/O 操作）都比较耗 CPU 资源，不管它是磁盘 I/O 还是网络 I/O，因 为都需要将字符转换成字节，而这个转换必须编码。 每个字符的编码都需要查表，而这种查表的操作非常耗资源，所以减少字符到字节或者相反 的转换、减少字符编码会非常有成效。减少编码就可以大大提升性能。 那么如何才能减少编码呢？例如，网页输出是可以直接进行流输出的，即用 resp.getOutputStream() 函数写数据，把一些静态的数据提前转化成字节，等到真正往外 写的时候再直接用 OutputStream() 函数写，就可以减少静态数据的编码转换。

  

二、多线程性能调优——降低锁竞争

- 互斥锁能够满足各类功能性要求，特别是被锁住的代码执行时间不可控时，它通过内核执行线程切换及时释放了资源，但它的性能消耗最大。
    
- 如果能够确定被锁住的代码取到锁后很快就能释放，应该使用更高效的自旋锁，它特别适合基于异步编程实现的高并发服务。
    
- 如果能区分出读写操作，读写锁就是第一选择，它允许多个读线程同时持有读锁，提高了并发性。读写锁是有倾向性的，读优先锁很高效，但容易让写线程饿死，而写优先锁会优先服务写线程，但对读线程亲和性差一些。还有一种公平读写锁，它通过把等待锁的线程排队，以略微牺牲性能的方式，保证了某种线程不会饿死，通用性更佳。另外，读写锁既可以使用互斥锁实现，也可以使用自旋锁实现，我们应根据场景来选择合适的实现。
    
- 当并发访问共享资源，冲突概率非常低的时候，可以选择无锁编程。然而，一旦冲突概率上升，就不适合使用它，因为它解决冲突的重试成本非常高。
    

1.深入了解Synchronized同步锁的优化方法

(1)自旋锁的关闭

在锁竞争不激烈且锁占用时间非常短的场景下，自旋锁可以提高系统性能。一旦锁竞争激烈或锁占用的时间过长，自旋锁将会导致大量的线程一直处于 CAS 重试状态，占用 CPU 资源，反而会增加系统性能开销。所以自旋锁和重量级锁的使用都要结合实际场景。在高负载、高并发的场景下，我们可以通过设置 JVM 参数来关闭自旋锁，优化系统性能，示例代码如下：

```
-XX:-UseSpinning //参数关闭自旋锁优化(默认打开) 
-XX:PreBlockSpin //参数修改默认的自旋次数。JDK1.7后，去掉此参数，由jvm控制
```

(2)减小锁粒度

当锁对象是一个数组或队列时，集中竞争一个对象的话会非常激烈，锁也会升级为重量级锁。我们可以考虑将一个数组和队列对象拆成多个小对象，来降低锁竞争，提升并行度。

最经典的减小锁粒度的案例就是 JDK1.8 之前实现的 ConcurrentHashMap 版本。我们知道，HashTable 是基于一个数组 + 链表实现的，所以在并发读写操作集合时，存在激烈的锁资源竞争，也因此性能会存在瓶颈。而 ConcurrentHashMap 就很很巧妙地使用了分段锁 Segment 来降低锁资源竞争。

①锁分离

与传统锁不同的是，读写锁实现了锁分离，也就是说读写锁是由“读锁”和“写锁”两个锁实现的，其规则是可以共享读，但只有一个写。

这样做的好处是，在多线程读的时候，读读是不互斥的，读写是互斥的，写写是互斥的。而传统的独占锁在没有区分读写锁的时候，读写操作一般是：读读互斥、读写互斥、写写互斥。所以在读远大于写的多线程场景中，锁分离避免了在高并发读情况下的资源竞争，从而避免了上下文切换。

②锁分段

在使用锁来保证集合或者大对象原子性时，可以考虑将锁对象进一步分解。例如 ConcurrentHashMap 就使用了锁分段。

(3)减少锁的持有时间

锁的持有时间越长，就意味着有越多的线程在等待该竞争资源释放。如果是 Synchronized 同步锁资源，就不仅是带来线程间的上下文切换，还有可能会增加进程间的上下文切换。

优化前

```
public synchronized void mySyncMethod(){  
        businesscode1();  
        mutextMethod();  
        businesscode2();
    }
```

优化后

```
public void mySyncMethod(){  
        businesscode1();  
        synchronized(this)
        {
            mutextMethod();  
        }
        businesscode2();
    }
```

  

(4)使用读写分离锁代替独占锁

使用ReadWriteLock读写分离锁可以提高系统性能, 使用读写分离 锁也是减小锁粒度的一种特殊情况. 第二条建议是能分割数据结构 实现减小锁的粒度,那么读写锁是对系统功能点的分割. 在多数情况下都允许多个线程同时读,在写的使用采用独占锁,在 读多写少的情况下,使用读写锁可以大大提高系统的并发能力

  

(5)粗锁化

为了保证多线程间的有效并发,会要求每个线程持有锁的时间尽 量短.但是凡事都有一个度,如果对同一个锁不断的进行请求,同步和 释放,也会消耗系统资源.如:

```
public void method1(){
    synchronized( lock ){
    同步代码块 1
    }
    synchronized( lock ){
    同步代码块 2
    }
}
```

JVM 在遇到一连串不断对同一个锁进行请求和释放操作时,会把所 有的锁整合成对锁的一次请求,从而减少对锁的请求次数,这个操作叫 锁的粗化,如上一段代码会整合为:

```
public void method1(){
    synchronized( lock ){
    同步代码块 1
    同步代码块 2
    }
}
```

在开发过程中,也应该有意识的在合理的场合进行锁的粗化,尤其 在循环体内请求锁时,如:

```
for(int i = 0 ; i< 100; i++){
	synchronized(lock){}
}
```

这种情况下,意味着每次循环都需要申请锁和释放锁,所以一种更 合理的做法就是在循环外请求一次锁,如:

```
synchronized( lock ){
	for(int i = 0 ; i< 100; i++){}
}
```

2.使用乐观锁

在读大于写的场景下，读写锁 ReentrantReadWriteLock、StampedLock 以及乐观锁的读写性能是最好的；在写大于读的场景下，乐观锁的性能是最好的，其它 4 种锁的性能则相差不多；在读和写差不多的场景下，两种读写锁以及乐观锁的性能要优于 Synchronized 和 ReentrantLock。

乐观锁虽然去除了锁操作，但是一旦发生冲突，重试的成本非常高。所以，只有在冲突概率 非常低，且加锁成本较高时，才考虑使用乐观锁。

3.减少上下文切换

(1)检测与避免

多线程的上下文切换会导致速度的损失。一般在单个逻辑比较简单，而且速度相对来非常快的情况下可以使用单线程。例如Redis，从内存中快速读取值，不用考虑 I/O 瓶颈带来的阻塞问题。而在逻辑相对来说很复杂的场景，等待时间相对较长又或者是需要大量计算的场景，建议使用多线程来提高系统的整体性能。例如，NIO 时期的文件读写操作、图像处理以及大数据分析等。

在 Linux 系统下，可以使用 Linux 内核提供的 vmstat 命令，来监视 Java 程序运行过程中系统的上下文切换频率，cs 如下图所示：

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOrGVkXL6Z7olduuJ50hWEIseajS1m1IgywV9EYsugCQnerwpCqibnhNA/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

如果是监视某个应用的上下文切换，就可以使用 pidstat 命令监控指定进程的 Context Switch 上下文切换。

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOh6Kzz5QdmsuGYe9FKkFjKf6EAyxibvj9uPjHEfekrZsIAuex2zw2HQg/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

(2)wait/notify 的使用导致了较多的上下文切换

4.合理地设置线程池大小，避免创建过多线程

线程池的线程数量设置不宜过大，因为一旦线程池的工作线程总数超过系统所拥有的处理器数量，就会导致过多的上下文切换。并且服务器CPU核数有限，能够同时并发的线程数有限。

还有一种情况就是，在有些创建线程池的方法里，线程数量设置不会直接暴露给我们。比如，用 Executors.newCachedThreadPool() 创建的线程池，该线程池会复用其内部空闲的线程来处理新提交的任务，如果没有，再创建新的线程（不受 MAX_VALUE 限制），这样的线程池如果碰到大量且耗时长的任务场景，就会创建非常多的工作线程，从而导致频繁的上下文切换。因此，这类线程池就只适合处理大量且耗时短的非阻塞任务。

N核服务器，通过执行业务的单线程分析出本地计算时间为x，等待时间为y，则工作线程数（线程池线程数）设置为 N*(x+y)/x，能让CPU的利用率最大化。

一般来说，非CPU密集型的业务（加解密、压缩解压缩、搜索排序等业务是CPU密集型的业务），瓶颈都在后端数据库访问或者RPC调用，本地CPU计算的时间很少，所以设置几十或者几百个工作线程是能够提升吞吐量的。

根据实际的测试发现，减少线程等待时间对提升性能的影响没有想象得那么大，它并不是线性的提升关系。 真正对性能有影响的是 CPU 的执行时间。这也很好理解，因为 CPU 的执行真正消耗了服务器的资源。经过实际的测试，如果减少 CPU 一半的执行时间，就可以增加一倍的 QPS。 也就是说，应该致力于减少 CPU 的执行时间。

5.使用协程实现非阻塞等待——协程不适合计算密集型的场景。协程适合I/O 阻塞型

(1)如何通过切换请求实现高并发？

我们知道，主机上资源有限，一颗 CPU、一块磁盘、一张网卡，如何同时服务上百个请求呢？多进程模式是最初的解决方案。内核把 CPU 的执行时间切分成许多时间片（timeslice），比如 1 秒钟可以切分为 100 个 10 毫秒的时间片，每个时间片再分发给不同的进程，通常，每个进程需要多个时间片才能完成一个请求。这样，虽然微观上，比如说就这 10 毫秒时间 CPU 只能执行一个进程，但宏观上 1 秒钟执行了 100 个时间片，于是每个时间片所属进程中的请求也得到了执行，这就实现了请求的并发执行。

不过，每个进程的内存空间都是独立的，这样用多进程实现并发就有两个缺点：一是内核的管理成本高，二是无法简单地通过内存同步数据，很不方便。于是，多线程模式就出现了，多线程模式通过共享内存地址空间，解决了这两个问题。然而，共享地址空间虽然可以方便地共享对象，但这也导致一个问题，那就是任何一个线程出错时，进程中的所有线程会跟着一起崩溃。这也是如 Nginx 等强调稳定性的服务坚持使用多进程模式的原因。事实上，无论基于多进程还是多线程，都难以实现高并发，这由两个原因所致。首先，单个线程消耗的内存过多，比如，64 位的 Linux 为每个线程的栈分配了 8MB 的内存，还预分配了 64MB 的内存作为堆内存池。所以，我们没有足够的内存去开启几万个线程实现并发。其次，切换请求是内核通过切换线程实现的，什么时候会切换线程呢？不只时间片用尽，当调用阻塞方法时，内核为了让 CPU 充分工作，也会切换到其他线程执行。一次上下文切换的成本在几十纳秒到几微秒间，当线程繁忙且数量众多时，这些切换会消耗绝大部分的 CPU 运算能力。

下图以上一讲介绍过的磁盘 IO 为例，描述了多线程中使用阻塞方法读磁盘，2 个线程间的切换方式。

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOAP8pTTlQysJlNR1OmMUA6lhrtHOLuvseRI04Y96sUXdNrrd1x7zn0w/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

那么，怎么才能实现高并发呢？把上图中本来由内核实现的请求切换工作，交由用户态的代码来完成就可以了，异步化编程通过应用层代码实现了请求切换，降低了切换成本和内存占用空间。异步化依赖于 IO 多路复用机制，比如 Linux 的 epoll 或者 Windows 上的 iocp，同时，必须把阻塞方法更改为非阻塞方法，才能避免内核切换带来的巨大消耗。Nginx、Redis 等高性能服务都依赖异步化实现了百万量级的并发。下图描述了异步 IO 的非阻塞读和异步框架结合后，是如何切换请求的。

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOQOw9YA0IBeibG3RzXLymO90Y4JQSyopx23OSnbhFkvjypdibNTyntXtg/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

然而，写异步化代码很容易出错。因为所有阻塞函数，都需要通过非阻塞的系统调用拆分成两个函数。虽然这两个函数共同完成一个功能，但调用方式却不同。第一个函数由你显式调用，第二个函数则由多路复用机制调用。这种方式违反了软件工程的内聚性原则，函数间同步数据也更复杂。特别是条件分支众多、涉及大量系统调用时，异步化的改造工作会非常困难。有没有办法既享受到异步化带来的高并发，又可以使用阻塞函数写同步化代码呢？协程可以做到，它在异步化之上包了一层外衣，兼顾了开发效率与运行效率。

(2)协程是如何实现高并发的？

协程与异步编程相似的地方在于，它们必须使用非阻塞的系统调用与内核交互，把切换请求的权力牢牢掌握在用户态的代码中。但不同的地方在于，协程把异步化中的两段函数，封装为一个阻塞的协程函数。这个函数执行时，会使调用它的协程无感知地放弃执行权，由协程框架切换到其他就绪的协程继续执行。当这个函数的结果满足后，协程框架再选择合适的时机，切换回它所在的协程继续执行。如下图所示：

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOjFNxKj8Y7fPiczRyuBpMNTuu1476Jd1pUwGW8ZYzFInUxgOBwsApwdA/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

看起来非常棒，然而，异步化是通过回调函数来完成请求切换的，业务逻辑与并发实现关联在一起，很容易出错。协程不需要什么“回调函数”，它允许用户调用“阻塞的”协程方法，用同步编程方式写业务逻辑。那协程的切换是如何完成的呢？

实际上，用户态的代码切换协程，与内核切换线程的原理是一样的。内核通过管理 CPU 的寄存器来切换线程，我们以最重要的栈寄存器和指令寄存器为例，看看协程切换时如何切换程序指令与内存。每个线程有独立的栈，而栈既保留了变量的值，也保留了函数的调用关系、参数和返回值，CPU 中的栈寄存器 SP 指向了当前线程的栈，而指令寄存器 IP 保存着下一条要执行的指令地址。因此，从线程 1 切换到线程 2 时，首先要把 SP、IP 寄存器的值为线程 1 保存下来，再从内存中找出线程 2 上一次切换前保存好的寄存器值，写入 CPU 的寄存器，这样就完成了线程切换。（其他寄存器也需要管理、替换，原理与此相同，不再赘述。）协程的切换与此相同，只是把内核的工作转移到协程框架实现而已，下图是协程切换前的状态：

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOPhzpQP5kqH0CfUn2YOyrsOBuJAgvTXwHwicmV6z46GiaXIR7v17J2rJQ/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

从协程 1 切换到协程 2 后的状态如下图所示：

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOpm4egDs6W2RBV5r6g9NF9td7wx2pLqF5V72pmEibRMqHib57UBhQ4tdQ/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

创建协程时，会从进程的堆中分配一段内存作为协程的栈。线程的栈有 8MB(太大，导致单机无法实现高并发的原因)，而协程栈的大小通常只有几十 KB。而且，C 库内存池也不会为协程预分配内存，它感知不到协程的存在。这样，更低的内存占用空间为高并发提供了保证，毕竟十万并发请求，就意味着 10 万个协程。当然，栈缩小后，就尽量不要使用递归函数，也不能在栈中申请过多的内存，这是实现高并发必须付出的代价。

由此可见，协程就是用户态的线程。然而，为了保证所有切换都在用户态进行，协程必须重新封装所有的阻塞系统调用，否则，一旦协程触发了线程切换，会导致这个线程进入休眠状态，进而其上的所有协程都得不到执行。比如，普通的 sleep 函数会让当前线程休眠，由内核来唤醒线程，而协程化改造后，sleep 只会让当前协程休眠，由协程框架在指定时间后唤醒协程。再比如，线程间的互斥锁是使用信号量实现的，而信号量也会导致线程休眠，协程化改造互斥锁后，同样由框架来协调、同步各协程的执行。

所以，协程的高性能，建立在切换必须由用户态代码完成之上，这要求协程生态是完整的，要尽量覆盖常见的组件。比如 MySQL 官方提供的客户端 SDK，它使用了阻塞 socket 做网络访问，会导致线程休眠，必须用非阻塞 socket 把 SDK 改造为协程函数后，才能在协程中使用。当然，并不是所有的函数都能用协程改造。比如提到的异步 IO，它虽然是非阻塞的，但无法使用 PageCache，降低了系统吞吐量。如果使用缓存 IO 读文件，在没有命中 PageCache 时是可能发生阻塞的。这种时候，如果对性能有更高的要求，就需要把线程与协程结合起来用，把可能阻塞的操作放在线程中执行，通过生产者 / 消费者模型与协程配合工作。实际上，面对多核系统，也需要协程与线程配合工作。因为协程的载体是线程，而一个线程同一时间只能使用一颗 CPU，所以通过开启更多的线程，将所有协程分布在这些线程中，就能充分使用 CPU 资源。

除此之外，为了让协程获得更多的 CPU 时间，还可以设置所在线程的优先级，比如 Linux 下把线程的优先级设置到 -20，就可以每次获得更长的时间片。另外，为了减少 CPU 缓存失效的比例，还可以把线程绑定到某个 CPU 上，增加协程执行时命中 CPU 缓存的机率。虽然这一讲中谈到协程框架在调度协程，然而，你会发现，很多协程库只提供了创建、挂起、恢复执行等基本方法，并没有协程框架的存在，需要业务代码自行调度协程。这是因为，这些通用的协程库并不是专为服务器设计的。服务器中可以由客户端网络连接的建立，驱动着创建出协程，同时伴随着请求的结束而终止。在协程的运行条件不满足时，多路复用框架会将它挂起，并根据优先级策略选择另一个协程执行。因此，使用协程实现服务器端的高并发服务时，并不只是选择协程库，还要从其生态中找到结合 IO 多路复用的协程框架，这样可以加快开发速度。

6.识别不同场景下最优容器

![图片](https://mmbiz.qpic.cn/mmbiz_png/0O5aBQ3QT8dcPga2FCFNag2TKHOOC0iaOYxOqB408SVwy54Ts78jibJ0IufzS55wZLer1pI63OlBcFjjCnuVq2GA/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

7.串行变并行

串行的逻辑，在没有依赖限制的情况下，可以并行执行。后端的逻辑如果需 要执行多项操作，那么如果没有依赖，或者依赖项满足的情况下，可以立即执行，而不必一 个一个挨个等待依次完成。Spring 的@Async 注解，可以比较方便地将普通的 Java 方 法调用变成异步进行的，用这种方法可以同时执行数个互不依赖的方法。

8.避免使用多线程

业务中使用多线程（有别于Tomcat这种容器中间件）是为了提高并发能力，或者是异步化业务能力。而这两种都有其他的方案来替代。比如高并发，我们可能会进行一些拆分操作，比如异步化消息队列，会使用消息队列等。尽量不使用多线程，除非是必须
