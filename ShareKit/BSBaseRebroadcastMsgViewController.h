//
//  BSBaseRebroadcastMsgViewController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

// info dictionary keys
UIKIT_EXTERN NSString *const BSRebroadcastMsgViewControllerTextReadyPost;      // an NSString
UIKIT_EXTERN NSString *const BSRebroadcastMsgViewControllerImageReadyPost;     // a UIImage

typedef void(^BSRebroadcastMsgViewControllerCompletionBlock)(NSDictionary *infoReadyPost);
typedef void(^BSRebroadcastMsgViewControllerCancelBlock)(void);

@protocol BSRebroadcastMsgViewControllerDelegate;

@interface BSBaseRebroadcastMsgViewController : UIViewController
{
    BSRebroadcastMsgViewControllerCompletionBlock _completionBlock;
    BSRebroadcastMsgViewControllerCancelBlock _cancelBlock;
    id<BSRebroadcastMsgViewControllerDelegate> _rebroadcastMsgViewControllerDelegate;
}

@property (nonatomic, copy,   readonly) BSRebroadcastMsgViewControllerCompletionBlock completionBlock;
@property (nonatomic, copy,   readonly) BSRebroadcastMsgViewControllerCancelBlock cancelBlock;
@property (nonatomic, assign, readonly) id<BSRebroadcastMsgViewControllerDelegate> rebroadcastMsgViewControllerDelegate;

/*
 * @param  parameter (NSDictionary *)@{BSRebroadcastMsgViewControllerTextReadyPost:(NSString *)textReadyPost, BSRebroadcastMsgViewControllerImageReadyPost:(UIImage *)imageReadyPost}
 */
- (id)initWithParameter:(NSDictionary *)parameter completionBlock:(BSRebroadcastMsgViewControllerCompletionBlock)completionBlock cancelBlock:(BSRebroadcastMsgViewControllerCancelBlock)cancelBlock;

/*
 * @param  parameter (NSDictionary *)@{BSRebroadcastMsgViewControllerTextReadyPost:(NSString *)textReadyPost, BSRebroadcastMsgViewControllerImageReadyPost:(UIImage *)imageReadyPost}
 */
- (id)initwithParameter:(NSDictionary *)parameter rebroadcastMsgViewControllerDelegate:(id<BSRebroadcastMsgViewControllerDelegate>)delegate;

@end

@protocol BSRebroadcastMsgViewControllerDelegate <NSObject>

/*
 * @param  rebroadcastMsgViewController (BSBaseRebroadcastMsgViewController *)
 * @param  infoReadyPost (NSDictionary *)@{BSRebroadcastMsgViewControllerTextReadyPost:(NSString *)textReadyPost, BSRebroadcastMsgViewControllerImageReadyPost:(UIImage *)imageReadyPost}
 * @return void
 */
- (void)rebroadcastMsgViewController:(BSBaseRebroadcastMsgViewController *)rebroadcastMsgViewController didFinishEditingContentWithInfo:(NSDictionary *)infoReadyPost;

/*
 * @param  rebroadcastMsgViewController (BSBaseRebroadcastMsgViewController *)
 * @return void
 */
- (void)rebroadcastMsgViewControllerDidCancel:(BSBaseRebroadcastMsgViewController *)rebroadcastMsgViewController;

@end
