dart语言

# 声明变量
## 1.var
```dart
var t;
t = "hi world";
// 下面代码在dart中会报错，因为变量t的类型已经确定为String，
// 类型一旦确定后则不能再更改其类型。
t = 1000;
```
Dart本身是一个强类型语言，var会在第一次赋值数据的类型来推断其类型，编译后确定下来。

## dynamic和Object
所有类型都是Object的子类(包括Function和Null)。

dynamic与Object相同之处在于,他们声明的变量可以在后期改变赋值类型

## final和const
const 变量是一个编译时常量，final变量在第一次使用时被初始化
```dart
final str = "hi world";
const str1 = "hi world";
```

# 函数
真正的面向对象的语言，所以即使是函数也是对象，并且有一个类型Function。

如果没有显式声明返回值类型时会默认当做dynamic处理。注意，函数返回值没有类型推断：

```dart
typedef bool CALLBACK();

//不指定返回类型，此时默认为dynamic，不是bool
isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

void test(CALLBACK cb){
   print(cb()); 
}
//报错，isNoble不是bool类型
test(isNoble);
```


```dart
//函数作为变量
var say = (str){
  print(str);
};
say("hi world");

//函数作为参数传递
void execute(var callback) {
    callback();
}
execute(() => print("xxx"))

//可选的位置参数
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

<!-- 可选的命名参数 -->
//设置[bold]和[hidden]标志
void enableFlags({bool bold, bool hidden}) {
}

enableFlags(bold: true, hidden: false);

<!-- 注意，不能同时使用可选的位置参数和可选的命名参数 -->

```


# 异步

## Future

```dart

Future
    //延时操作
    .delayed(new Duration(seconds: 2),(){
        throw AssertionError("Error"); 
        return "hi world!";
    })
    //等待耗时任务结束，执行
    .then((data){})
    //执行失败会走到这里 
    .catchError((e){});;

    //可以同时处理错误和正确的then
    .then((data) {}, onError: (e) {})
    
    //无论成功或失败都会走到这里
    .whenComplete((){});;

<!-- 等他连个异步任务都完成，才继续走 -->
Future.wait([
  // 2秒后返回结果  
  Future.delayed(new Duration(seconds: 2), () {
    return "hello";
  }),
  // 4秒后返回结果  
  Future.delayed(new Duration(seconds: 4), () {
    return " world";
  })
]).then((results){
  print(results[0]+results[1]);
}).catchError((e){
  print(e);
});

```

## Async/await
无论是在JavaScript还是Dart中，async/await都只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。
```dart
//async用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数。
Future<void>  task() async {
   try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);

    //await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；await必须出现在 async 函数内部。
    await saveUserInfo(userInfo);  
   } catch(e){
    print(e);   
   }  
}
```

## Stream
也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果（成功或失败）

```dart
Stream.fromFutures([
  // 1秒后返回结果
  Future.delayed(new Duration(seconds: 1), () {
    return "hello 1";
  }),
  // 抛出一个异常
  Future.delayed(new Duration(seconds: 2),(){
    throw AssertionError("Error");
  }),
  // 3秒后返回结果
  Future.delayed(new Duration(seconds: 3), () {
    return "hello 3";
  })
]).listen((data){
   print(data);
}, onError: (e){
   print(e.message);
},onDone: (){

});

```