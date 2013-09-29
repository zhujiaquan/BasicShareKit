//
//  BSAttachedPictureCtrlView.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-27.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCtrlViewTagBase		20000
#define kCtrlViewDeleteBtnTag	(kCtrlViewTagBase + 1)
#define	kCtrlViewImageTag		(kCtrlViewTagBase + 2)

#define kImageMaxWidth	 180.0f
#define kImageMaxHeight	 180.0f

@protocol BSAttachedPictureCtrlViewDelegate;

@interface BSAttachedPictureCtrlView : UIView
{
    UIImageView *_imageViewContainer;
    id<BSAttachedPictureCtrlViewDelegate> _attachedPictureCtrlViewDelegate;
}

@property (nonatomic, assign) id<BSAttachedPictureCtrlViewDelegate> attachedPictureCtrlViewDelegate;

- (void)setAttachedImage:(UIImage *)attachedImage;

@end

@protocol BSAttachedPictureCtrlViewDelegate <NSObject>

- (void)deleteButtonClickedWithAttachedPictureCtrlView:(BSAttachedPictureCtrlView *)attachedPictureCtrlView;

@end