//
//  BSAttachedPictureView.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-27.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSAttachedPictureView.h"
#import "UIImage+BasicShareKit.h"

#define kBundleName @"BasicShareKit.bundle"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSAttachedPictureView

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize attachedPictureViewDelegate = _attachedPictureViewDelegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
    {
    _attachedPictureViewDelegate = nil;
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAttachedImage:(UIImage *)attachedImage
{
	UIImageView *oldAttachedImageView = (UIImageView *)[self viewWithTag:kAttachedImageTag];
	if (oldAttachedImageView)
    {
		[oldAttachedImageView removeFromSuperview];
	}
    
	UIImageView *attachedImageView = [[UIImageView alloc] initWithImage:attachedImage];
	attachedImageView.frame = CGRectMake(16, 5.0f, 24, 24);
	attachedImageView.tag = kAttachedImageTag;
	[attachedImageView setUserInteractionEnabled:YES];
	[self addSubview:attachedImageView];
    
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
	[attachedImageView addGestureRecognizer:tapGesture];
	[tapGesture release];
    [attachedImageView release];
	
	UIButton *oldFrameBtn = (UIButton *)[self viewWithTag:kFrameImageTag];
	if (oldFrameBtn)
    {
		[oldFrameBtn removeFromSuperview];
	}
	
    UIButton *frameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	frameBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	frameBtn.tag = kFrameImageTag;
    UIImage *imageFrame = [UIImage imageNamed:@"RebroadcaseMsg/bg_compose_image_frame" bundleName:kBundleName];
    [frameBtn setImage:imageFrame forState:UIControlStateNormal];
	[frameBtn setImage:imageFrame forState:UIControlStateHighlighted];
	[frameBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:frameBtn];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect rect = self.frame;
    if (rect.size.width < kMinWidth)
    {
        rect.size.width = kMinWidth;
    }
    if (rect.size.height < kMinHeight)
    {
        rect.size.height = kMinHeight;
    }
    self.frame = rect;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)btnClicked
{	
	if ([self.attachedPictureViewDelegate respondsToSelector:@selector(didClickedAttachedPictureView:)])
    {
		[self.attachedPictureViewDelegate didClickedAttachedPictureView:self];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)imageTaped:(UITapGestureRecognizer *)recognizer
{
	[self btnClicked];
}

@end
