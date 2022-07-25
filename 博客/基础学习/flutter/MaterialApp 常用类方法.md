# MaterialApp 常用类方法
字段 | 类型
---|---
navigatorKey（导航键） | GlobalKey<NavigatorState>
home（主页） | Widget
routes（路由） | Map<String, WidgetBuilder>
initialRoute（初始路由） | String
onGenerateRoute（生成路由） | RouteFactory
onUnknownRoute（未知路由） | RouteFactory
navigatorObservers（导航观察器） | List<NavigatorObserver>
builder（建造者） | TransitionBuilder
title（标题） | String
onGenerateTitle（生成标题） | GenerateAppTitle
color（颜色） | Color
theme（主题） | ThemeData
locale(地点) | Locale
localizationsDelegates（本地化委托） | Iterable<LocalizationsDelegate<dynamic>>
localeResolutionCallback（区域分辨回调） | LocaleResolutionCallback
supportedLocales（支持区域） | Iterable<Locale>
debugShowMaterialGrid（调试显示材质网格） | bool
showPerformanceOverlay（显示性能叠加） | bool
checkerboardRasterCacheImages（棋盘格光栅缓存图像） | bool
checkerboardOffscreenLayers（棋盘格层） | bool
showSemanticsDebugger（显示语义调试器） | bool
debugShowCheckedModeBanner（调试显示检查模式横幅） | bool


navigatorKey.currentState
相当于
Navigator.of(context)


# SliverPersistentHeader
属性名 | 类型 | 默认值 | 介绍
---|---|---|---
delegate | SliverPersistentHeaderDelegate | required | 组件构建代理
pinned | bool | false | 是否固定
floating | bool | false | 是否浮动


# SliverAppBar
```dart
SliverAppBar({
    Key key,
    this.leading,  //左侧控件 通常是个返回按钮
 
    // 如果没有leading，automaticallyImplyLeading为true，就会默认返回箭头
    // 如果 没有leading 且为false，空间留给title
    // 如果有leading，这个参数就无效了 默认为 true
    this.automaticallyImplyLeading = false,
 
    //标题 接收 widget 一般为 text
    this.title,
 
    this.actions,//右侧控件组
    this.bottom,//底部控件 例如通常是个 tabBar
 
    this.flexibleSpace, //展开折叠的区域 通常使用 FlexibleSpaceBar
    this.expandedHeight,//展开的高度
    this.elevation,//阴影
    this.shadowColor,//阴影颜色
    this.forceElevated = false, //是否显示阴影
    this.backgroundColor,//背景颜色
    this.brightness,// 应用栏材质的亮度,默认brightness.light
    this.iconTheme,//icon样式
    this.actionsIconTheme,//actionsIcon样式
    this.textTheme, //字体样式
 
    //appbar是否浸入状态栏，为false是为浸入，为true就显示在状态栏的下面
    this.primary = true,
    this.centerTitle,//标题是否居中

    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing, //标题间距
 
    this.collapsedHeight,//折叠之后的高度 默认 toolbarHeight 的高度
 
    //是否应该在用户滚动时变得可见 比如pinned 为false可滑出屏幕 当向下滑时可先滑出 状态栏
    this.floating = false,
 
    //appBar是否置顶 是否固定在顶部 为true是固定，为false是不固定可滑出屏幕
    this.pinned = false,
    //当手指放开时，SliverAppBar是否会根据当前的位置展开/收起
    this.snap = false,
 
    //拉伸一般会设置 FlexibleSpaceBar 的 stretchModes 使用
    this.stretch = false, //是否可拉伸伸展
    this.stretchTriggerOffset = 100.0, //触发拉伸偏移量
    this.onStretchTrigger,//拉伸监听
    this.shape,
    this.toolbarHeight = kToolbarHeight,
  })
  ```

## FlexibleSpaceBar
  ```dart
  FlexibleSpaceBar({
    Key key,
    this.title, //标题 同样接收的是Widget 固不局限于Text 此处设置的标题会根据 拉伸量移动 在SliverAppbar 设置的标题 不会移动
    this.background,//背景
    this.centerTitle,//是否居中
    this.titlePadding,//标题Padding
 
    this.collapseMode = CollapseMode.parallax, //折叠模式 = parallax pin none
 
      //StretchMode.zoomBackground- >背景小部件将展开以填充额外的空间。
      // StretchMode.blurBackground- >使用[ImageFilter.blur]效果，背景将模糊。
      // StretchMode.fadeTitle- >随着用户过度滚动，标题将消失。
    this.stretchModes = const <StretchMode>[StretchMode.zoomBackground],
}
```

https://blog.csdn.net/yechaoa/article/details/90701321


# NestedScrollView

```dart
const NestedScrollView({
    Key key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    @required this.headerSliverBuilder,
    @required this.body,
    this.dragStartBehavior = DragStartBehavior.start,
  })
```

# TabBar

```dart
const TabBar({
    Key key,
    @required this.tabs,//必须实现的，设置需要展示的tabs，最少需要两个
    this.controller,
    this.isScrollable = false,//是否需要滚动，true为需要
    this.indicatorColor,//选中下划线的颜色
    this.indicatorWeight = 2.0,//选中下划线的高度，值越大高度越高，默认为2
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,//用于设定选中状态下的展示样式
    this.indicatorSize,//TabBarIndicatorSize.label：indicator与文字同宽，TabBarIndicatorSize.tab：与tab同宽
    this.labelColor,//设置选中时的字体颜色，tabs里面的字体样式优先级最高
    this.labelStyle,//设置选中时的字体样式，tabs里面的字体样式优先级最高
    this.labelPadding,
    this.unselectedLabelColor,//设置未选中时的字体颜色，tabs里面的字体样式优先级最高
    this.unselectedLabelStyle,//设置未选中时的字体样式，tabs里面的字体样式优先级最高
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,//点击事件
  })


const TabBarView({
    Key key,
    @required this.children,//子widget
    this.controller,//控制器
    this.physics,
    this.dragStartBehavior = DragStartBehavior.down,
  })
```


# ScrollPhysics
确定可滚动控件的物理特性
* BouncingScrollPhysics ：允许滚动超出边界，但之后内容会反弹回来。
* ClampingScrollPhysics ： 防止滚动超出边界，夹住 。
* AlwaysScrollableScrollPhysics ：始终响应用户的滚动。
* NeverScrollableScrollPhysics ：不响应用户的滚动。

```dart
CustomScrollView(physics: const BouncingScrollPhysics())
ListView.builder(physics: const AlwaysScrollableScrollPhysics())
GridView.count(physics: NeverScrollableScrollPhysics())
```

## ScrollConfiguration 和 ScrollBehavior

ScrollPhysics 是和 ScrollConfiguration 和 ScrollBehavior 有关系。

文档
https://juejin.cn/post/6844903955584172039

# PageView
* scrollDirection  
滚动方向,分为 Axis.horizontal 和 Axis.vertical。
* reverse
反转，是否从最后一个开始算0
* controller
PageController 控制初始化第几个，占屏幕的范围。
* initialPage  
初始化第一次默认在第几个。
viewportFraction 占屏幕多少，1为占满整个屏幕
* keepPage  
是否保存当前 Page 的状态，如果保存，下次回复对应保存的 page，initialPage被忽略，如果为 false 。下次总是从 initialPage 开始。
* physics滚动的方式
* BouncingScrollPhysics 阻尼效果
* ClampingScrollPhysics 水波纹效果
* pageSnapping 是否具有回弹效果，默认为 true
* onPageChanged 监听事件
* children 具体子控件的布局
