Rxjava-lift-compose

<!-- TOC -->

- [1. life](#1-life)
    - [1.1 lift 介绍](#11-lift-介绍)
    - [1.2 自定义lift](#12-自定义lift)
- [2.compose](#2compose)
    - [2.1 compose和life区别](#21-compose和life区别)
    - [2.2使用](#22使用)

<!-- /TOC -->

# 1. life
## 1.1 lift 介绍
map/flat都是对针对事件序列的处理和再发送。都是基于lift(Operator)变换的。
lift生成一个新的observer和observable，插入到原始异步源和observer

好处，可以通过代理观察者，解决真正观察者的走向

伪代码
```java

//flatmap
public final <R> Observable<R> flatMap(Func1<? super T, ? extends Observable<? extends R>> func) {
    ...
    return merge(map(func));
}

public static <T> Observable<T> merge(Observable<? extends Observable<? extends T>> source) {
    ...
    return source.lift(OperatorMerge.<T>instance(false));
}

//lift
public <R> Observable<R> lift(Operator<? extends R, ? super T> operator) {
    return Observable.create(new OnSubscribe<R>() {
        @Override
        public void call(Subscriber subscriber) {
            //创建中间观察者，也就是代理观察者
            Subscriber newSubscriber = operator.call(subscriber);
            newSubscriber.onStart();

            //调用的是原始异步源的call
            onSubscribe.call(newSubscriber);
        }
    });
}
```

## 1.2 自定义lift
```java
public interface ObservableOperator<Downstream, Upstream> {
    //观察者
    Observer<? super Upstream> apply(Observer<? super Downstream> observer) throws Exception;
}
```

```java
Class ObservableOperator<T, T> {<Integer, String>() {

    @Override
    public Subscriber<? super String> call(Observer<? super Integer> observer) {
        return new Subscriber<String>() {
            @Override
            public void onCompleted() {
                observer.onCompleted();
            }

            @Override
            public void onError(Throwable e) {
                observer.onError(e);
            }

            @Override
            public void onNext(String s) {
                int value = Integer.valueOf(s); //进行转换
                observer.onNext(value);
            }
        };
    }
}

//使用
mObservable.lift(ObservableOperator)
```

# 2.compose
## 2.1 compose和life区别
* compose() 
是唯一一个能从流中获取原生Observable 的方法，因此影响整个流的操作符，compose()会立即执行
因此subscribeOn()和observeOn()）需要使用compose()。  

* flit()
只是对事件序列的处理和再发送，不会影响整个流的操作符.只有在订阅之后才会生效


## 2.2使用
compose(Transformer())


## 3.as()
as 配合 ObservableConverter 使用  

as方类似于compose,不同的是，Observable通过compose生成的对象还是Observable，但as方法生成的则是一个新的对象.

autoDisposable中的使用
1.
```java
mObservable.as(AutoDispose.autoDisposable(AndroidLifecycleScopeProvider.from(lifecycleOwner)))
```
