Flutter动画

# 1.简介
动画类别
1.隐式(全自动)动画(自带Animated(隐式)，TweenAnimationBuilder自动隐式动画）
2.显式(手动控制)动画(CustomPainter，自带Transition,AnimatedBuilder)
3.其他动画(rive/flate/lottie)


# 隐样动画

## AnimatedContainer
* 1.相对于Container只是多了duration属性。
* 2.只有盒子AnimatedContainer上面的属性才有动画效果。

## AnimatedSwitcher
不同控件间切换动画
* 先看是否是不同的控件
* 再看key是否一样
只有这两个中又一个不一样，才会认为要有动画

```dart
AnimatedSwitcher(
  transitionBuilder: (child,animation) {
    // return FadeTransition(opacity: animation, child: child);
    // return RotationTransition(turns: animation, child: child);
    return ScaleTransition(scale: animation, child: child);
  },
  duration: Duration(milliseconds: 3000),
  // child: Text('hello',key: Key("hello"), style: TextStyle(color: Colors.white, fontSize: 20),),
    child: Text('World',key:UniqueKey(), style: TextStyle(color: Colors.white, fontSize: 50),),
  // child: Image.network("https://i-1-lanrentuku.qqxzb-img.com/2020/7/13/46321ab3-6aa8-43ca-9cf0-9668db22507c.jpg?imageView2/2/w/1024/")
)
```

AnimatedCrossFade和上面只有稍微不同。

## AnimatedPadding: 


## AnimatedOpacity
透明度动画  

Opacity：透明度
```dart
AnimatedOpacity(
   curve: Curves.bounceInOut,
   opacity: 0,
   duration: Duration(seconds: 2),
   child: Container(
     width: 100,
     height: 100,
     color: Colors.blueAccent,

   )
```

## TweenAnimationBuilder
类似于android的属性动画

```dart
TweenAnimationBuilder(
  // curve: Curves.bounceInOut,
  tween: Tween<double>(begin: 17, end: 50),
  duration: Duration(seconds: 2),
  builder: (BuildContext context, double value, Widget? child) {
    return  Container(
      width: 100,
      height: 100,
      color: Colors.blueAccent,

      child: Text("Hi", style: TextStyle(fontSize: value),),
    );
  },
```

对child操作
```dart
Transform.rotate(
     angle: value,
     child: Container(
       width: 100,
       height: 100,
       color: Colors.blueAccent,

       child: Text("Hi", style: TextStyle(fontSize: 17),),
     )
   );
```


# 显性动画

## 控制动画

SingleTickerProviderStateMixin：与屏幕刷新保持一致,一般使用这个就够了
## RotationTransition
旋转
```dart
class _MyHomePageState2 extends State<MyHomePage> 
  <!-- 可以垂直同步，每个手机刷新频率不一样，使用vsync，可以让动画跟随屏幕刷新频率，刷新 -->
  with SingleTickerProviderStateMixin { 

  @override
  void initState() {
    _controller = AnimationController(
        <!-- 进入垂直同步，在1s钟，计算3-5之间的数字；正常情况下，最大值是1 -->
        vsync: this,
        <!-- 可以使在0.8～1之间改变 -->
        scale: _controller.drive(Tween(begin: 0.8,end: 1)),
        duration: Duration(seconds: 1),
        lowerBound: 3,
        upperBound: 5);
        _controller.addListener(() {
          print(_controller.value);
        });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
   
   RotationTransition(
         // curve: Curves.bounceInOut,
         turns: _controller,
         child: Icon(Icons.refresh,size: 100,),
     ),
   )
   
   <!-- 重复动画 -->
   _controller.repeat();
  <!-- reverse:放大之后缩小 -->
   _controller.repeat(reverse: true);
}

<!-- ..就可以会传本身了 -->
AnimationController..repeat();

```

## FadeTransition
渐变

## ScaleTransition

## SlideTransition
```dart
SlideTransition(
    // curve: Curves.bounceInOut,
    <!-- Offset(0,0): 1表示移动一个控件的大小 -->
    position: _controller.drive(Tween(begin: Offset(0,0),end: Offset(1,1))),
    <!-- 或者这样写 -->
    position: Tween(begin: Offset(0,0),end: Offset(1,1))
        <!-- 动画的移动的样式 -->
        .chain(CurveTween(curve: Curves.elasticInOut))
        .animate(_controller),
    child: Container(width: 300,height: 300,color: Colors.blueAccent,),
),
```

## 交错动画
```dart
class _MyHomePage3State extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 2));
    super.initState();
    _controller.repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        <!-- Interval:代表0-0.2 这个时间内，走完全部  -->
        SlideBox(_controller, Colors.blueGrey, Interval(0.0, 0.2)),
        SlideBox(_controller, Colors.lightBlueAccent, Interval(0.2, 0.4)),
        SlideBox(_controller, Colors.lightBlue, Interval(0.4, 0.6)),
        SlideBox(_controller, Colors.blue, Interval(0.6, 0.8))
      ],
    );
  }
}


class SlideBox extends StatelessWidget {
  late AnimationController controller;
  late Color color;
  late Interval interval;
  SlideBox(this.controller, this.color, this.interval);
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: Tween(begin: Offset.zero, end: Offset(1,0))
                <!-- chain其实是对数据进行处理， 例如f2(f1()) -->
                .chain(CurveTween(curve: Curves.bounceInOut)) //f1
                .chain(CurveTween(curve: this.interval))// f2
                .animate(this.controller),
            child: Container(width: 100,height: 50,color: this.color,));
  }
}
```

## 自定义动画 AnimatedBuilder

```dart
<!-- SingleTickerProviderStateMixin：只有一个controler，一般这个就够了 -->
<!-- TickerProviderStateMixin: 可以获取多个controler -->

AnimatedBuilder(
        //AnimatedBuilder监听，_controller，如果数值发生变化，就重新调用build函数
        //同时会把build里面的控件全部绘制一遍，因此为了优化，可以使用child
        animation: _controller,
        builder: (BuildContext context, Widget? child){
          //FadeTransition
          return Opacity(
            //1.自己计算
            // opacity: 0.5+_controller.value*0.5,
            //2.使用 Tween
            // opacity: Tween(begin: 0.5, end: 1.0).evaluate(_controller),
            //3.使用 Animation
            opacity: animation.value,
            child: Container(
              width: 200,
              //Tween更像一个函数，传入一个值，返回处理过的值,evaluate计算
              height: Tween(begin: 200.0, end: 300.0).evaluate(_controller),
              // height: 200+100*_controller.value,
              color: Colors.blue,
              //真正被绘制出来的；每次都传入，节约了性能
              child: child,
            ),
          );
        },
      //并不会被绘制出来
      child: Center(child: Text("Hi", style: TextStyle(color: Colors.white, fontSize: 12),)),
    );

```