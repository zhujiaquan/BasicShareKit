//
//  BSFullShareViewController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSBaseRebroadcastMsgViewController.h"

@class BSPlaceHolderTextView;
@class BSAttachedPictureView;
@class BSAttachedPictureCtrlView;

@interface BSRebroadcastMsgViewController : BSBaseRebroadcastMsgViewController<UITextViewDelegate>
{
    UIView *_viewDownContainer;
    BSAttachedPictureView *_attachedImageView;
    BSAttachedPictureCtrlView *_attachedPictureCtrlView;
    UIImage *_imageReadyPost;
    NSString *_textReadyPost;
}

@property (nonatomic, retain) BSPlaceHolderTextView *editorTextView;
@property (nonatomic, retain) UIView      *toolView;
@property (nonatomic, retain) UIButton    *cameraButton;
@property (nonatomic, retain) UIButton    *pictureButton;
@property (nonatomic, retain) UILabel     *totalLabel;

@property (nonatomic, retain) UIImage  *imageReadyPost;
@property (nonatomic, retain) NSString *textReadyPost;

@end
