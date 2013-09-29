//
//  BSViewController.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-23.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSViewController.h"
#import "BasicShareKit.h"

#define kTCWeiboAppKey       @"801213517"
#define kTCWeiboAppSecret    @"9819935c0ad171df934d0ffb340a3c2d"
#define kTCWeiboRedirectURI  @"http://www.ying7wang7.com"

#define kSinaWeiboAppKey          @"3601604349"
#define kSinaWeiboAppSecret       @"7894dfdd1fc2ce7cc6e9e9ca620082fb"
#define kSinaWeiboRedirectURI     @"http://hi.baidu.com/jt_one"

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
@interface BSViewController ()<BSShareActionSheetDelegate, BSRebroadcastMsgViewControllerDelegate>

@end

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
@implementation BSViewController
{
    BasicShareType _shareType;
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Properties

//////////////////////////////////////////////////////////////////////////////////////////
@synthesize weiboApi  = _weiboApi;
@synthesize sinaWeibo = _sinaWeibo;

//////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    [_weiboApi release];
    [_sinaWeibo release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (self.weiboApi == nil)
    {
        self.weiboApi = [[WeiboApi alloc] initWithAppKey:kTCWeiboAppKey andSecret:kTCWeiboAppSecret andRedirectUri:kTCWeiboRedirectURI] ;
    }
    
    
    if (self.sinaWeibo == nil)
    {
        self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kSinaWeiboAppKey
                                                 appSecret:kSinaWeiboAppSecret
                                            appRedirectURI:kSinaWeiboRedirectURI
                                               andDelegate:self];
    }
    
    /*
    UIButton *btnHometimeline = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnHometimeline setFrame:CGRectMake(40, 200, 240, 40)];
    [btnHometimeline setTitle:@"获取主时间线" forState:UIControlStateNormal];
    [btnHometimeline addTarget:self action:@selector(onGetHometimeline) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHometimeline];
    */
    
    UIButton *btnAddPic = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnAddPic setFrame:CGRectMake(40, 250, 240, 40)];
    [btnAddPic setTitle:@"发表带图微博" forState:UIControlStateNormal];
    [btnAddPic addTarget:self action:@selector(addPicBtnPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddPic];
}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击登录按钮
- (void)onGetHometimeline
{
    /*
    NSString *postStatusText = @"sina weibo test q";
    
    [self.sinaWeibo requestWithURL:@"statuses/update.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                        httpMethod:@"POST"
                          delegate:self];
    [self.sinaWeibo requestWithURL:@"statuses/upload.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", [UIImage imageNamed:@"icon.png"], @"pic", nil]httpMethod:@"POST" delegate:self];
    
    */
    /*
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"0",  @"pageflag",
                                   @"30", @"reqnum",
                                   @"0",  @"type",
                                   @"0",  @"contenttype",
                                   nil];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          delegate:self];
    */
}

// 点击登录按钮
- (IBAction)addPicBtnPushed:(id)sender
{
    BSShareActionSheet *shareActionSheet = [[[BSShareActionSheet alloc] initWithShareList:DefaultShareList() shareActionSheetDelegate:self] autorelease] ;
    [shareActionSheet showInView:self.view];
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BSShareActionSheetDelegate

//////////////////////////////////////////////////////////////////////////////////////////
- (void)shareActionSheet:(BSShareActionSheet *)shareActionSheet didSelectWithShareType:(BasicShareType)shareType
{
    NSLog(@" %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    _shareType = shareType;
    if (shareType == BasicShareTypeSinaWeibo)
    {
        if (self.sinaWeibo.isAuthValid)
        {
            DispatchUI(^{
                NSDictionary *parameter = @{
                                            BSRebroadcastMsgViewControllerTextReadyPost:@"BasicShareKit",
                                            BSRebroadcastMsgViewControllerImageReadyPost:[UIImage imageNamed:@"test"]
                                            };
                BSRebroadcastMsgViewController *vc = [[[BSRebroadcastMsgViewController alloc] initwithParameter:parameter rebroadcastMsgViewControllerDelegate:self] autorelease];
                UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
                [self presentModalViewController:nav animated:YES];
            });
        }
        else
        {   DispatchUI(^{
                [self.sinaWeibo logIn];
            });
        }
    }
    else if (shareType == BasicShareTypeTencentWeibo)
    {
        if (self.weiboApi.isAuthValid)
        {
            DispatchUI(^{
                NSDictionary *parameter = @{
                                            BSRebroadcastMsgViewControllerTextReadyPost:@"BasicShareKit",
                                            BSRebroadcastMsgViewControllerImageReadyPost:[UIImage imageNamed:@"test"]
                                            };
                BSRebroadcastMsgViewController *vc = [[[BSRebroadcastMsgViewController alloc] initwithParameter:parameter rebroadcastMsgViewControllerDelegate:self] autorelease];
                UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
                [self presentModalViewController:nav animated:YES];
            });
        }
        else
        {
            [self.weiboApi loginWithDelegate:self andRootController:self];
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BSRebroadcastMsgViewControllerDelegate

//////////////////////////////////////////////////////////////////////////////////////////
- (void)rebroadcastMsgViewController:(BSBaseRebroadcastMsgViewController *)rebroadcastMsgViewController didFinishEditingContentWithInfo:(NSDictionary *)infoReadyPost
{
    NSLog(@"---> %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSString *textReadyPost  = [infoReadyPost objectForKey:BSRebroadcastMsgViewControllerTextReadyPost];
    NSString *imageReadyPost = [infoReadyPost objectForKey:BSRebroadcastMsgViewControllerImageReadyPost];
    if (_shareType == BasicShareTypeTencentWeibo)
    {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                       @"json", @"format",
                                       textReadyPost, @"content",
                                       imageReadyPost, @"pic",
                                       nil];
        [self.weiboApi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
        [params release];
    }
    else if (_shareType == BasicShareTypeSinaWeibo)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       textReadyPost, @"status",
                                       imageReadyPost, @"pic",
                                       nil];
        [self.sinaWeibo requestWithURL:@"statuses/upload.json"
                                params:params
                            httpMethod:@"POST"
                              delegate:self];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)rebroadcastMsgViewControllerDidCancel:(BSBaseRebroadcastMsgViewController *)rebroadcastMsgViewController
{
    NSLog(@"---> %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeiboAuthDelegate

//////////////////////////////////////////////////////////////////////////////////////////
/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApi *)wbapi
{
    NSString *str = [[NSString alloc] initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r",
                     wbapi.accessToken, wbapi.openid, wbapi.appKey, wbapi.appSecret];
    NSLog(@"result = %@ \r\n", str);
    [str release];
    
    NSDictionary *parameter = @{
                                BSRebroadcastMsgViewControllerTextReadyPost:@"BasicShareKit",
                                BSRebroadcastMsgViewControllerImageReadyPost:[UIImage imageNamed:@"test"]
                                };
    BSRebroadcastMsgViewController *vc = [[[BSRebroadcastMsgViewController alloc] initwithParameter:parameter rebroadcastMsgViewControllerDelegate:self] autorelease];
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nav animated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////
/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    NSLog(@"result = %@ \r\n", str);
    [str release];
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeiboRequestDelegate

//////////////////////////////////////////////////////////////////////////////////////////
/**
 * @brief   接口调用成功后的回调
 * @param   INPUT   data    接口返回的数据
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    NSString *strResult = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    // [NSString stringWithCharacters:[data bytes] length:[data length]];
    NSLog(@"result = %@ \r\n",strResult);
    [strResult release];
 
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"分享成功"
                                                     message:@"提示"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

//////////////////////////////////////////////////////////////////////////////////////////
/**
 * @brief   接口调用失败后的回调
 * @param   INPUT   error   接口返回的错误信息
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    NSLog(@"result = %@ \r\n", str);
    [str release];
}


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - SinaWeiboDelegate

//////////////////////////////////////////////////////////////////////////////////////////
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSDictionary *parameter = @{
                                BSRebroadcastMsgViewControllerTextReadyPost:@"BasicShareKit",
                                BSRebroadcastMsgViewControllerImageReadyPost:[UIImage imageNamed:@"test"]
                                };
    BSRebroadcastMsgViewController *vc = [[[BSRebroadcastMsgViewController alloc] initwithParameter:parameter rebroadcastMsgViewControllerDelegate:self] autorelease];
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nav animated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{

}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{

}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - SinaWeiboRequestDelegate

//////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:@"提示"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil] autorelease];
    [alert show];
}

//////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"分享成功"
                                                     message:@"提示"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
    NSLog(@"---> %@ ", NSStringFromSelector(_cmd));
    NSLog(@"---> %@ ", result);
}

@end
