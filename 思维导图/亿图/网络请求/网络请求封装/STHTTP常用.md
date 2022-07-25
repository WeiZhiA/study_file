STHTTP常用

```java
//设置默认的baseurl
STHttp.setBaseUrl(UrlManage.getRootUrl())
//设置默认配置
STHttp.setDefaultProvider(this)

//添加新的baseurl 和 BaseHttpProvider
STHttp.setProvider(UrlManage.getRootUrl(), this)

```

