Jetpack Compose

# 1.声明式编程
命令式编程：用代码告诉系统一步步具体的步骤。  
声明式编程：告诉系统最后需要实现的结果，具体实现的过程全部交给系统，不过问细节。  

状态(state): 任何可以随时间变化的值。  
事件(event): 通知程序发生了什么事情。  
单向数据流模式（unidirectional data flow）: 指的是向下传递状态，向上传递事件的设计模式。  

# 2.常用注解
## @Composable
Compose中的注释，用于告知Compose编译器此函数是用于显示界面UI的函数。 所有用于构建UI的函数都应该加上@Composable注释。

```kt
@Composable
fun ButtonRow() {
    MyFancyNavigation {
        StartScreen()
        MiddleScreen()
        EndScreen()
    }
}
````
因为每个函数的组成不同，优先级不同，所以实际上并不是按顺序执行的。 所以应该要做的是让三个布局互相保持独立。

Compose会用并行运行的方式提高构建UI的速度。  
所以可组合函数可能在后台线程池中执行，如果某个可组合函数调用ViewModel中的函数，则Compose可能会同时从多个线程中调用该函数。


在Composable函数中如果传入的数据发生了改变，Compose会界面进行更新绘制，这一过程就叫重组(recomposition)。
Compose为了节省电量和提高绘制UI效率，只会重组已经改变了数据的组件。
比如下面的例子中，myList数据发生了改变时Compose只会更新与myList相关的组件，Text("End")并不会被更新。

## 附带效应 (side-effect)

```kt
Row(horizontalArrangement = Arrangement.SpaceBetween) {
        Column {
        for (item in myList) {
            Text("Item: $item")
            // Avoid! Side-effect of the column recomposing.
            items++ 
        }
    }
    Text("Count: $items")
}
```


remember 和 mutableStateOf 函数。  
可组合函数可以使用 remember 将本地状态存储在内存中，并跟踪传递给 mutableStateOf 的值的变化。该值更新时，系统会自动重新绘制使用此状态的可组合项（及其子项）。我们将这一功能称为重组。