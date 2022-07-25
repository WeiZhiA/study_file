Android 常用注解

# 1.java方法
注解 | 说明
---|---
@Nullness | 表示可以为null
@NonNull | 表示不可以为null
@Nullable | 其返回值不进行null的检查，则会出现警告
@CallSuper | 确保任何子类确定调用super.onCreate()
@Keep | 确保标记的指定代码在混淆时不会被混淆.一般会添加到通过反射访问的方法和类中，以阻止编译器将代码视为未使用。
@VisibleForTesting | 注解可以表示方法、类或字段的可访问性 



```java
@Nullable
public TextView getTextView(){
    return new TextView(this);
}

// Typedef 注解
//@IntDef 和 @StringDef注解，能够创建整型和字符串集 枚举注解来验证其他类型的代码引用。
public abstract class ActionBar {
    //创建枚举以验证值
    @Retention(RetentionPolicy.SOURCE)
    @IntDef({NAVIGATION_MODE_STANDARD, NAVIGATION_MODE_LIST, NAVIGATION_MODE_TABS})
    public @interface NavigationMode {}

    @NavigationMode
    public abstract int getNavigationMode();

    // 创建
    public abstract void setNavigationMode(@NavigationMode int mode);


```
# 2.资源注解
注解 | 说明
---|---
@LayoutRes | R.layout 类型资源。
@ColorInt  | 指示某个参数必须为颜色整型
@ColorRes | R.color 类型资源。
@StyleRes | R.style 类型资源。
@RawRes | R.raw 类型资源
@IdRes | R.id 类型资源。
@DrawableRes | R.drawable 类型资源。
@XmlRes | R.xml 类型资源。
@IntegerRes | R.integer 类型资源。
@AnimatorRes | R.animator 类型资源。
@AnimRes | R.anim 类型资源。
@ArrayRes | R.array 类型资源。
@AttrRes | R.attr 类型资源。
@BoolRes | R.bool 类型资源。
@DimenRes | R.dimen 类型资源。
@FractionRes | R.fraction 类型资源。（百分比）
@InterpolatorRes | R.interpolator 类型资源。（插值器）
@MenuRes | R.menu 类型资源。
@PluralsRes | R.plurals 类型资源。（复数）
@StyleableRes | R.styleable 类型资源。
@TransitionRes |  R.transition 类型资源。
@AnyRes | 未知资源。（表示自己不知道是什么类型的资源。比如有可能为 R.drawable 也有可能是 R.string。）

# 3 线程注解
注解 | 说明
---|---
@MainThread | 
@UiThread | 
@WorkerThread | 标记的方法只应该在工作线程上调用。如果标记的是一个类，那么该类中的所有方法都应是在一个工作线程上调用
@BinderThread | 标记的方法只应在绑定线程上调用。如果标记的是一个类，那么该类中所有方法都应在绑定线程被调用
@AnyThread |

# 4.值约束注解
注解 | 说明
---|---
@IntRange/@FloatRange | 验证传递的参数的值</br>@IntRange(from=0,to=255) int alpha </br>@FloatRange(from=0.0, to=1.0) float alpha
@Size | 检查集合或数组的大小，以及字符串的长度 </br>@Size(min=2)</br>@Size(max=2) </br> @Size(2) 准确大小

# 3.5 权限注解

```java
验证是否存在某个权限
@RequiresPermission(Manifest.permission.SET_WALLPAPER)
public abstract void setWallpaper(Bitmap bitmap) throws IOException;

//验证是否存在多个权限
@RequiresPermission(allOf = {
    Manifest.permission.READ_EXTERNAL_STORAGE,
    Manifest.permission.WRITE_EXTERNAL_STORAGE})
public static final void copyFile(String dest, String source) {
}

//单独读写权限的内容提供程序的权限
@RequiresPermission.Read(@RequiresPermission(READ_HISTORY_BOOKMARKS))
@RequiresPermission.Write(@RequiresPermission(WRITE_HISTORY_BOOKMARKS))
public static final Uri BOOKMARKS_URI = Uri.parse("content://browser/bookmarks");

//权限依赖于提供给方法参数的特定值
public abstract void startActivity(@RequiresPermission Intent intent, @Nullable Bundle) {...}

```