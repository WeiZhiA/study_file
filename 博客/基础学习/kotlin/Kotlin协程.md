Kotlin协程

进程是应用程序的副本，向操作系统申请资源的最小单位。
线程是操作系统分配执行任务的最小单位。
线程池：为了解决多io的场景，一个任务使用一个线程，但是任务切换也需要时间，中断->存储->切换->加载cpu->恢复另外一个线程，如果任务很小就不划算了

协程：就是线程框架。
高io任务很小的场景，轻量级的线程。一个任务对应一个协程，所有的协程使用少量的线程。协程切换是程序员自己的行为，路线短，不会主动触发线程切换，没有中断，所有协程效率高。

挂起函数：将代码切到另外一个线程去执行，之所以要在协程里执行，挂起是协程完成的，执行完，也需要协程切回原来的线程。

# 简介
协程基于线程，是轻量级的线程。线程框架。

线程Thread：操作系统的线程，也称为内核线程。
协程：coroutine，有语言实现的，运行在内核线程上。



好处：在同一个代码块中多次切回。
需要协程的时候：切线程，或者指定线程执行。
实现轻量级并发，提高系统资源利用率。

# 使用
launch或async启动一个协程。

```kt

//默认开启一个工作线程
val async1 = launch { delay1() }

//开启子线程的情况下
//不阻塞的执行
val async1 = launch { delay1() }

//只有它结束，runBlocking才会执行结束
//此时已经开始执行
val async2 = async { delay1() }
//如果async2没有执行完，开阻塞，直到执行完。
//如果不调用，和launch一样，不阻塞的执行
job2.await()

```

区别：
* launch返回一个Job并且不携带任何结果值
* async 构建器可启动新协程并允许您使用一个名为 await 的挂起函数返回 result。

suspend:非阻塞式挂起，不会影响线程。本质还是切线程，因此当前线程不会阻塞。
阻塞分两种：1.IO 2.CPU计算。

协程的方法
1.repeat():重复执行。类型java的线程池
2.delay():类似java的Executor.newSingleThreadScheduledExcutor()



# 挂起和恢复
suspend-挂起或暂停，用于暂停当前协程，并保存局部变量。
resume:将暂停的协程从暂停处恢复

使用suspend修饰的是挂起函数。
挂起函数只能在协程体内，或其他协程函数内使用。

suppent:只是声明有挂起操作。声明该方法只能在协程中调用。  
只有在withContext(Dispatch.io)内的代码块，才是真正被挂起了。

```kt
//父协程挂起
GlobalScope.launch(Dispatchers.Main) { 
    //耗时操作
    getUser
}

private suspend fun getUser(){
    val user =get();
    //主线程中执行
    textview.setText("")
}

private suspend fun get() = withContext(Dispatchers.IO){
    //网络请求
}



GlobalScope.launch(Dispatchers.Main) { 
    //挂起，遇到耗时操作，会挂起，不会影响主线程执行
    Thread.sleep(12000)
}
//阻塞，会影响主线程
Thread.sleep(12000)
```

NIO:非阻塞IO

## 调度器
所有的协程都必须在调度器上运行，即使主线程函数也不例外。
调度器 | 说明
---|---
Dispatchers.Main | android主线程，例如，调用suspend函数，主线程操作
Dispathers.IO | 磁盘/网络io，例如数据库操作，文件读写，网络请求
Dispatcher.Default | CPU密集型任务，计算。例如数组排序，Json数据解析，处理差异

## 任务泄漏
指某个协程任务丢失或不能追踪，类似内存泄漏。但比内存泄漏更严重，泄漏协程会浪费内存、CPU、磁盘资源，甚至发送一个无用的网络请求。。  
例如activity已经销毁，但是还在进行网络请求。  
解决：Kotlin引入了<font color="#dd0000">结构化并发机制</font>
* 取消任务：  
* 追踪任务：  
* 发出错误信号：协程出错时，发出错误通知。

## CoroutineScope
结构化并发机制.
在 Kotlin 中，定义协程必须指定其 CoroutineScope. 可以追踪所有协程，并且可以取消由他启动的所有携程。

全局的GlobalScope是一个作用域,每个协程自身也是一个作用域.
* 父作用域的生命周期持续到所有子作用域执行完；
* 当结束父作用域结束时，同时结束它的各个子作用域；
* 子作用域未捕获到的异常将不会被重新抛出，而是一级一级向父作用域传递，这种异常传播将导致父父作用域失败，进而导致其子作用域的所有请求被取消。



常用api
api | 说明
---|---
GlobalScope | 声明周期process级别，计算activity/fragment销毁，它依然存在
MainScope | acitivty中使用,可以在onDestroy取消。
viewModelScope | 只能在viewModel中使用，绑定viewModel声明周期
lifecycleScope | 只能在activity/fragment中使用，绑定acitiivty/fragment声明周期


```kt
//工厂模式
MainScope().launch {
//进行网络请求，如果是
    networkRequest()
}
//suspend 挂起函数，协程自动启用异步线程
private suspend fun networkRequest(){

}
//取消协程
MainScope.cancle()
```


by关键字
```kt
//类只能单继承，但是通过接口+委托，实现多继承;by委托
class MainActivity : BaseActivity(),CoroutineScope by MainScope() {
}
```
withContext使用
```kt
import androidx.lifecycle.viewModelScope

//viewModelScope 使用异步请求网络
viewModelScope.launch {
    liveData.value = withContext(Dispather){
        requestData()
    }
}


<!-- 在IO线程中执行 -->
viewModelScope.launch(Dispatchers.IO) {
    //处理 Repository 层可能抛出的异常
    val result = try {
        oginRepository.makeLoginRequest(jsonBody)
    } catch(e: Exception) {
        Result.Error(Exception("Network request failed"))
    }
}
//挂起协程，直到完成
suspend fun makeLoginRequest(
        jsonBody: String
    ): Result<LoginResponse> {
        //挂起函数，和withContext一样
        delay(10)
}
```


# 处理异常
```kt
fun loadProjectTree() {
    viewModelScope.launch() {
        try {
            //子协程
            launch {
                //失败的接口
                service.loadProjectTreeError()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
```
tryCatch无法捕捉异常

## CoroutineExceptionHandler
用于全局“捕获所有”行为的最后一种机制。也可以从异常中恢复。但父协程依然会失败。
原理：异常一步一步传递到父携程，然后在父协程将异常移交给CoroutineExceptionHandler处理。
当处理程序被调用时，协程已经完成了相应的异常。  
通常，该处理程序用于记录异常、显示某种错误消息、终止和/或重新启动应用程序。

缺点：  
作用在于全局捕获异常，子协程出现异常，父协程和其兄弟协程也都会跟着执行失败。


使用
```kt
private val exceptionHandler = CoroutineExceptionHandler { _, exception ->
    Log.d(TAG, "CoroutineExceptionHandler exception : ${exception.message}")
}

fun loadProjectTree() {
    viewModelScope.launch(exceptionHandler) {
        //失败的接口
        service.loadProjectTreeError()
    }
}

```

## 常用方法
```kt
//阻塞所在的线程,因此在main或测试代码中用的多
//只有构成父子关系，才能影响它。
runBlocking(){
    //外界无感的，很有可能还没执行完，外部就关闭了
    //不能和runBlocking构成父子关系
    GlobalScope.lauch{
        delay(200)
    }   
    //只有它结束，runBlocking才会执行结束
    val job = lauch{
        delay(200)
    }  

    //只有它结束，runBlocking才会执行结束
    //此时已经开始执行
    val job2 = async{
        delay(200)
    }
    //如果job2没有执行完，开阻塞，直到执行完。
    job2.await()
    delay(200)
}
//或者
fun main = runBlocking(){
    delay(200)
}

//外界无感的，很有可能还没执行完，外部就关闭了
GlobalScope.lauch{
    delay(200)
}

```

## SupervisorScope+async
该作用域与async结合开启协程时，子协程出现了异常，并不会影响其父协程以及其兄弟协程。所以更适合多个并行任务的执行。
```kt
viewModelScope.launch() {
            supervisorScope {
                try {
                    //除数为0，抛异常
                    val deferredFail = async { 2 / 0 }
                    //成功
                    val deferred = async {
                        2 / 1
                        Log.d(TAG, "loadProjectTree:  2/1 ")
                    }
                    deferredFail.await()
                    deferred.await()

                } catch (e: Exception) {
                    Log.d(TAG, "loadProjectTree:Exception ${e.message} ")
                }
            }
        }
```

## 总结
* 在代码的特定部分处理异常，可使用try-catch。
* 全局捕获异常，并且其中一个任务异常，其他任务不执行，可使用CoroutineExceptionHandler，节省资源消耗。
* 并行任务间互不干扰，任何一个任务失败，其他任务照常运行，可使用SupervisorScope+async模式。





