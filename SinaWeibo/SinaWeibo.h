//
//  SinaWeibo.h
//  sinaweibo_ios_sdk
//
//  Created by Wade Cheng on 4/19/12.
//  Copyright (c) 2012 SINA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeiboAuthorizeView.h"
#import "SinaWeiboRequest.h"

@protocol SinaWeiboDelegate;

@interface SinaWeibo : NSObject <SinaWeiboAuthorizeViewDelegate, SinaWeiboRequestDelegate>
{
    NSString *userID;
    NSString *accessToken;
    NSDate *expirationDate;
    id<SinaWeiboDelegate> delegate;
    
    NSString *appKey;
    NSString *appSecret;
    NSString *appRedirectURI;
    NSString *ssoCallbackScheme;
    
    SinaWeiboRequest *request;
    NSMutableSet *requests;
    BOOL ssoLoggingIn;
}

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSDate *expirationDate;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *ssoCallbackScheme;
@property (nonatomic, assign) id<SinaWeiboDelegate> delegate;

- (id)initWithAppKey:(NSString *)appKey 
           appSecret:(NSString *)appSecrect
      appRedirectURI:(NSString *)appRedirectURI
         andDelegate:(id<SinaWeiboDelegate>)delegate;

- (id)initWithAppKey:(NSString *)appKey 
           appSecret:(NSString *)appSecrect
      appRedirectURI:(NSString *)appRedirectURI
   ssoCallbackScheme:(NSString *)ssoCallbackScheme
         andDelegate:(id<SinaWeiboDelegate>)delegate;

- (void)applicationDidBecomeActive;
- (BOOL)handleOpenURL:(NSURL *)url;

// Log in using OAuth Web authorization.
// If succeed, sinaweiboDidLogIn will be called.
- (void)logIn;

// cancel auth.
// If succeed, sinaweiboDidLogOut will be called.
- (void)cancelAuth;

// Check if user has logged in, or the authorization is expired.
/**
 *  @brief  判断是否已经授权
 *  @return YES 已经授权
 *  @return NO  尚未授权
 */
- (BOOL)isAuthed;

/**
 *  @brief  判断授权是否已经到期
 *  @return YES 已经过期
 *  @return NO  尚未过期
 */
- (BOOL)isAuthorizeExpired;


// isAuthed && isAuthorizeExpired
- (BOOL)isAuthValid;

- (SinaWeiboRequest*)requestWithURL:(NSString *)url
                             params:(NSMutableDictionary *)params
                         httpMethod:(NSString *)httpMethod
                           delegate:(id<SinaWeiboRequestDelegate>)delegate;

@end


/**
 * @description 第三方应用需实现此协议，登录时传入此类对象，用于完成登录结果的回调
 */
@protocol SinaWeiboDelegate <NSObject>

@optional

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo;
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo;
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo;
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error;
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error;

@end

extern BOOL SinaWeiboIsDeviceIPad();
