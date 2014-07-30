//
//  U3DWeiboAuthorize.m
//  Unity-iPhone
//
//  Created by luzexi on 14-7-29.
//
//

#import "WeiboSDK.h"

#import "U3DWebiSDK.h"



@implementation U3DWeiboAuthorize

static U3DWeiboAuthorize * weibo_authorize;
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
    [U3DWebiSDK setCode:@"code"];
}


+(U3DWeiboAuthorize *)getInstance
{
    if(weibo_authorize == nil)
        weibo_authorize = [[U3DWeiboAuthorize alloc] init];
    return weibo_authorize;
}

@end
