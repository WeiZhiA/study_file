SystemChrome

# 1.setPreferredOrientations
设置横竖屏

## a.单方向
```dart
// 竖直上
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
// 竖直下
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
// 水平左
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
// 水平右
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
```

## b.多方向
若需要应用随重力感应变化方向

```dart
// 竖直方向
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
// 水平方向
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft]);
// 多方向
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp]);

```

# 2.setEnabledSystemUIOverlays
```dart
//顶部底部状态栏均展示
SystemChrome.setEnabledSystemUIOverlays([
    //默认展示状态栏，隐藏导航栏，获取焦点后才展示导航栏
    SystemUiOverlay.top,
    //默认展示导航栏，隐藏状态栏，获取焦点后展示状态栏
    SystemUiOverlay.bottom
    ]);
```

# 3.setSystemUIOverlayStyle
```dart
//仅用于 Android 设备且 SDK >= O 时，底部导航栏颜色
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.pink));

//仅用于 Android 设备且 SDK >= P 时，底部状态栏与主内容分割线颜色，效果不是很明显；
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarDividerColor: Colors.yellow));

//底部状态栏图标样式，主要是三大按键颜色；
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.pink));
```

# 4.statusBarColor
```dart
<!-- 仅用于 Android 设备且 SDK >= M 时，顶部状态栏颜色； -->
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.red));
```

# 4.statusBarIconBrightness

```dart
//用于 Android 设备且 SDK >= M 时，顶部状态栏图标的亮度；但小菜感觉并不明显；
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));

// 该属性仅用于 iOS 设备顶部状态栏亮度；
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

```



