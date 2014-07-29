//
//  U3DWebiSDK.m
//  WeiboSDKLibDemo
//
//  Created by luzexi on 14-7-28.
//  Copyright (c) 2014年 SINA iOS Team. All rights reserved.
//

#include "UnityAppController.h"
#import "WeiboSDK.h"

@interface U3DWebiSDK : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>
{
    NSString* wbtoken;
    NSString *gameObjectName;
}

@property (strong, retain) NSString* wbtoken;

@end


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end



@interface U3DWebiSDK ()

@end

@implementation U3DWebiSDK

@synthesize wbtoken;

- (id)init:(const char *)gameobjName
{
    self = [super init];
    gameObjectName = [[NSString stringWithUTF8String:gameobjName] retain];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"2932651019"];
    return self;
}

- (void)dealloc
{
    [gameObjectName release];
    [super dealloc];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        //send success.
        const char * gameObjName = [gameObjectName cStringUsingEncoding:NSUTF8StringEncoding];
        UnitySendMessage(gameObjName, "OnRequest", "ok");
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        [alert show];
        [alert release];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = @"测试通过WeiboSDK发送文字到微博!";
    
//    WBImageObject *image = [WBImageObject object];
//    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
//    message.imageObject = image;
    
//    if (self.mediaSwitch.on)
//    {
//        WBWebpageObject *webpage = [WBWebpageObject object];
//        webpage.objectID = @"identifier1";
//        webpage.title = @"分享网页标题";
//        webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
//        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//        webpage.webpageUrl = @"http://sina.cn?a=1";
//        message.mediaObject = webpage;
//    }
    
    return message;
}

static U3DWebiSDK * weibo_sdk = nil;

extern "C"{

    void _weiboInit(const char * gameobjectName)
    {
        weibo_sdk = [[U3DWebiSDK alloc] init:gameobjectName ];
    }
    
    void _weiboShare()
    {
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[weibo_sdk messageToShare]];
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        //request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        
        [WeiboSDK sendRequest:request];
        
//        WBProvideMessageForWeiboRequest *request = [WBProvideMessageForWeiboRequest requestWithMessage:[weibo_sdk messageToShare]];
//        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//        //request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//        
//        [WeiboSDK sendRequest:request];
        
        ////////
        
//        WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:[weibo_sdk messageToShare]];
//        //request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//        
//        [WeiboSDK sendResponse:response];
    }
}

@end
