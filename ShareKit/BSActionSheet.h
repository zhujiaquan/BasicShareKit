//
//  BSActionSheet.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-24.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class BSActionSheetCell;

@protocol BSActionSheetDelegate <NSObject>

- (BSActionSheetCell *)cellForActionAtIndex:(NSInteger)index;

- (void)didTapOnItemAtIndex:(NSInteger)index;

@end

@interface BSActionSheet : UIActionSheet

- (id)initwithIconSheetDelegate:(id<BSActionSheetDelegate>)delegate itemCount:(int)count;

@end

@interface BSActionSheetCell : UIView

@property (nonatomic, retain) UIImageView  *iconView;
@property (nonatomic, retain) UILabel      *titleLabel;
@property (nonatomic, assign) int          index;

@end

@interface BSWeiboActionSheet : BSActionSheet<BSActionSheetDelegate>

- (id)initWithActionBlock:(void(^)(NSString *buttonTitle))actionBlock;

@end
