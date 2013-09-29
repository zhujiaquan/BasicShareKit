//
//  BasicShareTypeDef.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#ifndef __BASIC_SHARE_TYPE_DEF_H__
#define __BASIC_SHARE_TYPE_DEF_H__

#import "UIImage+BasicShareKit.h"

/**
 *	分享平台类型
 */
typedef NS_ENUM(NSInteger, BasicShareType) {
    BasicShareTypeSinaWeibo = 1,      /** 新浪微博 */
	BasicShareTypeTencentWeibo = 2,   /** 腾讯微博 */
    BasicShareTypeMail = 18,          /**< 邮件分享 */
	BasicShareTypeSMS = 19,           /**< 短信分享 */
    BasicShareTypeWeixiSession = 22,  /** 微信好友 */
	BasicShareTypeWeixiTimeline = 23, /** 微信朋友圈 */
};

/**
 *	@brief	将BasicShareType转换为NSNumber类型
 *
 *	@param 	type 	分享平台类型
 */
#define SHARE_TYPE_TO_NUMBER( __TYPE__ ) [NSNumber numberWithInteger:__TYPE__]

/**
 *	@brief	将NSNumber转换为BasicShareType类型
 *
 *	@param 	type 	分享平台类型
 */
#define SHARE_TYPE_FROM_NUMBER( __NUMBER__ ) ((BasicShareType)[__NUMBER__ intValue])

/**
 *	@brief	默认一键分享列表
 *
 *	@return	一键分享列表数组
 */
static NSArray *DefaultShareList()
{
    return @[SHARE_TYPE_TO_NUMBER(BasicShareTypeSinaWeibo),
             SHARE_TYPE_TO_NUMBER(BasicShareTypeTencentWeibo),
//             SHARE_TYPE_TO_NUMBER(BasicShareTypeWeixiSession),
//             SHARE_TYPE_TO_NUMBER(BasicShareTypeWeixiTimeline),
//             SHARE_TYPE_TO_NUMBER(BasicShareTypeMail),
//             SHARE_TYPE_TO_NUMBER(BasicShareTypeSMS)
             ];
}

/**
 *	@brief	默认一键分享列表
 *
 *	@return	一键分享列表数组
 */
#define DEFAULT_SHARE_LIST DefaultShareList()

/**
 *	@brief	根据shareType获取title
 *  @param  shareType 分享平台类型
 *	@return	title
 */
static NSString *ShareTitleWithType(BasicShareType shareType)
{
    NSString *title = nil;
    switch (shareType)
    {
        case BasicShareTypeSinaWeibo:
            title = @"新浪微博";
            break;
        
        case BasicShareTypeTencentWeibo:
            title = @"腾讯微博";
            break;
        
        case BasicShareTypeMail:
            title = @"邮件分享";
            break;
            
        case BasicShareTypeSMS:
            title = @"短信分享";
            break;
            
        case BasicShareTypeWeixiSession:
            title = @"微信好友";
            break;
            
        case BasicShareTypeWeixiTimeline:
            title = @"微信朋友圈";
            break;
            
        default:
            title = @"Unknow";
            break;
    }
    return title;
}

/**
 *	@brief	根据shareType获取icon
 *  @param  shareType 分享平台类型
 *	@return	icon
 */
static UIImage *ShareIconWithType(BasicShareType shareType)
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"/Icon/sns_icon_%d", shareType]
                    bundleName:@"BasicShareKit.bundle"];
}

#endif
