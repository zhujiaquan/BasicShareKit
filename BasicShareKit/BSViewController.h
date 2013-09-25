//
//  BSViewController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-23.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboApi.h"
#import "SinaWeibo.h"

@interface BSViewController : UIViewController<WeiboRequestDelegate, WeiboAuthDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate>

@property (nonatomic, retain) WeiboApi *weiboApi;
@property (nonatomic, retain) SinaWeibo *sinaWeibo;

@end
