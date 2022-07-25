操作符

<!-- TOC -->

- [1.操作符](#1操作符)
  - [1.1创建操作](#11创建操作)
  - [1.2 变换操作](#12-变换操作)
  - [1.3 过滤操作](#13-过滤操作)
  - [1.4 组合操作](#14-组合操作)
  - [1.5 错误处理](#15-错误处理)
  - [1.6 辅助操作](#16-辅助操作)
  - [1.7 条件和布尔操作](#17-条件和布尔操作)
  - [1.8 算术和聚合操作](#18-算术和聚合操作)
  - [1.9 连接操作](#19-连接操作)

<!-- /TOC -->

# 1.操作符
## 1.1创建操作
用于创建Observable的操作符

操作符 | 作用
---|---
Create | 从头创建一个Observable
Just | 原样发送，集合发集合，分开发送就是分开发送
fromArray() | 接受一个数组参数，将里面的数据逐一发出
fromIterable() | 接受一个集合，将里面的数据逐一发出
Empty | 不发射任何数据但是正常终止的Observable
Never |不发射数据也不终止
Throw | 以一个错误终止的Observable
Interval(long period, TimeUnit unit) | 定时发送
intervalRange(long start, long count, long initialDelay, long period, TimeUnit unit) | 限制发射次数
timer(long delay, TimeUnit unit) | 延迟delay后发出
static Defer() | 当订阅的时候才创建被观察者
Range(int start, int count) | 从start，发送到start+count-1
Repeat(n) | 重复n次触发订阅
repeatUntil(BooleanSupplier) | 重复触发订阅，直到满足条件就停止
repeatWhen(Function) | 当满足条件订阅，直到不满足停止订阅
Start | 发射一个函数的返回值的Observable

操作符 | 作用
---|---
doFinally | 每次接受都会走的
doOnNext() | 
onComplete | 
doOn


## 1.2 变换操作
这些操作符可用于对Observable发射的数据进行变换，详细解释可以看每个操作符的文档

操作符 | 作用
---|---
FlatMap | 将数据转化为次级Observable，如果主的是数组，则使用merge合并，导致无序，例如网络请求拿到url，在用url请求数据
concatMap | 主Observable是数组的话，使用concat合并，保留项目的顺序，前一个完成，才会继续下一个
concat() | 多数据源合并，并按照顺序发送，如上
SwitchMap | 取消前一个observable，并订阅最新的
GroupBy | 分组，将原始Observable发射的数据按Key分组
Map | 映射，常用与转为另外一种类型
Buffer(n) | 可理解为缓存，定期将数据放到到一个集合，然后打包发射，而不是一次发射一个
Window | 窗口，类似于Buffer，但Buffer发射的是数据，Window发射的是Observable

## 1.3 过滤操作
这些操作符用于从Observable发射的数据中进行选择

操作符 | 作用
---|---
First | 首项，只发射满足条件的第一条数据
Filter | 过滤，过滤不想要的数据
Distinct | 去重，过滤掉重复数据项
Skip(n) | 跳过前面n个任务，只接受后面的任务
SkipLast(n) | 跳过后面的n个数据
sample(long period, TimeUnit unit) | 采样操作，它会定时地扫描被观察者发送的数据，并接收被观察者最近发射的数据
Take | 只保留前面的若干项数据
TakeLast | 只保留后面的若干项数据
ElementAt | 取值，取特定位置的数据项
Debounce | 在限定的时间会被过滤掉，超过这个时间的事件才会被触发，可以用来做防止重复点击
IgnoreElements | 忽略所有的数据，只保留终止通知(onError或onCompleted)
Last | 末项，只发射最后(或者满足调节的)一条数据

## 1.4 组合操作
组合操作符用于将多个Observable组合成一个单一的Observable

操作符 | 作用
---|---
merge | 将两个Observable发射的数据组合并成一个发送，谁先到发送谁，原样发送
mergeWith | 合并Observable，谁先到，发送谁
concatWith | 合并Observable，顺序发送
Zip | 打包，将多个发射的数据合并，并发射组合数据
zipWith | 两个Observable对应位置的数据合并后，放入新的Observable 中发射，发送的数据和最少的Observable个数一样
switchOnNext | 有新的observable出现时，丢弃旧的，使用最新的Observable
StartWith | 在原来的数据之前，插入数据并先发送
Join | 无论何时，如果一个Observable发射了一个数据项，只要在另一个Observable数据的时间窗口内，就将两个Observable发射的数据合并发射
And/Then/When | 通过模式(And条件)和计划(Then次序)组合两个或多个Observable发射的数据集
CombineLatest | 两个observable，其中一个发送数据和最近的另一个的数据组合

## 1.5 错误处理
这些操作符用于从错误通知中恢复
操作符 | 作用
---|---
onErrorReturn | 捕获错误数据，并将错误替换为正常的数据，发射出去
retry(long/Function)/retryUntil/retryWhen | 出错重试


## 1.6 辅助操作
一组用于处理Observable的操作符

操作符 | 作用
---|---
Delay(delay, timeUnit) | 延迟一段时间发射结果数据
SubscribeOn | 指定Observable执行的线程
ObserveOn | 指定观察者的调度线程（一般为工资线程工作线程）
Subscribe | 订阅，订阅之后才会开始发射
Timeout | 添加超时机制，指定时间内未发射，则发送错误通知
Timestamp | 给Observable发射的每个数据项添加一个时间戳
doOnEach() | 发射数据的时候执行
doAfterNext | 数据发射成功后
doOnNext | 调用onNext方法时
doOnComplete | 调用onComplete方法时
doOnError | 调用onError时
doFinally | onComplete，onError或者取消订阅关系后

## 1.7 条件和布尔操作
这些操作符可用于单个或多个数据项，也可用于Observable

操作符 | 作用
---|---
Amb | 给定多个Observable，第一个有数据Observable发送，后面的就不再执行
Observable.ambArray(o1,o2,o3)等价于o1.ambWith(o2,o3) | 说明看上面
take(long count) | 只接受前count条数据
takeLast(long count) | 只接受后count条数据
takeUntil(Predicate<Integer>()) | 满足条件，停止发射
TakeWhile(Predicate<Integer>()) | 满足条件才发射数据，不满足就中断
DefaultIfEmpty | 发射来自原始Observable的数据，如果原始Observable没有发射数据，就发射一个默认数据。场景：获取数据，内存/本地/网络
skip(long count) | 用于过滤被观察者发送的前 n 项数据
skipLast(int count) | 用于过滤最后 n 项数据。
SkipUntil | 丢弃原始Observable发射的数据，直到第二个Observable发射了一个数据，然后发射原始Observable的剩余数据
SkipWhile | 丢弃原始Observable发射的数据，直到一个特定的条件为假，然后发射原始Observable剩余的数据
All | 判断Observable发射的所有的数据项是否都满足某个条件
Contains | 判断Observable是否会发射一个指定的数据项
SequenceEqual | 判断两个Observable是否按相同的数据序列


## 1.8 算术和聚合操作
这些操作符可用于整个数据序列

操作符 | 作用
---|---
Reduce | 只调用一次观察者，一次性将结果输出just(1,2,3)->6
reduceWith(Callable<String>(),BiFunction) | 合并一个其他的
Scan | 每次操作后都输出，例如just(1,2,3)->1,3,6,10
scanWith(new Callable<String>,BiFunction) | 合并一个其他的
Average | 计算Observable发射的数据序列的平均值，然后发射这个结果
Concat | 不交错的连接多个Observable的数据
Count | 计算Observable发射的数据个数，然后发射这个结果
Max | 计算并发射数据序列的最大值
Min | 计算并发射数据序列的最小值
Sum | 计算并发射数据序列的和

## 1.9 连接操作
一些有精确可控的订阅行为的特殊Observable

操作符 | 作用
---|---
Connect | 指示一个可连接的Observable开始发射数据给订阅者
Publish | 将一个普通的Observable转换为可连接的
RefCount | 使一个可连接的Observable表现得像一个普通的Observable
Replay | 确保所有的观察者收到同样的数据序列，即使他们在Observable开始发射数据之后才订阅
转换操作
To | 将Observable转换为其它的对象或数据结构
Blocking 阻塞Observable的操作符



GroupBy
```java
 Observable.range(0, 10).groupBy(new Func1<Integer, Integer>() {
            @Override
            public Integer call(Integer integer) {
                //分组的key
               return integer % 3;
            }
       }).subscribe(new Observer<GroupedObservable<Integer, Integer>>() {
            @Override
            public void onNext(final GroupedObservable<Integer, Integer> integerIntegerGroupedObservable) {
                integerIntegerGroupedObservable.subscribe(new Observer<Integer>() {
                    @Override
                    public void onCompleted() { }
                    @Override
                    public void onError(Throwable e) { }
                    @Override
                    public void onNext(Integer integer) {
                        LogUtils.d("------>group:" + integerIntegerGroupedObservable.getKey() + "  value:" + integer);
                    }
                });
            }
        });
```
