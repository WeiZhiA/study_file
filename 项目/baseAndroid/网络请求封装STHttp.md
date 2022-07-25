STHttp工具类提供了一套可复用Retrofit、OkHttpClient的管理功能以及可灵活配置不同Api Url对应的网络请求配置功能。  
旨在满足基于Retrofit+OkHttpClient框架的多Api Url场景下的网络请求创建需求。
# 一、网络配置提供器(IHttpProvider)
IHttpProvier接口提供了一组网络配置方法，通过实现接口方法可完成自定义网络请求的初始化。它包含：
* 连接超时、读写超时设置；默认24s
* 网络请求拦截器配置
* 日志开关设置；默认打开
* OkHttpClient.Builder扩展
* Retrofit的CallAdapter.Factory设置，默认采用 RxJava2CallAdapterFactory和自定义的LiveDataCallAdapterFactory  
* Retrofit的Convert.Factory设置，默认采用GsonConverterAdapterFactory
* 请求任务插入打桩RequestHandle  
 详见基础库IHttpProvider.kt类

# 二、网络任务打桩(RequestHandle)
RequestHandle辅助类帮助使用者在发起Request之前以及回调Response之后插入自己的业务逻辑。  
它本质上是一个拦截器的操作，基于此类使用者无需再次手动创建拦截器。它提供了两个方法：
* onBeforeRequest：request请求前逻辑插入
* onAfterRequest：request请求后，response返回时逻辑插入

# 三、使用说明
* 设置默认网络配置器  
STHttp.setDefaultProvider(xxx)，尽管工具类提供了默认的DefaultHttpProvider，但是你依然可以实现自己所要的或者继承DefaultHttpProvider完成扩展。
           作用：当某个API域名没有设置网络配置的时候，将使用默认的网络配置

* 设置默认baseUrl
```java
STHttp.setBaseUrl(xxx)
```
作用：当创建Api Service时，通过设置默认的baseUrl再结合默认的网络配置器，使用者只需传入Api Service接口即可

* 设置网络配置器
设置网络配置有两种方式：
1. 使用STHttp提供的方法：STHttp.setProvider(url, provider)，为指定API域名设置网络配置器

* 生成API Service
生成api service有三种方式：
1. STHttp.get(url, service):生成指定API域名的API Service；  
    注意：如果传入的URL没有设置网络配置provider，那么将动态读取service的注解配置，以注解中配置的provider作为该URL下的网络配置器

2. STHttp.get(service):此方法会优先读取service的注解配置；

    注意：如果注解配置了URL域名那么将采用注解中的URL，否则使用默认的URL创建API Service

3. STHttp.get(url, service, observer):可监听API域名变化，如果传入的API域名发生变化，会生成新的API Service并通知观察者

* 切换API域名
如果某个时候你需要动态更改你的API域名，例如快速域名设置，环境切换等，可以这样：
``` java
STHttp.switchUrl(oldUrl, newUrl)
```
注意：此方法将会使HttpProvider指向新的URL，不适合全局Api Service的初始化，新的URL需要重新生成Api Service(不过使用带监听url变化的生成api service可以避免这一点)  

* 默认网络配置类DefaultHttpProvider具有处理URL动态变化的能力，使用notifyUrlChanged方法完成URL切换;  
    
    优点：Api Service只需初始化一次，URL即便变化了也能在请求中动态改变。

    注意：此种方式会使得旧的url对应的HttpProvider永久性发生变化，如果某次请求需要忽略该变化请在Api Service加入@Headers("ignoreUrlChange: true")

* 在Repository中的使用
1. 如果你能确定你的网络业务地址不会发生变化，那么建议在init方法中初始化API Service。
```java
init { val apiService = STHttp.get(url, service) }
```
2. 如果你的网络业务地址API可能发生变化，那么可以这样：      
```java
init { 
    var apiService = STHttp.get(url, service,    observer { apiService = it }) 
}
```
1. 当然你也可以使用更为拙劣的方法，即在每个方法里使用，这样：
``` kt
fun getRequest(param1, param2) {
    val apiService = STHttp.get(url, service)
    apiService.xxxx(param1, param2)
    //更多操作
}
```            

