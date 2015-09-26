#iOS中一种网络层与业务层的设计方案


##iOS架构的必要性
提起iOS架构,免不了要谈到现在很火的MVVM和MVCS,但万变不离其宗,这两个概念其实也都基于MVC,它们的主要思想简而言之就是MVC中的C-controller里面的代码太多,在项目不断新增功能逐渐变大时,不利于开发也不利于维护.

* [***iOS架构更多的介绍请戳这里***](http://www.infoq.com/cn/articles/ios-app-arch-3-1?utm_source=infoq&utm_medium=related_content_link&utm_campaign=relatedContent_articles_clk).

* [`XBBusinessManager`代码戳这里](https://github.com/changjianfeishui/XBBusinessManager)

##为什么要把网络层独立出来
仅仅举例个人入行两年来所经历的实例.
###情形一:
很早以前的代码可能是这样的:
![情形一](https://github.com/changjianfeishui/XBImageStore/raw/master/XBBM/1.png)

###情形二:
估计现在很多公司正在使用的代码:
![情形二](https://github.com/changjianfeishui/XBImageStore/raw/master/XBBM/2.png)

情形二相对于情形一的区别就是在原始的第三方网络库(eg.AFNetworking)基础上做了一层封装,这样在一定程度上降低了第三方库和项目之间的耦合度.但这样控制器仍可算的上是直接和网络层在进行交互.

###使用XBBusinessManager的代码:
![情形三](https://github.com/changjianfeishui/XBImageStore/raw/master/XBBM/3.png)

###参数说明
`XBBusinessManager`代表整个项目的业务层,控制器只需要根据业务类型传入业务对应的action及参数,网络请求成功服务器返回数据后便会在通知```.

* `action`: 现在项目开发中一般都会在pch中定义一个全局的`HOST`变量,代表服务器接口地址,例如一个get请求:"http://www.xxx.com/rank?page=1&pagesize=10"中,`HOST`可能会被定义为`#define HOST @"http://www.xxx.com"`,那这个请求地址的`action`则就是`/rank?`.
* `requestType`:枚举类型,代表常规的get和post两种请求方式.
* `params`: 请求参数,字典类型.
* 'callbackDelegate' : 请求结果需要通知的对象.
* `dataType`:返回结果需要解析成的数据类型,如果需要解析为自定义的数据模型,请传入对应的模型class,否则传入nil将不做处理(由于目前使用AFNetworking,传入nil将返回NSDictionary或NSArray).
* 'identifier' : 给某个请求设定一个单独的tag值,设定这个参数的原因是在某些情况下(比如列表上下拉刷新加载数据),可能这个接口的`action`值是固定的,变化的只是参数(page),这样的话只通过`action`字段便无法判断出请求出来的数据是用来刷新最新的还是用来加载更多的.为了不让使用者增加额外的逻辑来处理这些细节,可以通过设定`identifier`字段来为某个请求绑定一个特定标识.

##XBBusinessManager的内部细节
'XBBusinessManager'是业务层,而网络层则通过`XBBaseHttpRequestHelper`类实现,这个类才是具体负责跟第三方网络库打交道,具体实现请查看源码.
##XBBusinessManager的使用
1. 需要加入网络监控功能需在appDelegate中导入`AppDelegate+XBNetworkingMonitor`分类,在启动时调用`startMonitor`方法.
2. 具体请求后获取数据需实现`XBBusinessDelegate`协议,协议内包含四个方法,分别表示获取数据成功,获取数据失败,网络断开,和使用蜂窝数据四种情况.之所以只使用delegate的方式,是因为曾经维护过的一个老项目中导出都是block调用,可追踪性太差,维护起来简直头大.单一的方式可以提供更好的可维护性.block确实使用十分方便,但滥用的后果也十分严重.个人也有一个简单的开源库使用了block,如果在该项目中使用delegate的话有兴趣的可以试试.代码地址戳这里[XBSettingController](https://github.com/changjianfeishui/XBSettingController).
##最后的话
`XBBusinessManager`只是个人的一点小想法,写的比较简单,更多细节请查看源码,由于水平有限,期待与各位同仁就更多好的开发方式方法进行探讨.


