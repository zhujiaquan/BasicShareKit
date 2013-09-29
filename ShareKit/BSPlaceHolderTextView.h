//
//  BSPlaceHolderTextView.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPlaceHolderTextView : UITextView
{
    NSString *_placeholder;
    UIColor  *_placeholderColor;
    UILabel  *_placeHolderLabel;
}

@property (nonatomic, retain) UILabel  *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor  *placeholderColor;

@end
