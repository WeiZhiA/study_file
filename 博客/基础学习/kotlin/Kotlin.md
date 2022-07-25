Kotlin

# 使用中
1.类型推断
编译器编译时自动补全，并不是可以随意赋值

2.kotlin中或者和设置都是调用set/get方法

* IntArray：可以防止装箱

* compose object 等于 object aa{}

* 主构造函数参数的用处
```kt
//主构造函数其实是传值入口，会在内部自动创建同名的age
class User(name:String, val age:Int){
    var user = user;
    init{
        this.user = user
    }

    //所有的次级构造函数都要有这个
    constract(name:String){}

    //函数便捷写法
    fun say(word:String="hello") = print(word)

    //用于数数
    val rang = 1..6
    //用于流式控制
    val sequenece = sequeneceof(-1,0,1,2,3,4,5)
    
}
```

# 泛型
out = extends 子类可以赋值给父类
in = super 父类可以赋值给子类

* java:因为类型擦出的原因，不能将子类泛型集合赋值给父类的集合。
List<TextView> list = new ArrayList<Buttom>()报错.  
而数组没有类型擦出，因此可以这样写。
* instance  
  java中不允许在泛型中使用。例如：a instance T


## java

解决
```java
//但是之后只能使用原生，不能添加原始。
List<? entends TextView> list = new ArrayList<Buttom>()  

//但是之后添加，不能获取原始
List<? entends TextView> list = new ArrayList<View>()  


//设置多个上界
class Monster<T extends Animal & Foot>
```

java中的*表示没有上界，也没有下界
单独的?等于<? extends object>

## kotlin
```kt
//只能输出，不能输入
interface Productor<out T>{
    fun productor()
}

//只能输入，不能输出
interface Consumor<in T>{
    fun consume(T t)
}

//设置多个上界
class Monster<T> where T: Animal, T:Food{

}


//可以用reified解除 is限制,同时要加inline
inline fun <refied T> test(){
    if(item is T){

    }
}

```

kotlin中的*相当于java中的<?>, ?符号在kotlin中不存在

# lambda表达式
双冒号+函数名，匿名函数，Lambda表达式，在kt中都是对象，和java8不一样

函数能作为参数传递，本质是函数可以当作对象.
如果加了::,则函数就被作为对象，函数类型的对象。被调用其实是调用了的b.invoke()。  
指向的是和函数等价的对象。

```kt
<!-- 作为参数 -->
var aField = (Int)->String

<!-- 函数赋值给属性 -->
//b不是对象，因此要加::(函数引用),
val bField = ::b
//bField是对象，因此不用加::
val cField = bField

<!-- 其他写法 -->
a(fun b():(Int)->String{})

val bField = fun b():(Int)->String{}

<!-- 此时后面的函数，是匿名函数 -->
val bField = fun ():(Int)->String{}

<!-- 作为参数传入 -->
fun a(funParam: (Int)->String){
    funParam(1)
}

<!-- 作为返回值，返回 -->
fun b():(Int)->String{
    
}

```

安卓中的使用
```kt
<!-- 定义 -->
fun setOnClickListener(onClick:(View)->Unit){

}
<!-- 使用 -->
fun setOnClickListener(fun(v:View){

});

fun setOnClickListener({ v->

});

<!-- 如果是最后一个参数 -->
fun setOnClickListener(){ v->
};

<!-- 只有lambda表达式 -->
fun setOnClickListener{ v->
};

//之所以可以无限简写，因为定义的时候写清楚类型了
<!-- 只有lambda表达式，且单参数 -->
fun setOnClickListener{ 
};

//如果作为定义,类型不能省略
val d = fun(param:Int):String{}

val d = {param:Int-> return "a" }

//如果return，则把return “a”作为外层返回类型
val d: (Int)->String = {param -> "a" }

//匿名函数不是函数是个对象，因此可以赋值，传递。等价于::b

val a = { it.print("a") }
val d = { param:Int -> param.toString() }
```

```java
// java8
setOnClickListener(v-{

}
)

//kt
setOnClickListener{

}
```

# 扩展方法
属于Top Leval Function，只属于package，限制了只有某个类才能调用。
如果写在了类里面，即使类的成员函数，又是前缀的扩展函数。  为了防止歧义，kotlin不允许我们引用，即时成员函数，又是扩展函数的函数。  

扩展函数的使用
```kt
<!-- 1.直接使用 -->
(String::method1)("134",12)
String::method1.invoke("123",12)
"123".medthod1(12)

<!-- 2.扩展函数赋值 -->
val a:String.(Int)->Unit = String::method1
val b:(String::Int)->Unit = String::method1

val a:String.(Int)->Unit = b


val a:String.(Int)->Unit = ::C //非扩展函数赋值给有扩展函数引用

//也可以把，扩展函数赋值，给非扩展函数引用。一般不这样用。

//使用
"reng".a(1)
a("reng",1)
a.invoke("reng",1)

```

# Hint
依赖注入：类中的属性叫依赖，外部帮助初始化叫注入。
例如工厂模式，建造者模式。而dagger是为依赖注入提供更简单的方式。

