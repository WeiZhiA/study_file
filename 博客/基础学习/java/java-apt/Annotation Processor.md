Annotation Processor  
Annotation Processor [ˌænəˈteɪʃən  ˈprəʊsesə]:注解处理器

# 1.介绍
## 1.1概念
注解处理器(Annotation Processor)是<font color="#dd0000">javac内置的一个用于编译时扫描和处理注解(Annotation)的工具</font>。  

<font color="#dd0000">Annotation Process的实质用处就是在编译时通过注解获取相关数据</font>

## 1.2用途
由于注解处理器可以在程序编译阶段工作，所以我们可以在编译期间通过注解处理器进行我们需要的操作。比较常用的用法就是在编译期间获取相关注解数据，然后动态生成.java源文件（让机器帮我们写代码），通常是自动产生一些有规律性的重复代码，解决了手工编写重复代码的问题，大大提升编码效率。

# 1.2 使用和参数介绍

引入
```java
compile 'com.google.auto.service:auto-service:1.0-rc3'
```

```java
//@AutoService(Processor.class) //也可以不加
public class MyProcessor extends AbstractProcessor {
    @Override
    public boolean init(processingEnv: ProcessingEnvironment) {
        super.init(processingEnv)
    }

    @Override
    public boolean fun getSupportedAnnotationTypes(): MutableSet<String> {
        val supportAnnotationTypes = mutableSetOf<String>()
        supportAnnotationTypes.add(Router::class.java.canonicalName)
        return supportAnnotationTypes
    }

    @Override
    public boolean getSupportedSourceVersion(): SourceVersion {
        return SourceVersion.latestSupported()
    }

    @Override
    public boolean process(Set<? extends TypeElement> annoations, RoundEnvironment roundEnv) { 
        //	扫描所有被@Factory注解的元素
        val routerElements = roundEnv. getElementsAnnotatedWith(Router::class.java)
        for (element in routerElements) { 
            ....
            return true 
        }
        return false
    }
}
```

* 1.@AutoService(Processor.class) :向javac注册我们这个自定义的注解处理器，这样，在javac编译时，会生成
META-INF/services/javax.annotation.processing.Processor文件的  
如果不加可以手动创建 
META-INF/services/javax.annotation.processing.Processor
```java
com.example.MyProcessor
```

# 2.参数介绍
  * init(ProcessingEnvironment env):每个Annotation Processor必须有一个空的构造函数。编译期间，init()会自动被注解处理工具调用，并传入ProcessingEnviroment参数，通过该参数可以获取到很多有用的工具类: Elements , Types , Filer **等等

  * getSupportedAnnotationTypes(): 该函数用于<font color="#dd0000">指定该自定义注解处理器(Annotation Processor)是注册给哪些注解的(Annotation)</font>,注解(Annotation)指定必须是完整的包名+类名(eg:com.example.MyAnnotation)
   
  * process(Set<? extends TypeElement> annoations, RoundEnvironment roundEnv):Annotation Processor<font color="#dd0000">扫描出的结果会存储进roundEnv中，可以在这里获取到注解内容</font>，编写你的操作逻辑。注意,process()函数中不能直接进行异常抛出,否则的话,运行Annotation Processor的进程会异常崩溃,然后弹出一大堆让人捉摸不清的堆栈调用日志显示.    
   
  * getSupportedSourceVersion():用于指定你的java版本，一般返回：SourceVersion.latestSupported()。当然，你也可以指定具体java版本：return SourceVersion.RELEASE_7;

