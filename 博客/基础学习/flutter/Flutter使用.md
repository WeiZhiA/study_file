Flutter

##  2.Widgets

### 有状态
```dart
class StateFull extends StatefulWidget {
  @override
  _StateFullState createState() => _StateFullState();
}

class _StateFullState extends State<StateFull> {
  var number = 0;

  //进入时
  @override
  void initState() {
    super.initState();
  }

  //退出时
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("这是一个数字$number"),
        RaisedButton(onPressed: (){
          //setState 让页面显示
          setState(() {
            number++;
          });
        }, child: Text("增加")
        )

      ],
    );
  }
}
```

### 无状态

```dart
<!-- 包含了路由主题等等 -->
MaterialApp(
  //不显示debug
  debugShowCheckedModeBanner: false,
  tilte,
  theme, 
  home)

//包含appbar
Scaffold(
    appBar: AppBar(
      //阴影
      elevation: 10.0,
      //局中
      centerTitle: true,
      title: Text("listView Widget"),
    ),
    //要显示的内容
    body: GradeListWidge()),

<!-- ui库 -->
import 'package:flutter/material.dart';

void main() => runApp(MyApp)

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      //组件
    return MaterialApp(
      //标题
      title: 'Sample App',
      //主题
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //带有appbar的控件
      home: Scaffold(
        appBar: AppBar(title: Text("listView Widget"),),
        body:Center(
            child:Text('德玛西亚，圣光与我同在')
        )
      ),
    );
  }
}

<!--  -->
IconButton(onPressed: (){}, icon: Image.asset("images/wffsgpkfqy.jpeg"))

<!-- Text 常用 -->
Text(
    "现在的我已经飙到极限了!!(个人觉得库奇的话都挺好玩的，同样的，兰博的也是)",
    //右端对其
  textAlign:  TextAlign.right,
  maxLines: 1,
  //裁剪
  // overflow: TextOverflow.clip,
  //超出部分用...
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    fontSize: 18.0,
    color: Color.fromARGB(255, 255, 125, 125),
    //下划线
    decoration: TextDecoration.underline,
      //下划线样式
    decorationStyle: TextDecorationStyle.dashed
  ),


<!-- Container -->
Container(
  //宽度充满
  width: double.infinity,
   child: Text("千军万马一将在，探囊取物有何难", style: TextStyle(fontSize: 10.0,),),
   //内部控件的位置
   alignment: Alignment.bottomLeft,
   //默认宽高是充满屏幕
   width: 500,
   height: 400,
   //padding, const表示不变了
   // padding/margin: const EdgeInsets.all(10),
   padding: const EdgeInsets.fromLTRB(0,10,0,10),
   margin: const EdgeInsets.fromLTRB(10,0,0,0),
   //颜色
   // color: Colors.lightBlue,
   //渐变，类似于drawble； decoration不能同时和color存在
   decoration: BoxDecoration(
     //渐变
     gradient: LinearGradient(
       //多颜色组合
         colors : [Colors.lightBlue, Colors.greenAccent,Colors.purple]
     ),
     //增加便可
     border: Border.all(width: 2,color: Colors.red)
   )
)

<!-- Image -->
//显示本地图片

//需要在pubspec.yaml中，配置  assets:- images/wffsgpkfqy.jpeg
Image.asset('images/wffsgpkfqy.jpeg'),
Image.file()
//显示网络图片
Image.network(
   "http://wx2.sinaimg.cn/large/0073Cjx6gy1ggytsenozzj301j01jjrd.jpg",
   //图片怎么显示
   //BoxFit.contain : 保证图片比例的情况下，充满屏幕
   //BoxFit.fill : 充满容器
   //BoxFit.fitHeight : 高度充满，宽带裁剪
   //BoxFit.cover : 裁剪中充满
   //BoxFit.scaleDown : 不改变原图片
   fit: BoxFit.scaleDown,
//宽填充
   //fit: BoxFit.fitWidth,

   // //进行图片混合，类似tint
   // color: Colors.greenAccent,
   // //混合模式
   // //darken :偏色
   // colorBlendMode: BlendMode.multiply,

   repeat: ImageRepeat.repeat,
),

<!-- Row 水平布局 -->
Row(
  children: [
    //固定排序的位置
    textDirection: TextDirection.ltr,
    //max:父控件充满
     //min:自匹配
     mainAxisSize: MainAxisSize.max,


    //空隙大小相同
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,

    //空隙大小相同
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     //左中右
    mainAxisAlignment: MainAxisAlignment.spaceBetween,    

    //灵活的布局
    //相当于安卓中的weight, 都有平分；只有一个有，站慢剩余边距
    Expanded(
        child: RaisedButton(
          //按下事件
      onPressed: () {},
      color: Colors.redAccent,
      child: Text("德玛西亚！"),
    )),
    Expanded(
        child: RaisedButton(
      onPressed: () {},
      color: Colors.blueAccent,
      child: Text("洞察力是取胜的关键！ 一定不要让你的警觉松懈！"),
    )),
    Expanded(
        child: RaisedButton(
      onPressed: () {},
      color: Colors.orange,
      child: Text("喜欢我的武器？ 那就过来看看吧！"),
      //类似于weight
       flex: 2
    )),
  ],
);
<!-- Column 垂直布局 -->
Column(
	//垂直布局
	
	//距中根据最长的内容对其
	//垂直方向是主轴
	mainAxisAlignment: MainAxisAlignment.center,
	crossAxisAlignment: CrossAxisAlignment.center,
	children: [
	  RaisedButton(
	    onPressed: () {},
	    color: Colors.redAccent,
	    child: Text("德玛西亚！"),
	  ),
	
	  //不灵活布局
	  RaisedButton(
	    onPressed: () {},
	    color: Colors.blueAccent,
	    child: Text("洞察力是取胜的关键！"),
	  ),
	  //灵活布局
	  Expanded(
	      child: RaisedButton(
	    onPressed: () {},
	    color: Colors.orange,
	    child: Text("喜欢我的武器？ 那就过来看看吧！"),
	  )),
	],
);

<!-- 层叠布局 -->
var stack = Stack(
  //子view对其位置，0.5中间
  alignment: const FractionalOffset(0.5, 0.8),
  children: [
    //圆形图片
    CircleAvatar(
      backgroundImage: new NetworkImage("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg35.51tietu.net%2Fpic%2F2016-121402%2F20161214024820mtiei1p3h5140037.jpg&refer=http%3A%2F%2Fimg35.51tietu.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625671098&t=80dba1d5bc7bd100665ae9cd8d0039f0"),
      //也决定了图片的带下
      radius: 100,
    ),
    Container(
      //修饰器
      decoration:BoxDecoration(
        color: Colors.lightBlueAccent
      ),
      padding: EdgeInsets.all(5),
      child: Text("兽人永不为奴！！！"),
    ),
      //层叠定位布局
      Positioned(top: 60, left: 100, child: Text("人在塔在")),
      //层叠定位布局

      //如果Positioned设置了宽高，子widegt宽高不生效
      Positioned(top: 100, left: 150,
        overflow :设置超过怎么处理
         child: Text(
        "人在塔在",
        style: TextStyle(
          color: Colors.lightBlueAccent
        ),
      ))
  ],
);

<!-- 卡片布局 -->
//类似android的cardview
var card = Card(
  //card颜色
  color: Colors.lightBlue,
  //阴影
  elevation: 10,
  child: Column(
    children: [
      ListTile(
        //FontWeight 加粗
        title: Text("皇子", style: TextStyle(fontWeight: FontWeight.w500),),
        subtitle: Text("德玛西亚，永世长存！"),
        leading: Icon(Icons.access_alarm, color: Colors.lightBlue,),
      ),
      //分割线
      Divider(),
    ],
  ),

  class WrapWidget extends StatefulWidget {
  @override
  WrapWidgetState createState() => WrapWidgetState();
}
```
```dart
<!-- 流式布局 -->
class WrapWidgetState extends State<WrapWidget> {
  List<int> list = [];
  @override
  void initState() {
    super.initState();
    for(var i = 0; i<20; i++){
      list.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.spaceAround,
      spacing: 1,
      runSpacing: 1,
      children: list.map((e) => Container(
        height: 100,
        width: 100,
        color: Colors.lightBlue,
        child: Text(e.toString()),
      )).toList(),
    );
  }
}


//相对定位布局
class AligeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.redAccent,
      child: Align(
        alignment: Alignment(1,-0.5),
        child: FlutterLogo(),
      ),
    );
  }
}
```

```dart
<!-- 选择框 -->
Checkbox(
    value: isCheck1,
    onChanged: (v) {
      setState(() {
        isCheck1 = !isCheck1;
      });
    }),
Switch(
    value: isCheck2,
    onChanged: (v) {
      setState(() {
        isCheck2 = !isCheck2;
      });
    })


<!-- 可以设置多种点击事件 -->
GestureDetector(
    onTap: (){
      print("单击了");
    },
    onDoubleTap: (){
      print("双击了");
    },
    child: Text("这是一个文本"),
  );

```

```dart
  <!--  导航 -->
//跳转下一页
Navigator.of(context)
  .push(MaterialPageRoute(builder: (context) {
    return new SecondPage(); //要跳转的页面
  }

//退出当前页
Navigator.pop(context);


<!-- 页面跳转，并返回数据 -->
//异步，直到有返回值才继续往下走
jumpToSecondAwait(BuildContext context) async{
  var result = await Navigator.of(context).push(
    MaterialPageRoute(builder: (context){ return SecondPage(); },
      //可设置路由名称，参数等;是否是新的首页(首页没有返回按钮)
      settings: RouteSettings(
        name: "menu",
        arguments: "12341"
      ),
      //true:路由在没有用时，释放资源
      maintainState: false,
      //释放全屏幕
      fullscreenDialog: true,
    ),
  );
  print(result);
}


<!-- 非异步 -->
jumpToSecond02(BuildContext context) async{
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context){ return SecondPage(null, "菜单"); },
      //可设置路由名称，参数等;是否是新的首页(首页没有返回按钮)
      settings: RouteSettings(
          name: "menu",
          arguments: "12341"
      ),
      //true:路由在没有用时，释放资源
      maintainState: false,
      //释放全屏幕
      fullscreenDialog: true,
    ),
  ).
  <!-- 返回的时候，会调用回调方法 -->
  then((value) => print(value));

}
//返回给
Navigator.pop(context, "我又回来了");

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    <!-- 上一页传入的 -->
    var argument = ModalRoute.of(context)?.settings?.arguments;
  }
}


<!-- 路由重别名, 要在MaterialApp中设置 -->
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      showSemanticsDebugger: false,
      routes: {
        "/": (context) => LoginPage(),
        "layout": (context) => LayoutDemo(),
      },
      initialRoute: "layout",
      onGenerateRoute: (RouteSettings setting) {
        switch (setting.name) {
          case"menu":
            return MaterialPageRoute(builder: (context) => LoginPage());
            break;
          case "menu2":
            break;
        }
      },

    );
  }
}

<!-- 通过别名跳转 -->
 Navigator.of(context).pushNamed("menu");

<!-- 又返回按钮 -->
Navigator.of(context).popAndPushNamed("menu",arguments: "菜单").then((value) => print(value));
```
表单提交
```dart
Form(key:key,
    child: Column(
      children: [
        //可校验文本输入框
        TextFormField(
          autofocus: true,
          //每次改变时
          // onChanged:(){} ,
          controller: controller1,
          //处理焦点
          focusNode: focusNode1,
          //键盘显示的事件
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            icon: Icon(Icons.add),
            labelText: "账户",
            hintText: "请输入账户",
          ),
          validator: (v){
            if(v == null || v.length<5){
              return "账户输入必须大于5";
            }
          },

        ),
        SizedBox(height: 15,),
        TextField(
          //每次改变时
          // onChanged:(){} ,
          controller: controller2,
          //是否时密码
          obscureText: true,
          //处理焦点
          focusNode: focusNode2,
          //键盘显示的事件
          textInputAction: TextInputAction.send,
          decoration: InputDecoration(
            icon: Icon(Icons.add),
            labelText: "密码",
            hintText: "请输入密码",
          ),
        ),
        SizedBox(height: 15,),
        RaisedButton(onPressed: (){
          if(focusScopeNode == null) focusScopeNode = FocusScope.of(context);
          //focusNode1获取焦点
          // focusScopeNode?.requestFocus(focusNode1);
          //取消全部焦点
          focusScopeNode?.unfocus();
          print((key.currentState as FormState).validate().toString());
        },child: Text("提交表单"),)
      ],
    )
);
```

//容器
```dart
//容器
//超过或小于以父容器的为准。
class ConstrainBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(
      minWidth: 100,
      minHeight: 100,
      maxHeight: 200,
      maxWidth: 200
    ),
    child: Container(
      width: 1000,
      height: 100,
      color:Colors.lightBlue,
    ),);
  }
}

//SizedBox
//如果SizedBox设置了宽高，则子控件不生效
class SizeBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        width: 1000,
        height: 100,
        color:Colors.lightBlue,
      ),);
  }
}

//BoxDecoration 背景色
//渐变，圆角，边框，背景色
//前景色
//旋转
class DecorateBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          //圆角
          borderRadius: BorderRadius.circular(20),
          //渐变
          gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.red, Colors.greenAccent]),
          //阴影
          boxShadow: [BoxShadow(color: Colors.black, offset: Offset(2, 2),
              //模糊效果
              blurRadius: 10)]),
      //会在上面绘制，挡住下面
      // foregroundDecoration: BoxDecoration(),
      //以Y轴为中心旋转
      transform: Matrix4.rotationZ(0.5),
      child: Text(
        "LinearGradient",
        textAlign: TextAlign.center,
      ),
    );
  }
}
```
主题相关的
```dart

<!-- 首页 -->
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //主题颜色相关
      theme: ThemeData(
        //状态栏以及appbar颜色
        primaryColor: Colors.yellowAccent
      ),
      showSemanticsDebugger: false,
      routes: {
        "/": (context) => LoginPage(),
        "layout": (context) => LayoutDemo(),
      },
      initialRoute: "/",
      //路由
      onGenerateRoute: (RouteSettings setting) {
        switch (setting.name) {
          case"menu":
            return MaterialPageRoute(builder: (context) => LoginPage());
            break;
          case "menu2":
            break;
        }
      },

      //没有路由了，要设置home
      // home: LoginPage(),
    );
  }
}

<!-- 页面 -->
Scaffold(
    appBar: AppBar(
      //左侧图标
      leading: IconButton(onPressed: (){},icon:Icon(Icons.home)),
      //右侧图标
      actions: [
        IconButton(onPressed: (){},icon:Icon(Icons.add)),
        IconButton(onPressed: (){},icon:Icon(Icons.add)),
      ],
      //文字样式
      titleTextStyle: TextStyle(

      ),
      centerTitle: false,
      //阴影，类似android的levation
      elevation: 20,
      title: Text("登陆"),
      //必须是个小组件，例如Tabbar
      // bottom: TabBar(tabs:[] ),
    ),
    body: Column(
      children: [
        TabbarWidget(),

      ],

//超过四个会不显示
      bottomNavigationBar: 
      // //在中间打孔放入floatingActionButton
      //注意：可能会和底部的view冲突，而不显示
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.widgets_rounded),
      //   onPressed: () {},
      // ),


    )
);

<!-- TabBar 导航栏 -->
class TabbarWidget extends StatefulWidget {
  List<Widget> itemList = [Text("Android"),Text("IOS"),Text("Flutter")];
  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> with SingleTickerProviderStateMixin{
  List tabList = ["Android","IOS", "Web"];
  var curIndex = 0;

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length:tabList.length, vsync: this);
    //不触摸滑动用这个
    // tabController.addListener(() {
    //   setState(() {
    //     curIndex = tabController.index;
    //   });
    // });
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs:tabList.map((e) => Tab(text: e)).toList(),
            //设置指示器的样式
            // indicator: BoxDecoration(),
          ),
          //TabarView 决定了可以左右滑动
          Expanded(child: TabBarView(children: widget.itemList, controller: tabController))
        ],
      ),

    );
  }
}


//抽屉 Drawer; Scaffold.drawer可以直接设置的属性
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(context: context, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(padding: EdgeInsets.only(top: 40), child: Text("设置"),)
        ],

      )),
    );
  }
}

<!-- 底部导航栏，Scaffold.bottomNavigationBar可以直接设置的属性, -->
BottomNavigationBar(
  //修复超过四个，底部选项卡不显示或者透明化
  type: BottomNavigationBarType.fixed,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: "首页"),
  ],
  currentIndex: curNavigetIndex,
  onTap: (v) {
    setState(() {
      curNavigetIndex = v;
    });
  },
)
```

复杂布局
```dart
<!-- ListView -->
//下拉刷新，上拉加载
RefreshIndicator(
  child: ListView(
    controller: scrollController,
    scrollDirection: Axis.vertical,
    //子组件的高度，决定了listVieew高度
    shrinkWrap: false,
    //强制修改高度
    itemExtent: 50,
    //反项显示
    reverse: false,
    children: data.map((e) => Text(e.toString())).toList(),
  ),
  onRefresh: () async {
    //必须加await，不然不生效
    await Future.delayed(Duration(seconds: 3), () {

    });
    // return "";
  },
));
}


ListView.builder(
    itemCount: 100,
    itemBuilder: (BuildContext context, int index) {
      if (index % 2 == 0) {
        return Text(index.toString());
      } else {
        return RaisedButton(onPressed: (){}, child: Text(index.toString()));
      }
    }
);

<!-- ListTile -->
ListTile(
  //左边图标
  leading: Icon(Icons.add),
  //右边图标
  trailing: Icon(Icons.home),
  //标题
  title: Text("title"),
  //子标题
  subtitle: Text("subtitle"),
  //标题颜色
  tileColor: Colors.grey,
)

<!-- GridView -->
GridView.count(
  //GrideView内边距
  padding: EdgeInsets.all(20),
  //item间距
  crossAxisSpacing: 10.0,
  //一行显示的列数
  crossAxisCount: 3,
  children: [
    const Text("人在塔在！"),
    const Text("生命不息，战斗不止！"),
    const Text("这个世界，需要希望"),
    const Text("永远不要忘记，吾等为何而战！"),
    const Text("为了那些不能作战的人而战！"),
  ],
);

<!-- GrideLayout -->
GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //纵轴数量(相对于主轴),并且纵轴都是充满屏幕的；主轴自适应
      //主轴：排列的方向
      crossAxisCount: 3,
      /纵轴间距
      mainAxisSpacing: 2.0,
      //横轴间距
      crossAxisSpacing:20.0,
       //宽高比
      childAspectRatio: 1,
    ),
    scrollDirection: Axis.horizontal,
    //true:GridView的宽高由子view决定；false：GridView充满
    shrinkWrap: false,
    children: [
      Container(color: Colors.yellow,),
      Container(color: Colors.redAccent,),
      Container(color: Colors.greenAccent,),
    ],);
}
```

```dart
//充满屏幕，也会影响子控件
width: double.infinity,
mainAxisSize: MainAxisSize.max,

//设置边距
// padding/margin: const EdgeInsets.all(10),
padding: const EdgeInsets.fromLTRB(0,10,0,10),
```

dialog
```dart
  //async :表示下面要异步
  showAlter(BuildContext context) async{
    //await 表示等待，直到有结果
    var result = await showDialog(context: context, builder:(BuildContext context){
      //ios风格的按钮是CupertinoAlertDialog
      //android风格AlertDialog
      return CupertinoAlertDialog(
        title: Text("提示"),
        content: Text("确定取消吗"),
        actions: [
          FlatButton(onPressed: (){
            //关闭对话框
            Navigator.of(context).pop(true);
          }, child: Text("取消")),
          FlatButton(onPressed: (){
            //关闭对话框
            Navigator.pop(context,false);
          }, child: Text("确定")),
        ],

      );

    });
    print(result);
  }

  showSimpleDialog(BuildContext context) async{
    List<int> list = [1,2,3,5,6,7,8,9,0];
    var result = await showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return SimpleDialog(
        title: Text("标题"),
        children: [
          GestureDetector(child:Text("1"), onTap: (){Navigator.pop(context,false);},),
          GestureDetector(child:Text("1"), onTap: (){Navigator.pop(context,false);},),
          GestureDetector(child:Text("1"), onTap: (){Navigator.pop(context,false);},),
        ],
      );
    });
  }
```

表格Table
```dart

<!-- 没有标题头的表格 -->
Table(
  children: list
      .map(
          (e) => TableRow(children: [Text(e["name"]), Text(e["gendar"])]))
      .toList(),
)

<!-- 带有标题头的表格 -->
DataTable(
        //排序
      //默认那个排序
        sortColumnIndex: _sortColumnIndex,
        //升/降序
        sortAscending: _sortAscending,

        //标题头
        columns: [
          DataColumn(label: Text("姓名"),
            //点击修改升/降序
            onSort: (int columnIndex, bool ascending){
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                list.sort((a,b){
                  var aLen = a["name"].length;
                  var bLen = b["name"].length;
                  return ascending? bLen - aLen  : aLen - bLen;
                });
              });
            }
          ),
          DataColumn(label: Text("性别")),
          DataColumn(label: Text("年龄"),
              //点击修改升/降序
              onSort: (int columnIndex, bool ascending){
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  list.sort((a,b){
                    var aLen = a["age"];
                    var bLen = b["age"];
                    return ascending? bLen - aLen  : aLen - bLen;
                  });
                });
              }
          ),
        ],
        rows: list
            .map((e) => DataRow(
                    //增加选中框
                    selected: e["select"],
                    onSelectChanged: (v) {
                      if (e["select"] != v) {
                        setState(() {
                          e["select"] = v;
                        });
                      }
                    },
                    cells: [
                      DataCell(Text(e["name"])),
                      DataCell(Text(e["gendar"])),
                      DataCell(Text(e["age"].toString())),
                    ]))
            .toList());
```
## 2.交互
```dart
<!-- 添加手势 -->
GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container()
}
```

# 总结

## 位移
Transform.translate()

## 位置
Center  
Alignment()：可以把紧约束放松了

# 边距
Padding  
Margin

## layout
Container:有子widget就以子widget宽高为准，没有就充满全屏。它其实集合了很多组件的特性。防止金字塔结构写法。

SizeBox.expand():尽可能充满父widget  
FractionallySizedBox:相对父比例  
BoxConstraints:可以设置最小，最大高度  
BoxConstraints(
  //自动创建一个宽高200的布局
  constraints:BoxConstraints.tightFor(200,200)
).loosen():当前不再受到父约束。0<=width<Max  

Colum/Row  

statck(
clipBehavior:Clip.none:是否裁切，但是超出部分响应点击。最新。   
//overFlow:OverFlow.clip:溢出之后裁剪。 
align:Alignment,   
fit:Stack.expend:让子widget尽可能的大，为了匹配子widget，自己也只能尽可能的大。  
fit:Stack.loosen:自己和孩子都尽量小一点。  
fit:Stack.Passthrough:上级的约束传递下去。  
):层叠,先摆放没有位置的，再放有位置的。如果没有参照物(无位置组件)，则宽高充满父控件。

Position:有位置的组件，

## 组件

* 弹性组件
Expanded(flex)=安卓中的weidget。  
Flexible(flex=2)

Placeholder():占位符

