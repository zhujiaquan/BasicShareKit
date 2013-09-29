//
//  BSAttachedPictureView.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-27.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFrameImageTag	    10000
#define kAttachedImageTag	(kFrameImageTag + 1)

#define kMinWidth  44.0f
#define kMinHeight 33.0f

@protocol BSAttachedPictureViewDelegate;

@interface BSAttachedPictureView : UIView
{
    id<BSAttachedPictureViewDelegate> _attachedPictureViewDelegate;
}

@property (nonatomic, assign) id<BSAttachedPictureViewDelegate> attachedPictureViewDelegate;

- (void)setAttachedImage:(UIImage *)attachedImage;

@end

@protocol BSAttachedPictureViewDelegate<NSObject>

@optional
- (void)didClickedAttachedPictureView:(BSAttachedPictureView *)attachedPictureView;

@end
