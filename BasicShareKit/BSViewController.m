//
//  BSViewController.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-23.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSViewController.h"
#import "BSActionSheet.h"

#define kTCWeiboAppKey       @"801213517"
#define kTCWeiboAppSecret    @"9819935c0ad171df934d0ffb340a3c2d"
#define kTCWeiboRedirectURI  @"http://www.ying7wang7.com"

#define kSinaWeiboAppKey          @"3601604349"
#define kSinaWeiboAppSecret       @"7894dfdd1fc2ce7cc6e9e9ca620082fb"
#define kSinaWeiboRedirectURI     @"http://hi.baidu.com/jt_one"

//#define kSinaWeiboAppKey          @"1627282080"
//#define kSinaWeiboAppSecret       @"033f5d7eeb4d40508b304c94fad4eeef"
//#define kSinaWeiboRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface BSViewController ()<BSActionSheetDelegate>

@end

@implementation BSViewController

@synthesize weiboApi  = _weiboApi;
@synthesize sinaWeibo = _sinaWeibo;

- (void)dealloc
{
    [_weiboApi release];
    [_sinaWeibo release];
    [super dealloc];
}

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
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLogin setFrame:CGRectMake(40, 100, 240, 40)];
    [btnLogin setTitle:@"授权" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    
    UIButton *btnHometimeline = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnHometimeline setFrame:CGRectMake(40, 200, 240, 40)];
    [btnHometimeline setTitle:@"获取主时间线" forState:UIControlStateNormal];
    [btnHometimeline addTarget:self action:@selector(onGetHometimeline) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHometimeline];
    
    
    UIButton *btnAddPic = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnAddPic setFrame:CGRectMake(40, 250, 240, 40)];
    [btnAddPic setTitle:@"发表带图微博" forState:UIControlStateNormal];
    [btnAddPic addTarget:self action:@selector(onAddPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddPic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击登录按钮
- (void)onLogin
{
    [[[[BSWeiboActionSheet alloc] initWithActionBlock:^(NSString *buttonTitle) {
        
    }] autorelease] showInView:self.view];
    
    // [self.sinaWeibo logIn];
    // [self.weiboApi loginWithDelegate:self andRootController:self];
}

// 点击登录按钮
- (void)onGetHometimeline
{
    // NSLog(@"sina weibo test");
    
    NSString *postStatusText = @"sina weibo test q";
    
    /*
    [self.sinaWeibo requestWithURL:@"statuses/update.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                        httpMethod:@"POST"
                          delegate:self];
    */
    
    [self.sinaWeibo requestWithURL:@"statuses/upload.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", [UIImage imageNamed:@"icon.png"], @"pic", nil]httpMethod:@"POST" delegate:self];
    
    
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
    /*
    if (self.weiboApi.isAuthValid)
    {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"0",  @"pageflag",
                                   @"30", @"reqnum",
                                   @"0",  @"type",
                                   @"0",  @"contenttype",
                                   nil];
        [self.weiboApi requestWithParams:params apiName:@"statuses/home_timeline" httpMethod:@"GET" delegate:self];
        [params release];
    }
    else
    {
        [self.weiboApi loginWithDelegate:self andRootController:self];
    }
    */
}

// 点击登录按钮
- (void)onAddPic
{
    if (self.weiboApi.isAuthValid)
    {
        UIImage *pic = [UIImage imageNamed:@"icon.png"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                       @"json",@"format",
                                       @"BasicShareKit", @"content",
                                       pic, @"pic",
                                       nil];
    
        [self.weiboApi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
        [pic release];
        [params release];
    }
    else
    {
        [self.weiboApi loginWithDelegate:self andRootController:self];
    }
}

#pragma mark WeiboRequestDelegate

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
    
    // [self showMsg:strResult];
    [strResult release];
    
}
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
    
    // [self showMsg:str];
    [str release];
}



#pragma mark WeiboAuthDelegate

/**
 * @brief   重刷授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthRefreshed:(WeiboApi *)wbapi_
{
    
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r", wbapi_.accessToken, wbapi_.openid, wbapi_.appKey, wbapi_.appSecret];
    
    NSLog(@"result = %@ \r\n", str);
    
    // [self showMsg:str];
    [str release];
}

/**
 * @brief   重刷授权失败后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthRefreshFail:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    // [self showMsg:str];
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApi *)wbapi_
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r", wbapi_.accessToken, wbapi_.openid, wbapi_.appKey, wbapi_.appSecret];
    
    NSLog(@"result = %@ \r\n", str);
    
    // [self showMsg:str];
    
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
 * @return  无返回
 */
- (void)DidAuthCanceled:(WeiboApi *)wbapi_
{
    
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    NSLog(@"result = %@ \r\n", str);
    
    // [self showMsg:str];
    [str release];
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - SinaWeiboDelegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{

}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - SinaWeiboRequestDelegate

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"---> %@ ", NSStringFromSelector(_cmd));
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    NSLog(@"---> %@ ", NSStringFromSelector(_cmd));
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView* alert =
        [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                   message:@"提示"
                                  delegate:self
                         cancelButtonTitle:@"确定"
                         otherButtonTitles: nil];
    [alert show];
    NSLog(@"---> %@ ", NSStringFromSelector(_cmd));
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"---> %@ ", NSStringFromSelector(_cmd));
    NSLog(@"---> %@ ", result);
}   

- (BSActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    BSActionSheetCell* cell = [[[BSActionSheetCell alloc] init] autorelease];
    
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",index]];
    cell.index = index;
    return cell;
}

- (void)didTapOnItemAtIndex:(NSInteger)index
{
    NSLog(@"tap on %d",index);
}

@end
