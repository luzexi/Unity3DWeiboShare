//
//  U3DWeiboShare.m
//  Unity-iPhone
//
//  Created by luzexi on 14-7-29.
//
//

#import "WeiboSDK.h"
#import "U3DWeiboSDK.h"

@implementation U3DWeiboShare
static U3DWeiboShare * weibo_share;

////
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    //
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    //
    NSLog(@"========= RESULT %@",result);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //
    NSLog(@"========= RESPONSE %@",response);
    //const char * objName = [[U3DWebiSDK gameObjectName] UTF8String];
    UnitySendMessage("WeiboShare", "OnShare", "ok");
}
////

+(U3DWeiboShare *)getInstacne
{
    if(weibo_share == nil)
        weibo_share = [[U3DWeiboShare alloc] init];
    return weibo_share;
}

@end
