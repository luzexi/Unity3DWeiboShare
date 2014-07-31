//
//  U3DWeiboAuth.m
//  Unity-iPhone
//
//  Created by luzexi on 14-7-29.
//
//




#import "WeiboSDK.h"
#import "U3DWeiboSDK.h"


@implementation U3DWeiboAuth
static U3DWeiboAuth * weibo_auth;


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
//    [U3DWeiboSDK setToken:@"ddd"];
    //
    NSLog(@"========= RESPONSE %@",response);

////
}


+(U3DWeiboAuth *) getInstance
{
    if(weibo_auth == nil)
        weibo_auth = [[U3DWeiboAuth alloc] init];
    return weibo_auth;
}

@end
