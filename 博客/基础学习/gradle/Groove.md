Groove

<!-- TOC -->

- [1.简介](#1简介)
- [2.用法](#2用法)
- [3.系统默认引入的库](#3系统默认引入的库)
- [4.关键字](#4关键字)
- [5.总结](#5总结)

<!-- /TOC -->

# 1.简介
它的语法和 Java 非常的相似，它的文件也是可以编译为 .class 文件，而且可以使用 Java 的类库

# 2.用法
```gradle
/**************** 定义变量 def ******************/
//类似于kotlin的val
//定义变量
def i = 5;
println(i.class) //class java.lang.Integer
//定义一个字符串
def _name = "Groovy语言基础" 
println(_name.class) //class java.lang.String

/**************** 引入包 import ******************/
import groovy.xml.MarkupBuilder 
def newXml = new MarkupBuilder()

/********** 注释和分号 ***************/
//这是单行注释
/** 这是
 *  多行
 *  注释**/

/********** 字符串 String ***************/
在 Java 中我们用单引号（’’）来表示 char，用双引号（""）
String a = '单引号'; 
String b = "双引号"; 
//多行字符串也可以用三引号
String c = '''这是三引号
    自动换行
    自动换行''';

/**************** 插值字符串 GString ***************/
def a = 'Gradle专题'; 
def b = "${a} Groovy语言基础";

/**************** 方法 *********************/
//和java基本一样
//返回值可以用def定义，也可以使用 public，static,private等修饰

class Example { 
   static void main(String[] args) { 
     def i = 3;
     println("befor add(i): "+ i);
     i=add(i);
     println("after add(i): "+i);
   } 
   static def add(int a) {
     ++a;
     return a;
   };
}

/**************** 逻辑控制 ***************/
//分为3中呢
//顺序执行： 就是按顺序一步步执行。
//条件判断： 这个就是我们 Java 中的if/else和switch/case。
//循环语句： 跟 Java 中一样还是while和for.

//if和while和java一样
//for和swift 进行了扩展
/*----  swift ------*/
static void main(String[] args) { 
 def x = 0.98
 //def x = 3
 def result
 switch (x){
 case [4,5,6,'Gradle']:   //列表
     result = 'list'
     break
 case 3..11:
     result = 'range'     //范围
     break
 case Integer:
     result = 'Integer'   //类型
     break
 case BigDecimal:
     result = 'BigDecimal'//类型
     break
 default:
     result = 'default'
     break
 }

/*----  for ------*/
//0到100
for (i in 0..100){
    sum += i
}

for (i in [1,2,3,4,5,6,7,8,9,10]){
    sumList += i
}

for (i in ['张三':21,'李四':25,'王五':36]){
    sumMap += i.value
    println i.key
}

/**************** 闭包 ***************/
/*----  无参构造 ------*/
//1 定义一个闭包
def closer = {
    println "Gradle专题之Groovy语法"
}

//或者
closer{
    println "Gradle专题之Groovy语法"
}
//2 闭包的两种调用方式
closer.call()
closer()

/*----  有参构造 ------*/
def closer = {
   String name -> println "${name}专题之Groovy语法"
}
closer.call('Gradle')

/**************** 文件读取 ***************/
def filePath = "D:/groovy.txt"
def file = new File(filePath) ;
/*----  遍历打印 ------*/
file.eachLine {
    println it
}
/*----  简洁写法 ------*/
println file.text

/**************** 文件写入 ***************/
file.withPrintWriter {
    it.println("Gradle专题")
    it.println("Groovy语言")
    it.println("文件写入")
}

/**************** 数据结构 ***************/
//列表，范围，映射
/*----  列表（List） ------*/
//对应的是Java的ArrayList
def list2 = []          //定义一个空的列表
def list3 = [1,2,3,4]   //定义一个非空的列表

/*----  数组 ------*/
//as关键字定义数组
def array = [1,2,3,4] as int[]
//或者使用强类型的定义方式
int[] array2 = [1,2,3]

/*----  范围（Range） ------*/
//范围的定义
def range = 1..15
println ("第一个元素的值:"+range[0])

/*----  映射（MAP） ------*/
//Groovy 中定义映射 (MAP) 和 List 类似使用[]并且要指明它的键 （key）和值 （value），默认的实现类为java.util.LinkedHashMap.

//1.定义
def swordsman = [one:'张三丰',two:'金毛狮王谢逊',three:'张无忌']
//2.获取value
println swordsman['one']
println swordsman.get('two')
println swordsman.three

//3 添加元素
swordsman.four = '成坤'
println 

//4 添加一个map
swordsman.five = [a:1,b:2]
println swordsman
```

# 3.系统默认引入的库
```java
import java.lang.*
import java.util.*
import java.io.*
import java.net.*

import groovy.lang.*
import groovy.util.*

import java.math.BigInteger
import java.math.BigDecimal
```

# 4.关键字
```
as	assert	break	case	enum	extends
catch	class	const	continue	false	Finally
def	default	do	else	for	goto
import	in	instanceof	interface	if	implements
new	pull	package	return	throws	trait
super	switch	this	throw	true	try
while					
```

# 5.总结
Groovy 的语法和 Java 非常相似；
Groovy 中定义变量可以使用def系统会自动帮我们转换为具体类型；
定义基本数据类型时不需要导包，Groovy 系统包含那些包；
Groovy 的字符串可以用，单引号，双引号，三引号。换可以支持字符串的插值；
Groovy 的方法跟 Java 一样不能定义在方法内部；
Groovy 的switch/case支持任意类型的判断；
Groovy 的for支持列表，范围和映射的遍历；
Groovy 的闭包灵活且强大建议使用第一种方式调用；
Groovy 的数组使用as关键字定义；
Groovy 的映射必须指明键和值。



