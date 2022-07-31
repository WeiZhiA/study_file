Apt
Annotation Processor Tool
ButterKnife：[ˈbʌtə naɪf]
Dagger2 [ˈdæɡə]

# 介绍  
注解一般有两种方式处理方式：  
* 第一：运行时获取并使用注解信息，此方式属于反射范畴，有性能损失，例如Retrofit2等。
* 第二：编译时获取注解信息，并据此产生java代码文件，无性能损失，例如butterknife，Dagger2，EventBus等


# ksp
官方对于ksp的介绍就是，这是一个轻量级替换kapt的一个方案，优点就是速度更快，参数更少更简单一点。

同时ksp相比于kapt接入方式也更清凉，还有就是它本身也支持增量编译等。