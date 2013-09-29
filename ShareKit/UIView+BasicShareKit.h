//
//  UIView+BasicShareKit.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BasicShareKit)

/**
 *	@brief	获取barButtonItem
 *
 *	@return	barButtonItem
 */
- (UIBarButtonItem *)barButtonItem;

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (void)removeAllSubviews;

@end
