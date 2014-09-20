Unity3DWeiboShare
=================

Unity3d新浪微博分享sdk插件<br>

暂时只支持ios<br>
用于新浪微博的无界面形式分享。<br>
在分享前会有认证，倘若认证没有过期，将直接发送分享，无界面。<br>

注意事项：
将插件内容全部加入xcode项目<br/>
1.U3DWeiboSDK中的 appkey 需要根据微博开发者中显示的填<br>
2.增加Info.plist 元素(可从sdk例子中拷贝过来，也可以自己填) URL types : (Document Role : Editor) , (URL identifier : com.jimei) , (URL Schemes : wb[appkey])(Array) <br>
3.在UnityAppController.mm中的 - (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
方法中添加[WeiboSDK handleOpenURL:url delegate:[U3DWeiboSDK getWeibo]];并且引入#import "WeiboSDK.h",#import "U3DWeiboSDK.h"<br>
4.WeiboShare.cs接口中以Share为主接口，它肩负认证和分享功能。<br>
5.微博分享图片功能以传入本地为准，本地图片地址必须在docments下，也就是u3d的Application.persistentDataPath路径。
