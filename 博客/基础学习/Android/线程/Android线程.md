Android线程

<!-- TOC -->

- [1.Java 线程的实现](#1java-线程的实现)
  - [1.1 Runnable](#11-runnable)
  - [1.2 Callable](#12-callable)
  - [1.2 FutureTask](#12-futuretask)
- [2.Android中实现多线程](#2android中实现多线程)
  - [Handle | 设置loop，可以让handleMessage运行在指定的线程](#handle--设置loop可以让handlemessage运行在指定的线程)
  - [2.1 AsyncTask](#21-asynctask)
  - [2.2 HandlerThread](#22-handlerthread)
  - [2.3 IntentService](#23-intentservice)
- [4.Handle](#4handle)
- [补充](#补充)

<!-- /TOC -->

# 1.Java 线程的实现
## 1.1 Runnable
  没有返回值
## 1.2 Callable
  又返回值，可以返回值和一场，了解执行状态，取消任务的执行。  
  但是Thread并不支持Callable

```java
public interface Callable<V> {
    V call() throws Exception;
}
```

## 1.2 FutureTask
  兼顾两者优点，在Thread/ExecutorService中使用

```java
 public interface Future<V> {
    boolean cancel(boolean mayInterruptIfRunning);
    boolean isCancelled();
    boolean isDone();
    V get() throws InterruptedException, ExecutionException;
	V get(long timeout, TimeUnit unit) 
	throws InterruptedException, ExecutionException, TimeoutException;
}
```

# 2.Android中实现多线程

---
实现类 | 描述
---|---
AsyncTask | 它封装了线程池和Handler，主要为我们在子线程中更新UI提供便利。
HandlerThread | 它是个具有消息队列的线程，可以方便我们在子线程中处理不同的事务。
IntentService | 我们可以将它看做为HandlerThread的升级版，它是服务，优先级更高。
Handle | 设置loop，可以让handleMessage运行在指定的线程
------

## 2.1 AsyncTask
```java
private class MyAsyncTask extends AsyncTask{
    @Override
    protected Object doInBackground(Object[] params) {}
}
```

## 2.2 HandlerThread
```java
//
HandlerThread mHandlerThread = new HandlerThread("handlerThread");

Handler workHandler = new Handler( handlerThread.getLooper() ) {
    @Override
    public boolean handleMessage(Message msg) {}
});

//启动线程
mHandlerThread.start();

//发送消息
Message msg = Message.obtain();
//消息的标识
msg.what = 2;
// 消息的存放
msg.obj = "B";
//通过Handler发送消息到其绑定的消息队列
workHandler.sendMessage(msg);

mHandlerThread.quit();
```

存在内存泄漏的危险，解决：自定义handle，WeakHandler

## 2.3 IntentService
IntentService是一个继承Service的抽象类，所以我们必须实现它的子类再去使用
```java
public class MyService extends IntentService {
    //这里必须有一个空参数的构造实现父类的构造,否则会报异常
    //java.lang.InstantiationException: java.lang.Class<***.MyService> has no zero argument constructor
    public MyService() {
        super("");
    }
    
    @Override
    public void onCreate() {
        System.out.println("onCreate");
        super.onCreate();
    }

    @Override
    public int onStartCommand(@Nullable Intent intent, int flags, int startId) {
        System.out.println("onStartCommand");
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onStart(@Nullable Intent intent, int startId) {
        System.out.println("onStart");
        super.onStart(intent, startId);
    }

    @Override
    public void onDestroy() {
        System.out.println("onDestroy");
        super.onDestroy();
    }

    //这个是IntentService的核心方法,它是通过串行来处理任务的,也就是一个一个来处理
    @Override
    protected void onHandleIntent(@Nullable Intent intent) {
        System.out.println("工作线程是: "+Thread.currentThread().getName());
        String task = intent.getStringExtra("task");
        System.out.println("任务是 :"+task);
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```
```java
Intent intent = new Intent(this,MyService.class);
intent.putExtra("task","播放音乐");
activity.startService(intent);
```

# 4.Handle
```java
Handler wsMainHandler = new Handler(Looper.getMainLooper());
wsMainHandler.post(() -> pushListener.onOpen(response));
```

  
# 补充
Looper.getMainLooper().thread：获取主线程

