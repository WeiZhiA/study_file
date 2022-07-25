# Okhttp请求技巧
创建新的request，并发出网络请求

* 1.chain获取路径
```java
class KeepLiveHeaderInterceptor : Interceptor {
    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        //从缓冲中拿数据
        chain.proceed(chain.request());
        //构建新的request
        val newRequest = chain.request().newBuilder()
                .addHeader("Authorization", "Bearer $token")
                .build()
        //从网络中拿数据        
        return chain.proceed(newRequest)
    }
}
``` 

* 2.Response相关
   * Response获取内容
```java
Response response = chain.proceed(request);
ResponseBody responseBody = response.body();
//获取url
response.request().url().toString();
//获取头部
list<String> headers = response.headers("Set-Cookie");
BufferedSource source = responseBody.source();
source.request(Long.MAX_VALUE);
Buffer buffer = source.buffer();
//获取内容，并且不影响其他地方的内容获取
String responseString = buffer.clone().readString(UTF8);
Object jsonObject = new JSONTokener(responseString).nextValue();
if (jsonObject instanceof JSONObject) {
    JSONObject json = (JSONObject) jsonObject;
    int code = json.optInt("code");
    if (code == CODE_TOKEN_INVALID) {
    }
}
```
  * response创建    
 
```java
//构建失败response
val resp = BaseResponse<Nothing>()
resp.code = -1
resp.message = e.message ?: e.toString()
val responseBody =ResponseBody.create(MediaType.parse("json"),Gson Utils.toJson(resp))
Response.Builder().request(chain.request())
    .body(responseBody)
    .code(HttpCodec.DISCARD_STREAM_TIMEOUT_MILLIS)
    .message(resp.message)
    .protocol(Protocol.HTTP_2)
    .build()
```

  * response复制
```java
if (originalResponse.code() == 401{
    Response newResponse = new Response.Builder()
        .request(originalResponse.request())
        .protocol(originalResponse.protocol())
        .message(originalResponse.message())
        .cacheResponse(originalResponse.cacheResponse())
        .networkResponse(originalResponse.networkResponse())
        .priorResponse(originalResponse.priorResponse())
        .body(originalResponse.body())
        .code(200)
        .build();
    originalResponse = newResponse;
}

```