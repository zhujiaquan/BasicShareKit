//
//  BSSimpleShareViewController.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSSimpleRebroadcastMsgViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BSCustomButtons.h"
#import "BSPlaceHolderTextView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface BSSimpleRebroadcastMsgViewController ()

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSSimpleRebroadcastMsgViewController

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithParameter:(NSDictionary *)parameter completionBlock:(BSRebroadcastMsgViewControllerCompletionBlock)completionBlock cancelBlock:(BSRebroadcastMsgViewControllerCancelBlock)cancelBlock
{
    if (self = [super initWithParameter:parameter completionBlock:completionBlock cancelBlock:cancelBlock])
    {
    
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initwithParameter:(NSDictionary *)parameter rebroadcastMsgViewControllerDelegate:(id<BSRebroadcastMsgViewControllerDelegate>)delegate
{
    if (self = [super initwithParameter:parameter rebroadcastMsgViewControllerDelegate:delegate])
    {
    
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    [_overlayView release];
    _overlayView = nil;
    
    [_shareView release];
    _shareView = nil;
    
    [_cancelButton release];
    _cancelButton = nil;
    
    [_sendButton release];
    _sendButton = nil;
    
    [_shareTextView release];
    _shareTextView = nil;
    
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Initialization code
    self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 1.0f;
    
    if (!_overlayView)
    {
        _overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_overlayView setBackgroundColor:[UIColor grayColor]];
        [_overlayView setAlpha:0.33f];
        [self.view addSubview:_overlayView];
    }
    
    if (!_shareView)
    {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 280, 200)];
        _shareView.layer.masksToBounds = YES;
        _shareView.layer.cornerRadius = 6.0;
        _shareView.layer.borderWidth = 1.0;
        _shareView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_shareView];
    }
    
    if (!_cancelButton)
    {   
        _cancelButton = [[BSCancelButton alloc] init];
        [_cancelButton setFrame:CGRectMake(5, 5, 60, 30)];
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_cancelButton];
    }
    
    if (!_sendButton)
    {
        _sendButton = [[BSShareButton alloc] init];
        [_sendButton setFrame:CGRectMake(280-65, 5, 60, 30)];
        [_sendButton addTarget:self action:@selector(sendButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_sendButton];
    }
    
    if (!_shareTextView)
    {
        _shareTextView = [[BSPlaceHolderTextView alloc] initWithFrame:CGRectMake(5, 40, 270, 120)];
        _shareTextView.placeholder = @"说点儿啥...";
        _shareTextView.layer.cornerRadius = 6.0;
        _shareTextView.keyboardType = UIKeyboardTypeASCIICapable;
        _shareTextView.textAlignment = UITextAlignmentLeft;
        _shareTextView.backgroundColor = [UIColor whiteColor];
        _shareTextView.font = [UIFont systemFontOfSize:15.0f];
        [_shareTextView becomeFirstResponder];
        [_shareView addSubview:_shareTextView];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)cancelButtonTouchUpInside:(id)sender
{
    _overlayView.alpha = 0.0f;
    [self dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)sendButtonTouchUpInside:(id)sender
{
    _overlayView.alpha = 0.0f;
    [self dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showWithAnimated:(BOOL)animated
{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] setModalPresentationStyle:UIModalPresentationCurrentContext];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:self animated:animated];
}

@end
