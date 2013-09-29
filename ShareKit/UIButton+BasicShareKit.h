//
//  UIButton+BasicShareKit.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BasicShareKit)

+ (id)buttonWithImageNamed:(NSString *)imageName
     highlightedImageNamed:(NSString *)highlightedImageName
         selectedImageName:(NSString *)selectedImageName;

+ (id)buttonWithImageNamed:(NSString *)imageName
     highlightedImageNamed:(NSString *)highlightedImageName
         selectedImageName:(NSString *)selectedImageName
              leftCapWidth:(CGFloat)leftCap
              topCapHeight:(CGFloat)topCap;

- (void)setGloablBackgroundImageName:(NSString *)imageName
                highlightedImageName:(NSString *)highlightedImageName
                   selectedImageName:(NSString *)selectedImageName;

- (void)setBackgroundImageName:(NSString *)imageName
          highlightedImageName:(NSString *)highlightedImageName
             selectedImageName:(NSString *)selectedImageName;

- (void)setGlobalBackgroundImageName:(NSString *)imageName
                highlightedImageName:(NSString *)highlightedImageName
                   selectedImageName:(NSString *)selectedImageName
                        leftCapWidth:(CGFloat)leftCap
                        topCapHeight:(CGFloat)topCap;

- (void)setBackgroundImageName:(NSString *)imageName
          highlightedImageName:(NSString *)highlightedImageName
             selectedImageName:(NSString *)selectedImageName
                  leftCapWidth:(CGFloat)leftCap
                  topCapHeight:(CGFloat)topCap;

@end
