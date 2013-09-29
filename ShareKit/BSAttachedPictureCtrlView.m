//
//  BSAttachedPictureCtrlView.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-27.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSAttachedPictureCtrlView.h"
#import "UIImage+BasicShareKit.h"
#import <QuartzCore/QuartzCore.h>

#define kBundleName @"BasicShareKit.bundle"

///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSAttachedPictureCtrlView

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize attachedPictureCtrlViewDelegate = _attachedPictureCtrlViewDelegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        _imageViewContainer = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [_imageViewContainer setUserInteractionEnabled:YES];
        [self addSubview:_imageViewContainer];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    _attachedPictureCtrlViewDelegate = nil;
    [_imageViewContainer release], _imageViewContainer = nil;
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAttachedImage:(UIImage *)attachedImage
{
	UIImageView *imageViewBefore = (UIImageView *)[self viewWithTag:kCtrlViewImageTag];
	if (imageViewBefore)
    {
		[imageViewBefore removeFromSuperview];
	}
    
	CGSize size = attachedImage.size;
	NSInteger frameWidth  = kImageMaxWidth;
	NSInteger frameHeight = kImageMaxHeight;
    
	if (size.height < kImageMaxHeight - 0.01f && size.width < kImageMaxWidth - 0.01f)
    {
		frameWidth = attachedImage.size.width;
		frameHeight = attachedImage.size.height;
	}
	else
    {
		CGFloat h = (kImageMaxHeight / size.height);
		CGFloat w = (kImageMaxWidth / size.width);
		if (h > w)
        {
			frameWidth = kImageMaxWidth;
			frameHeight = size.height * w;
		}
		else
        {
			frameWidth = size.width * h;
			frameHeight = kImageMaxHeight;
		}
	}
    
    _imageViewContainer.frame = CGRectMake((kImageMaxWidth - frameWidth)/2.0f, (kImageMaxHeight - frameHeight)/2.0f, frameWidth, frameHeight);
	_imageViewContainer.image = [UIImage imageNamed:@"RebroadcaseMsg/bg_composepic_border" bundleName:kBundleName];
    _imageViewContainer.layer.masksToBounds = YES;
	_imageViewContainer.layer.cornerRadius = 3.0f;
    
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3.0f, 3.0f, frameWidth - 6.0f, frameHeight - 6.0f)];
	[imageView setUserInteractionEnabled:YES];
	imageView.image = attachedImage;
	imageView.tag = kCtrlViewImageTag;
	[_imageViewContainer addSubview:imageView];
	[imageView release];
    
	UIButton *delBtnBefore = (UIButton *)[self viewWithTag:kCtrlViewDeleteBtnTag];
	if (delBtnBefore)
    {
		[delBtnBefore removeFromSuperview];
	}
    
	UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	delBtn.frame = CGRectMake((kImageMaxWidth - frameWidth)/2.0f - 8.0f, (kImageMaxHeight - frameHeight)/2.0f - 8.0f, 20, 20);
	delBtn.tag = kCtrlViewDeleteBtnTag;
    UIImage *btnImage = [UIImage imageNamed:@"RebroadcaseMsg/button_image_del" bundleName:kBundleName];
	[delBtn setImage:btnImage forState:UIControlStateNormal];
    [delBtn setImage:btnImage forState:UIControlStateHighlighted];
	[delBtn addTarget:self action:@selector(delBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:delBtn];
	
	UIButton *delBtnBeforeBase = (UIButton *)[self viewWithTag:kCtrlViewDeleteBtnTag + 3];
	if (delBtnBeforeBase)
    {
		[delBtnBeforeBase removeFromSuperview];
	}
	UIButton *delBtnBase = [UIButton buttonWithType:UIButtonTypeCustom];
	delBtnBase.frame = CGRectMake((kImageMaxWidth - frameWidth)/2.0f - 10.0f, (kImageMaxHeight - frameHeight)/2.0f - 10.0f, 58, 58);
	delBtnBase.tag = kCtrlViewDeleteBtnTag + 3;
	[delBtnBase addTarget:self action:@selector(delBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:delBtnBase];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)delBtnClicked
{
	if ([self.attachedPictureCtrlViewDelegate respondsToSelector:@selector(deleteButtonClickedWithAttachedPictureCtrlView:)])
    {
		[self.attachedPictureCtrlViewDelegate deleteButtonClickedWithAttachedPictureCtrlView:self];
	}
}

@end
