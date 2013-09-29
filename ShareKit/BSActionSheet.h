//
//  BSActionSheet.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-24.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicShareTypeDef.h"

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


typedef void(^BSShareActionSheetActionBlock)(BasicShareType shareType);

@protocol BSShareActionSheetDelegate;

@interface BSShareActionSheet : BSActionSheet<BSActionSheetDelegate>
{
    id<BSShareActionSheetDelegate> _shareActionSheetDelegate;
    BSShareActionSheetActionBlock _actionBlock;
    NSArray *_shareList;
}

@property (nonatomic, assign, readonly) id<BSShareActionSheetDelegate> shareActionSheetDelegate;
@property (nonatomic, copy,   readonly) BSShareActionSheetActionBlock actionBlock;
@property (nonatomic, retain, readonly) NSArray *shareList;

- (id)initWithShareList:(NSArray *)shareList shareActionSheetDelegate:(id<BSShareActionSheetDelegate>)shareActionSheetDelegate;
- (id)initWithShareList:(NSArray *)shareList actionBlock:(BSShareActionSheetActionBlock)actionBlock;

@end

@protocol BSShareActionSheetDelegate <NSObject>

- (void)shareActionSheet:(BSShareActionSheet *)shareActionSheet didSelectWithShareType:(BasicShareType)shareType;

@end

