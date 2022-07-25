lifecycle

lifecycle [laifsaikl]  
LifecycleOwner [laifsaikl] [ˈəʊnə] 
lifecycleRegistry：[laifsaikl] [ˈrɛdʒɪstri]
state [steɪt]

# 1.概述
* 1.1 lifecycle是什么
  * lifecycle：感知/响应/存储另一个组件（如 Activity 和 Fragment）的生命周期状态的变化，例如activity的onCreate/onStart/onDestory，
  * 可以将代码部分功能放到其他类里面，减少acitivity代码，例如ViewModel，或者单一功能例如限时秒杀活动
  
# 2、重要的类和接口
* Lifecycle：是一个持有组件生命周期状态（如Activity或Fragment）的信息的类，并允许其他对象观察此状态。用于添加LifecycleObserver
* LifecycleOwner （重要）持有Lifecycle，FragmentActivity继承于它
* Event ：从框架和Lifecycle类派发的生命周期事件。这些事件映射到活动和片段中的回调事件。
* State ：由Lifecycle对象跟踪的组件的当前状态。
* LifecycleObserver（重要）Lifecycle观察者
实现该接口的类，通过注解的方式，可以通过被LifecycleOwner类的addObserver(LifecycleObserver o)方法注册,被注册后，LifecycleObserver便可以观察到LifecycleOwner的生命周期事件


# 3.使用

## 2.1 LifecyceObserver 创建
  *1.1 继承 LifecycleEventObserver 
```java
public class MyObserver implements LifecycleObserver {
    @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
    public void onResume() {
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
    public void onPause() {
    }
}
```

 * 1.2 继承 LifecycleEventObserver
 ```java
 public class MyObserver implements LifecycleEventObserver {
    public void onStateChanged(LifecycleOwner source, Lifecycle.Event event){
        //event的状态，看上面的状态1图
        ...
    }
 }
```

* 1.3 <font color="#dd0000">继承 DefaultLifecycleObserver</font>
```java
 public class MyObserver implements DefaultLifecycleObserver {
     @override 
     fun onCreate(owner: LifecycleOwner) {}

     @override 
     fun onStart(owner: LifecycleOwner) {}

    ....

 }
```

* 2.2 添加 LifecyceObserver
```java
//所有的myLifecycleOwner 都可以添加，例如activity
lifecycleOwner.getLifecycle().addObserver(new MyObserver());
```

## 2.2 LifecycleOwner
```java
class MyActivity : Activity(), LifecycleOwner {
  
  //LifecycleRegistry持有LifecycleOwner
  private lateinit var lifecycleRegistry: LifecycleRegistry
  override fun getLifecycle(): Lifecycle {
        return lifecycleRegistry
    }
  
  override fun onCreate(savedInstanceState: Bundle?) {
    //放入LifecycleOwner
    lifecycleRegistry = LifecycleRegistry(this)
    //放入状态
    lifecycleRegistry.markState(Lifecycle.State.CREATED)
  }
}
```


# 3.lifecycle 状态  
<table><tr><td bgcolor=#FFFFFFFF><img src="image/lifecycle1.svg" alt="GitHub"  height="300"   /> </table>


# 总结  
1.关系：
* LifecycleOwner 持有Lifecycle接口
* LifecycleRegistry实现了Lifecycle
* LifecycleObserver观察lifecycle
