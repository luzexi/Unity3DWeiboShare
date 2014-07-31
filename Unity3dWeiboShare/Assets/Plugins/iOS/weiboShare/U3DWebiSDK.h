//
//  Test.h
//  Unity-iPhone
//
//  Created by vika on 14-7-30.
//
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface U3DWeiboAuth : NSObject <WBHttpRequestDelegate>
+(U3DWeiboAuth *) getInstance;
@end


@interface U3DWeiboAuthorize : NSObject <WBHttpRequestDelegate>
+(U3DWeiboAuthorize *)getInstance;
@end

@interface U3DWeiboShare : NSObject <WBHttpRequestDelegate>
+(U3DWeiboShare *)getInstacne;
@end


@interface U3DWebiSDK : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>
{
	//
}

+(U3DWebiSDK *)getWeibo;

@end


