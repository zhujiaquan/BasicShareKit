//
//  UIButton+BasicShareKit.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "UIButton+BasicShareKit.h"

@implementation UIButton (BasicShareKit)

+ (id)buttonWithImageNamed:(NSString *)imageName
     highlightedImageNamed:(NSString *)highlightedImageName
         selectedImageName:(NSString *)selectedImageName
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImageName:imageName
			  highlightedImageName:highlightedImageName
				 selectedImageName:selectedImageName];
	return button;
}

+ (id)buttonWithImageNamed:(NSString *)imageName
     highlightedImageNamed:(NSString *)highlightedImageName
         selectedImageName:(NSString *)selectedImageName
              leftCapWidth:(CGFloat)leftCap
              topCapHeight:(CGFloat)topCap
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImageName:imageName
			  highlightedImageName:highlightedImageName
				 selectedImageName:selectedImageName
					  leftCapWidth:leftCap
					  topCapHeight:topCap];
	return button;
}

- (void)setGloablBackgroundImageName:(NSString *)imageName
                highlightedImageName:(NSString *)highlightedImageName
                   selectedImageName:(NSString *)selectedImageName
{
	UIImage *image = [UIImage imageNamed:imageName];
	UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
	
	[self setBackgroundImage:image forState:UIControlStateNormal];
	[self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	[self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    
    CGRect frame = self.frame;
    frame.size = image.size;
    [self setFrame:frame];
}

- (void)setBackgroundImageName:(NSString *)imageName
          highlightedImageName:(NSString *)highlightedImageName
             selectedImageName:(NSString *)selectedImageName
{
	UIImage *image = [UIImage imageNamed:imageName];
	UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
	
	[self setBackgroundImage:image forState:UIControlStateNormal];
	[self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	[self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    
    CGRect frame = self.frame;
    frame.size = image.size;
    [self setFrame:frame];
}

- (void)setGlobalBackgroundImageName:(NSString *)imageName
                highlightedImageName:(NSString *)highlightedImageName
                   selectedImageName:(NSString *)selectedImageName
                        leftCapWidth:(CGFloat)leftCap
                        topCapHeight:(CGFloat)topCap
{
	UIImage *image = [UIImage imageNamed:imageName];
	UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
	if (leftCap == CGFLOAT_MIN)
    {
		leftCap = floorf((image.size.width - 0.5f) * 0.5f);
    }
	if (topCap == CGFLOAT_MIN)
    {
		topCap = floorf((image.size.height - 0.5f) * 0.5f);
    }
	
	if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
		UIEdgeInsets capInsets = UIEdgeInsetsMake(topCap, leftCap, topCap, leftCap);
		image = [image resizableImageWithCapInsets:capInsets];
		highlightedImage = [highlightedImage resizableImageWithCapInsets:capInsets];
		selectedImage = [selectedImage resizableImageWithCapInsets:capInsets];
    }
	else
    {
		image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
		highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
		selectedImage = [selectedImage stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    }
    
	[self setBackgroundImage:image forState:UIControlStateNormal];
	[self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	[self setBackgroundImage:selectedImage forState:UIControlStateSelected];
}

- (void)setBackgroundImageName:(NSString *)imageName
          highlightedImageName:(NSString *)highlightedImageName
             selectedImageName:(NSString *)selectedImageName
                  leftCapWidth:(CGFloat)leftCap
                  topCapHeight:(CGFloat)topCap
{
	UIImage *image = [UIImage imageNamed:imageName];
	UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
	if (leftCap == CGFLOAT_MIN)
    {
		leftCap = floorf((image.size.width - 0.5f) * 0.5f);
    }
	if (topCap == CGFLOAT_MIN)
    {
		topCap = floorf((image.size.height - 0.5f) * 0.5f);
    }
	
	if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
		UIEdgeInsets capInsets = UIEdgeInsetsMake(topCap, leftCap, topCap, leftCap);
		image = [image resizableImageWithCapInsets:capInsets];
		highlightedImage = [highlightedImage resizableImageWithCapInsets:capInsets];
		selectedImage = [selectedImage resizableImageWithCapInsets:capInsets];
    }
	else
    {
		image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
		highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
		selectedImage = [selectedImage stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    }
    
	[self setBackgroundImage:image forState:UIControlStateNormal];
	[self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
	[self setBackgroundImage:selectedImage forState:UIControlStateSelected];
}

@end
