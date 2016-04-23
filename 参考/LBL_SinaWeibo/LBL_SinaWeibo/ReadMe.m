1.项目
//淘宝，商品列表，商品详情，第三方支付....
 >iOS开发程序员/Android程序 (客户端的开发人员)
 >后台(java,PHP,.net)
 >美工(妹子,项目长什么样子)
 >测试(检查软件质量)
 >产品汪 (需求文档，原型文档(可能涉及到app的简单交互))
 >项目经理(监控项目的进度，对整个项目负责)
 >前端(h5)

 >开会，解决沟通问题 
 bug管理平台
    >jira  - open - close - reopen
    >bugfree

 >迭代 (迭代开发)

2..新浪微博
    >写什么功能-->照着做
    >切图从哪儿来-->从新浪微博里面扒出来

    >项目相关配置：
        >布su环境
        >配置只支持竖屏
        >app icon 大小尺寸一定要对
            >如果不对，打包出来的东西，支持上传不了
            >app icon 尽量不要透明 --显示出来会是黑色

        >启动图
            >launchScreen.xib 只支持iOS8
            >启动图里面一些需要注意的点
                如果只配置了4s的启动图，在5s与5上面，会出现上下两条黑边 （6,6plus）
                如果没有配置6的启动图，在6上面，会把屏幕等比例拉大，会把字体和图片-->变（会往下找，找到5s的图）
                如果没有配置6plus的启动图，是不会显示启动图的，也不会把屏幕等比例放大，因为屏幕的缩放系数与其他的不一样

    >项目框架
        自定义UITabBarController
            *如果tabbar上面的图片里面包括icon与文字，位置不对的话，可以用
            ctrl.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

        自定义tabbar继承于系统的tabBar
            "协议"：要注意继承父类的协议
            tabbar就是用于展示与点击的，具体点击做什么事情，抛给外界。


    >项目分层
        >先按模块分-->再按MVC分
        >先按MVC分--->再按模块
        >IBInspectable:
            其修饰的变量可以直接在xib右边的控制面板显示
        >IB_DESIGNABLE:
            其用于修饰View，可以动态在xib里面更新出实时的效果

补充：
initWithFrame-->跟xib没关系，调用alloc->init->一定会执行这个方法

initWithCoder-->如果当前View是从xib里面加载的话，这个方法一定会回调
awakeFromNib-->xib里面的子控件连接完成。
1.首页PopView实现
>整个View是继承于可点击的Button
>传入自定义View进去显示。
>小黑框的大小是由传入的View决定的
>注意：设置整个View的alpha与设置View背景颜色的alpha是不一样的
*设置整个View的alpha，如果alpha小于0.01的话是不可是点击的
*设置这个View背景颜色的alpha为0的话，是可以接收点击事件的
>获取某个控件在窗口中的位置
self.showWithView:需要转换的View
*用这个控件的frame去转换，frame是相对于父控件来说的，那个convertCGRect这个方法就用父控件来调用
CGRect frame = [self.showWithView.superView convertRect:self.showWithView.frame toView:[UIApplication sharedApplication].keyWindow];
*用这个控件的bounds去转换的话-->bounds是相对于他自己来说的，所以convertCGRect就是自己去调用：
CGRect frame = [self.showWithView convertRect:self.showWithView.bounds toView:[UIApplication sharedApplication].keyWindow];


2.新特性页
用于软件第一次启动或者新版本更新完成第一次启动显示的一个app功能介绍的这么一个页面
当前版本只显示一次


3.OAuth2.0 授权设置编辑
授权回调页：http://www.baidu.com/
取消授权回调页：http://www.baidu.com/
App Key：1147015486
App Secret：b93d7f956b74dcb38af2ff8d57f90bde
添加测试账号:追梦痞子Lee_

OAuth2的authorize接口
URL
https://api.weibo.com/oauth2/authorize?client_id=1147015486&redirect_uri=http://www.baidu.com/

HTTP请求方式
GET/POST
请求参数
    client_id	    true	string	申请应用时分配的AppKey。
    redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。

