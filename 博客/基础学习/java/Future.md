Future

Callable [ˈkɔːləbəl]

<!-- TOC -->

- [1.Future](#1future)
    - [1.1实现线程的方式](#11实现线程的方式)
- [2.CompletableFuture](#2completablefuture)

<!-- /TOC -->

# 1.Future
## 1.1实现线程的方式
* 1.Runnable
  缺点：没有返回值
* 2.Callable
    1.可以返回指定类型的结果
    2.future.get()可能被阻塞
```java
class CallableImp implements Callable<String> {
    public String call() throws Exception {
        return ""
    }
}
```

使用
```java
ExecutorService executor = Executors.newFixedThreadPool(4); 
// 定义任务:
Callable<String> task = new Task();
// 提交任务并获得Future:
Future<String> future = executor.submit(task);
// 从Future获取异步执行返回的结果:
// 可能阻塞
String result = future.get(); 
```
Futere常用方法  

----
方法名 | 作用
---- | ---
get() | 获取结果（可能会等待）
get(long timeout, TimeUnit unit) | 获取结果，但只等待指定的时间；
cancel(boolean mayInterruptIfRunning) | 取消当前任务；
isDone() | 判断任务是否已完成。
---

# 2.CompletableFuture
Java 8引入CompletableFuture

解决：Future异步执行结果时，调用阻塞方法get()，要么轮询看isDone()是否为true，导致因为主线程也会被迫等待  
CompletableFuture: 可以传入回调对象，当异步任务完成或者发生异常时，自动调用回调对象的回调方法。

```java
// 创建异步执行任务:
CompletableFuture<Double> cf = CompletableFuture.supplyAsync
//java8函数参数化
(Main::fetchPrice);
// 如果执行成功:
cf.thenAccept((result) -> {
    System.out.println("price: " + result);
});
// 如果执行异常:
cf.exceptionally((e) -> {
    e.printStackTrace();
    return null;
});
// 主线程不要立刻结束，否则CompletableFuture默认使用的线程池会立刻关闭:
Thread.sleep(200);
```
串联执行
```java
// 第一个任务:
 CompletableFuture<String> cfQuery = CompletableFuture.supplyAsync(() -> {
     return queryCode("中国石油");
 });
 // cfQuery成功后继续执行下一个任务:
 CompletableFuture<Double> cfFetch = cfQuery.thenApplyAsync((code) -> {
     return fetchPrice(code);
 });
 // cfFetch成功后打印结果:
 cfFetch.thenAccept((result) -> {
     System.out.println("price: " + result);
 });
 // 主线程不要立刻结束，否则CompletableFuture默认使用的线程池会立刻关闭:
 Thread.sleep(2000);
 ```

 并联执行

## 总结
CompletableFuture可以指定异步处理流程：
* thenAccept()处理正常结果；
* exceptional()处理异常结果；
* thenApplyAsync()用于串行化另一个CompletableFuture；
* anyOf()和allOf()用于并行化多个CompletableFuture。