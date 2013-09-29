//
//  UIImage+BasicShareKit.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BasicShareKit)

/**
 *	@brief	获取图片对象
 *
 *	@param 	name 	图片名称
 *	@param 	bundleName 	Bundle名称
 *
 *	@return	图片对象
 */
+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString *)bundleName;

@end
