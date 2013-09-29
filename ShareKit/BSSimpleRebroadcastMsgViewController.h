//
//  BSSimpleShareViewController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSBaseRebroadcastMsgViewController.h"

@class BSPlaceHolderTextView;

@interface BSSimpleRebroadcastMsgViewController : BSBaseRebroadcastMsgViewController
{
    UIView   *_overlayView;
    UIView   *_shareView;
    UIButton *_cancelButton;
    UIButton *_sendButton;
    BSPlaceHolderTextView *_shareTextView;
}

- (void)showWithAnimated:(BOOL)animated;

@end
