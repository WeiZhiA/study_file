Annotation [ˌænəˈteɪʃən] : 注解

<!-- TOC -->

- [1.注解介绍](#1注解介绍)
- [2.自定义注解Annonation](#2自定义注解annonation)
  - [总结](#总结)
- [3.注解常用方法](#3注解常用方法)
- [4.实例](#4实例)
  - [1.读取Class的注解](#1读取class的注解)
  - [2.读取方法/字段/构造方法](#2读取方法字段构造方法)
  - [总结](#总结-1)
- [补充](#补充)

<!-- /TOC -->

# 1.注解介绍
* 什么是注解（Annotation）
  * 注解是放在Java源码的类、方法、字段、参数前的一种特殊“注释”  
  * 注释会被编译器直接忽略；注解则可以被编译器打包进入class文件，因此，注解是一种用作标注的“元数据”。
  * 从JVM的角度看，注解本身对代码逻辑没有任何影响，如何使用注解完全由工具决定。
* 注解的作用
  注解的分类
  * 1.编译器使用的注解  
  ```java
   @Override  //让编译器检查该方法是否正确地实现了覆写
   @SuppressWarnings //告诉编译器忽略此处代码产生的警告
  ```
   这类注解不会被编译进入.class文件，它们在编译后就被编译器扔掉了。
  * 2.工具处理.class文件使用的注解  
    比如有些工具会在加载class的时候，对class做动态修改，实现一些特殊的功能。这类注解会被编译进入.class文件，但加载结束后并不会存在于内存中。这类注解只被一些底层库使用，一般我们不必自己处理。
  * 程序运行期能够读取的注解  
    它们在加载后一直存在于JVM中，这也是最常用的注解。例如，一个配置了@PostConstruct的方法会在调用构造方法后自动被调用（这是Java代码读取该注解实现的功能，JVM并不会识别该注解）。

* 注解配置的参数
  * 所有基本类型；  
  * String；  
  * 枚举类型；  
  * 基本类型、String、Class以及枚举的数组。  

  因为配置参数必须是常量，所以，上述限制保证了注解在定义时就已经确定了每个参数的值。  
  注解的配置参数可以有默认值，缺少某个配置参数时将使用默认值。

```java
public class Hello {
    @Check(min=0, max=100, value=55)
    public int n;

    @Check(value=99)
    public int p;

    @Check(99) // @Check(value=99)
    public int x;

    @Check
    public int y;

    public void loginOut(@IntRange(from = USER_OUT, to = FORCE_OUT) type: Long)
}
```
* 总结  
注解（Annotation）是Java语言用于工具处理的标注：  
注解可以配置参数，没有指定配置的参数使用默认值；  
如果参数名称是value，且只有一个参数，那么可以省略参数名称。  

# 2.自定义注解Annonation

* 定义注解  
  注解的参数类似无参数方法，可以用default设定一个默认值（强烈推荐）。最常用的参数应当命名为value。   
```java
public @interface Report {
    int type() default 0;
    String level() default "info";
    String value() default "";
}
```    

```java
Report report = cls.getAnnotation(Report.class);
if (report != null) {
   ...
}
```

* 元注解  
有一些注解可以修饰其他注解，这些注解就称为元注解（meta annotation）。Java标准库已经定义了一些元注解，我们只需要使用元注解，通常不需要自己去编写元注解。

  * @Target 
使用@Target可以定义Annotation能够被应用于源码的哪些位置：

```java
ElementType.TYPE； //类或接口
ElementType.FIELD；//字段：
ElementType.METHOD；//方法
ElementType.CONSTRUCTOR；//构造方法
ElementType.PARAMETER。//方法参数
```
举例：定义注解@Report可用在方法/属性上
```java
//@Target(ElementType.METHOD)
@Target({
    ElementType.METHOD,
    ElementType.FIELD
})
public @interface Report {
    int type() default 0;
    String level() default "info";
    String value() default "";
}
```
 * @Retention
   * 仅编译期：RetentionPolicy.SOURCE；
   * 仅class文件：RetentionPolicy.CLASS；默认
   * 运行期：RetentionPolicy.RUNTIME。
   
   如果@Retention不存在，则该Annotation默认为CLASS

* @Repeatable  
  @Repeatable这个元注解可以定义Annotation是否可重复，应用不是特别广泛

  声明
```java
@Repeatable(Reports.class)
@Target(ElementType.TYPE)
public @interface Report {
    int type() default 0;
    String level() default "info";
    String value() default "";
}

@Target(ElementType.TYPE)
public @interface Reports {
    Report[] value();
}
```

使用
```java
@Report(type=1, level="debug")
@Report(type=2, level="warning")
public class Hello {
}
```
* @Inherited  
@Inherited定义子类是否可继承父类定义的Annotation。    
@Inherited仅针对@Target(ElementType.TYPE)类型的annotation有效，并且仅针对class的继承，对interface的继承无效：
```java
@Inherited
@Target(ElementType.TYPE)
public @interface Report {
    int type() default 0;
    String level() default "info";
    String value() default "";
}
```

```java
@Report(type=1)
public class Person {
}
//子类默认也定义了该注解
public class Student extends Person {
}
```



举例
```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Report {
    int type() default 0;
    String level() default "info";
    String value() default "";
}
```
## 总结
Java使用@interface定义注解：  
可定义多个参数和默认值，核心参数使用value名称；  
必须设置@Target来指定Annotation可以应用的范围；  
应当设置@Retention(RetentionPolicy.RUNTIME)便于运行期读取该Annotation。

# 3.注解常用方法
* 基本概念  
SOURCE类型的注解主要由编译器使用，因此我们一般只使用，不编写。CLASS类型的注解主要由底层工具库使用，涉及到class的加载，一般我们很少用到。只有RUNTIME类型的注解不但要使用，还经常需要编写。因此，只讨论如何读取RUNTIME类型的注解。

因为注解定义后也是一种class，所有的注解都继承自java.lang.annotation.Annotation，因此，读取注解，需要使用反射API。

* 常用方法
  * 判断某个注解是否存在于Class、Field、Method或Constructor 
```java
Class.isAnnotationPresent(Class)
Field.isAnnotationPresent(Class)
Method.isAnnotationPresent(Class)
Constructor.isAnnotationPresent(Class)
```

```java
// 判断@Report是否存在于Person类:
Person.class.isAnnotationPresent(Report.class);
```

 * 反射API读取Annotation
```java
Class.getAnnotation(Class)
Field.getAnnotation(Class)
Method.getAnnotation(Class)
Constructor.getAnnotation(Class)
```

# 4.实例
## 1.读取Class的注解

```java
// 获取Person定义的@Report注解:
Report report = Person.class.getAnnotation(Report.class);
int type = report.type();
String level = report.level();
```
反射API读取Annotation有两种方法  
* 1.先判断Annotation是否存在
```java
Class cls = Person.class;
if (cls.isAnnotationPresent(Report.class)) {
    Report report = cls.getAnnotation(Report.class);
    ...
}
```
* 2.直接读取Annotation
```java
Class cls = Person.class;
Report report = cls.getAnnotation(Report.class);
if (report != null) {
   ...
}
```
## 2.读取方法/字段/构造方法
方法参数本身可以看成一个数组，而每个参数又可以定义多个注解，所以，一次获取方法参数的所有注解就必须用一个二维数组来表示。  
例如，对于以下方法定义的注解：
```java
public void hello(@NotNull @Range(max=5) String name, @NotNull String prefix) {}
```

读取方法参数的注解

```java
// 获取Method实例:
Method m = ...
// 获取所有参数的Annotation:
Annotation[][] annos = m.getParameterAnnotations();
// 第一个参数（索引为0）的所有Annotation:
Annotation[] annosOfName = annos[0];
for (Annotation anno : annosOfName) {
    if (anno instanceof Range) { // @Range注解
        Range r = (Range) anno;
    }
    if (anno instanceof NotNull) { // @NotNull注解
        NotNull n = (NotNull) anno;
    }
}
```

```java
static void check(Person person) throws IllegalArgumentException, ReflectiveOperationException {
	for (Field field : person.getClass().getFields()) {
		Range range = field.getAnnotation(Range.class);
		if (range != null) {
			Object value = field.get(person);
			// TODO:
		}
	}
}
```

## 总结
* 可以在运行期通过反射读取RUNTIME类型的注解，注意千万不要漏写@Retention(RetentionPolicy.RUNTIME)，否则运行期无法读取到该注解。  
* 可以通过程序处理注解来实现相应的功能：  
* 对JavaBean的属性值按规则进行检查；  
* JUnit会自动运行@Test标记的测试方法。


# 补充
@Keep不被混淆
升级androidx注意点  
https://blog.csdn.net/wangyun522/article/details/103940690