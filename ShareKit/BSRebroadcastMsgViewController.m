//
//  BSFullShareViewController.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSRebroadcastMsgViewController.h"
#import "BSPlaceHolderTextView.h"
#import "BasicShareKit.h"
#import "BSCustomButtons.h"
#import "UIView+BasicShareKit.h"
#import "NSString+BasicShareKit.h"
#import "UIButton+BasicShareKit.h"
#import "UIImage+BasicShareKit.h"
#import "BSImagePickerController.h"
#import "BSAttachedPictureView.h"
#import "BSAttachedPictureCtrlView.h"

#import <QuartzCore/QuartzCore.h>

static NSInteger kMaxWords = 140;

#define kBundleName @"BasicShareKit.bundle"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface BSRebroadcastMsgViewController ()<BSAttachedPictureViewDelegate, BSAttachedPictureCtrlViewDelegate>

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSRebroadcastMsgViewController
{
    BOOL _keyBoardIsShow;
    CGFloat _keyBoardHeight;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize editorTextView = _editorTextView;
@synthesize toolView       = _toolView;
@synthesize cameraButton   = _cameraButton;
@synthesize pictureButton  = _pictureButton;
@synthesize totalLabel     = _totalLabel;
@synthesize imageReadyPost = _imageReadyPost;
@synthesize textReadyPost  = _textReadyPost;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setImageReadyPost:(UIImage *)imageReadyPost
{
    if (![imageReadyPost isEqual:_imageReadyPost])
    {
        if (_imageReadyPost)
        {
            [_imageReadyPost release], _imageReadyPost = nil;
        }
        _imageReadyPost = [imageReadyPost retain];
    
        if (_imageReadyPost)
        {
            [_attachedImageView removeFromSuperview];
            [_attachedImageView release], _attachedImageView = nil;
        
            CGFloat top = (self.view.bounds.size.height - _keyBoardHeight - 33.0f - 5.0f - 35.0f);
        
            _attachedImageView = [[BSAttachedPictureView alloc] initWithFrame:CGRectMake(5 - 43, top, 43, 32)];
            _attachedImageView.backgroundColor = [UIColor clearColor];
            _attachedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
            _attachedImageView.attachedPictureViewDelegate = self;
            [_attachedImageView setAttachedImage:[UIImage imageNamed:@"test"]];
            [self.view addSubview:_attachedImageView];
        
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.7;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionPush;
            _attachedImageView.frame = CGRectMake(5, top, 43, 32);
            [[_attachedImageView layer] addAnimation:animation forKey:@"animation"];
        }
        else
        {
            [_attachedImageView removeFromSuperview];
            [_attachedImageView release], _attachedImageView = nil;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithParameter:(NSDictionary *)parameter completionBlock:(BSRebroadcastMsgViewControllerCompletionBlock)completionBlock cancelBlock:(BSRebroadcastMsgViewControllerCancelBlock)cancelBlock
{
    if (self = [super initWithParameter:parameter completionBlock:completionBlock cancelBlock:cancelBlock])
    {
        [self.navigationItem setLeftBarButtonItem:[self leftBarButtonItem]];
        [self.navigationItem setRightBarButtonItem:[self rightBarButtonItem]];
    
        NSString *textReadyPost  = [parameter objectForKey:BSRebroadcastMsgViewControllerTextReadyPost];
        UIImage  *imageReadyPost = [parameter objectForKey:BSRebroadcastMsgViewControllerImageReadyPost];
    
        _keyBoardIsShow = NO;
        _keyBoardHeight = 216.0f;
        _imageReadyPost = nil;
    
        _textReadyPost = [textReadyPost retain];
        self.imageReadyPost = imageReadyPost;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initwithParameter:(NSDictionary *)parameter rebroadcastMsgViewControllerDelegate:(id<BSRebroadcastMsgViewControllerDelegate>)delegate
{
    if (self = [super initwithParameter:parameter rebroadcastMsgViewControllerDelegate:delegate])
    {
        [self.navigationItem setLeftBarButtonItem:[self leftBarButtonItem]];
        [self.navigationItem setRightBarButtonItem:[self rightBarButtonItem]];
    
        NSString *textReadyPost  = [parameter objectForKey:BSRebroadcastMsgViewControllerTextReadyPost];
        UIImage  *imageReadyPost = [parameter objectForKey:BSRebroadcastMsgViewControllerImageReadyPost];
    
        _keyBoardIsShow = NO;
        _keyBoardHeight = 216.0f;
        _imageReadyPost = nil;
    
        _textReadyPost = [textReadyPost retain];
        self.imageReadyPost = imageReadyPost;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_editorTextView release], _editorTextView = nil;
    [_viewDownContainer release], _viewDownContainer = nil;
    [_attachedImageView release], _attachedImageView = nil;
    [_attachedPictureCtrlView release], _attachedPictureCtrlView = nil;
    [_toolView release], _toolView = nil;
    [_cameraButton release], _cameraButton = nil;
    [_pictureButton release], _pictureButton = nil;
    [_totalLabel release], _totalLabel = nil;
    [_imageReadyPost release], _imageReadyPost = nil;
    [_textReadyPost release], _textReadyPost = nil;
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
    }
#endif
    
    // setup editorTextView
    if (!self.editorTextView)
    {
        CGRect editorFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100);
        self.editorTextView = [[[BSPlaceHolderTextView alloc] initWithFrame:editorFrame] autorelease];
        [self.editorTextView setDelegate:self];
        [self.editorTextView setFont:[UIFont systemFontOfSize:15.0f]];
        [self.editorTextView setBackgroundColor:[UIColor clearColor]];
        [self.editorTextView setReturnKeyType:UIReturnKeyGo];
        [self.editorTextView setPlaceholder:@"说点儿啥..."];
        [self.editorTextView setClearsContextBeforeDrawing:YES];
        [self.editorTextView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.editorTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.editorTextView];
        [self.editorTextView setText:self.textReadyPost];
    }
    
//    if (_imageReadyPost)
//    {
//        [self didSelectionPicture:_imageReadyPost];
//  
//        _attachedImageView = [[BSAttachedPictureView alloc] initWithFrame:CGRectMake(5 - 43, self.view.height - 75.0f, 43, 32)];
//        _attachedImageView.backgroundColor = [UIColor clearColor];
//        _attachedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//        _attachedImageView.attachedPictureViewDelegate = self;
//        [_attachedImageView setAttachedImage:_imageReadyPost];
//        [self.view addSubview:_attachedImageView];
// 
//        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
//        animation.duration = 0.7;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = kCATransitionPush;
//        _attachedImageView.frame = CGRectMake(5, self.view.height - 75.0f, 43, 32);
//        [[_attachedImageView layer] addAnimation:animation forKey:@"animation"];
//    }
    
    // setup toolView
    if (!self.toolView)
    {
        UIImage *patternImage = [UIImage imageNamed:@"RebroadcaseMsg/bg_compose_toolview" bundleName:kBundleName];
        self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 40, self.view.frame.size.width, 40)];
        [self.toolView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
        [self.toolView setBackgroundColor:[UIColor grayColor]];
        [self.toolView setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
        [self.view addSubview:self.toolView];
    }
    
    // setup viewDownContainer
    if (!_viewDownContainer)
    {
        UIImage *patternImage = [UIImage imageNamed:@"RebroadcaseMsg/bg_compose_emotion" bundleName:kBundleName];
        _viewDownContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.frame.size.width, 216.0f)];
        [_viewDownContainer setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
        [_viewDownContainer setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
        [self.view addSubview:_viewDownContainer];
    }
  
    // setup totalLabel
    if (!self.totalLabel)
    {
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.toolView.size.width - 60.0f, 0, 50.0f, 40.0f)];
        [self.totalLabel setCenter:CGPointMake(self.totalLabel.center.x, self.toolView.size.height * 0.5f)];
        [self.totalLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [self.totalLabel setTextAlignment:NSTextAlignmentRight];
        [self.totalLabel setBackgroundColor:[UIColor clearColor]];
        [self.totalLabel setText:[NSString stringWithFormat:@"%d", kMaxWords]];
        [self.toolView addSubview:self.totalLabel];
    }
    
    // setup cameraButton
    if (!self.cameraButton)
    {
        self.cameraButton = [UIButton buttonWithImageNamed:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_camera", kBundleName]
                                     highlightedImageNamed:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_camera_pressed", kBundleName]
                                         selectedImageName:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_camera_pressed", kBundleName]];
        [self.cameraButton setFrame:(CGRect){CGPointMake(10, 10), self.cameraButton.size}];
        [self.cameraButton setCenter:CGPointMake(self.cameraButton.center.x, self.toolView.size.height * 0.5f)];
        [self.cameraButton addTarget:self action:@selector(cameraButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:self.cameraButton];
    }
    
    // setup pictureButton
    if (!self.pictureButton)
    {
        self.pictureButton = [UIButton buttonWithImageNamed:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_picture", kBundleName]
                                      highlightedImageNamed:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_picture_pressed", kBundleName]
                                          selectedImageName:[NSString stringWithFormat:@"%@/RebroadcaseMsg/button_picture_pressed", kBundleName]];
        [self.pictureButton setFrame:(CGRect){CGPointMake(100, 10), self.pictureButton.size}];
        [self.pictureButton setCenter:CGPointMake(self.pictureButton.center.x, self.toolView.size.height * 0.5f)];
        [self.pictureButton addTarget:self action:@selector(pictureButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:self.pictureButton];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.editorTextView becomeFirstResponder];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Protected methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIBarButtonItem *)leftBarButtonItem
{
    BSCancelButton *cancelButton = [[[BSCancelButton alloc] init] autorelease];
    [cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    return [cancelButton barButtonItem];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIBarButtonItem *)rightBarButtonItem
{
    BSShareButton *shareButton = [[[BSShareButton alloc] init] autorelease];
    [shareButton addTarget:self action:@selector(shareButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    return [shareButton barButtonItem];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)cancelButtonTouchUpInside:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    if (self.rebroadcastMsgViewControllerDelegate &&
        [self.rebroadcastMsgViewControllerDelegate respondsToSelector:@selector(rebroadcastMsgViewControllerDidCancel:)])
    {
        [self.rebroadcastMsgViewControllerDelegate rebroadcastMsgViewControllerDidCancel:self];
    }
    
    if (self.cancelBlock)
    {
        self.cancelBlock();
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)shareButtonTouchUpInside:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    NSDictionary *infoReadyPost = @{
                                    BSRebroadcastMsgViewControllerTextReadyPost: self.textReadyPost,
                                    BSRebroadcastMsgViewControllerImageReadyPost: self.imageReadyPost
                                    };
    
    if (self.rebroadcastMsgViewControllerDelegate &&
        [self.rebroadcastMsgViewControllerDelegate respondsToSelector:@selector(rebroadcastMsgViewController:didFinishEditingContentWithInfo:)])
    {
        [self.rebroadcastMsgViewControllerDelegate rebroadcastMsgViewController:self didFinishEditingContentWithInfo:infoReadyPost];
    }
    
    if (self.completionBlock)
    {
        self.completionBlock(infoReadyPost);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)cameraButtonTouchUpInside:(id)sender
{
    if ([BSImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        __block BSRebroadcastMsgViewController *weakSelf = self;
        __block BSImagePickerController *weakPicker = [[[BSImagePickerController alloc] initWithPhotoCaptureSelectionBlock:^(UIImage *photo) {
        
            [weakSelf setImageReadyPost:photo];
            [weakPicker dismissModalViewControllerAnimated:YES];
        
        } cancelBlock:^{
        
            [weakSelf setImageReadyPost:[UIImage imageNamed:@"test"]];
            [weakPicker dismissModalViewControllerAnimated:YES];
        
        }] autorelease];
    
        [weakSelf presentModalViewController:weakPicker animated:YES];
    }
    else
    {
        [[[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:@"该设备无法使用照相机设备"
                                   delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] autorelease] show];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)pictureButtonTouchUpInside:(id)sender
{
    if ([BSImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        __block BSRebroadcastMsgViewController *weakSelf = self;
        __block BSImagePickerController *weakPicker = [[[BSImagePickerController alloc] initWithPhotoLibrarySelectionBlock:^(UIImage *photo) {
            
            [weakSelf setImageReadyPost:photo];
            [weakPicker dismissModalViewControllerAnimated:YES];
            
        } cancelBlock:^{
            
            [weakSelf setImageReadyPost:[UIImage imageNamed:@"test"]];
            [weakPicker dismissModalViewControllerAnimated:YES];
            
        }] autorelease];
        
        [weakSelf presentModalViewController:weakPicker animated:YES];
    }
    else
    {
        [[[[UIAlertView alloc] initWithTitle:@"提示"
                                     message:@"该设备无法选取相册照片"
                                    delegate:self
                           cancelButtonTitle:@"确定"
                           otherButtonTitles:nil] autorelease] show];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Responding to keyboard events

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    _keyBoardIsShow = YES;
    _keyBoardHeight = keyboardRect.size.height;
    
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillHide:(NSNotification *)notification
{
    _keyBoardIsShow = NO;
    _keyBoardHeight = 0.0f;

//    NSDictionary* userInfo = [notification userInfo];
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
//    [self moveInputBarWithKeyboardHeight:0.0f withDuration:animationDuration];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)moveInputBarWithKeyboardHeight:(CGFloat)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    CGRect selfRect = self.view.bounds;
    
    // setup tool view
    CGFloat top = (selfRect.size.height - keyboardHeight - 33.0f - 5.0f);
    [self.toolView setTop:top];
    
    // setup viewDownContainer
    if (_viewDownContainer)
    {
        [_viewDownContainer setTop:top + self.toolView.frame.size.height];
        [_viewDownContainer setHeight:keyboardHeight];
    }
    
    // setup attachedImageView
    if (_attachedImageView)
    {
        [_attachedImageView setTop:top - 35.0f];
    }
        
    // setup editor text view
    CGRect frame = self.editorTextView.frame;
    frame.size.height = top - 40.0f;
    
    [self.editorTextView setFrame:frame];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - UITextViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *text = [self.editorTextView.text trimmedString];
    if (text.length && text.length <= kMaxWords)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    NSString *total = [NSString stringWithFormat:@"%d", kMaxWords - text.length];    
    if ((NSInteger)(kMaxWords - text.length) >= 0)
    {
        [self.totalLabel setTextColor:[UIColor blackColor]];
    }
    else
    {
        [self.totalLabel setTextColor:[UIColor redColor]];
    }
    [self.totalLabel setText:total];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textViewDidBeginEditing:(UITextView *)textView
{
 
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BSAttachedPictureViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didClickedAttachedPictureView:(BSAttachedPictureView *)attachedPictureView
{
    if (_keyBoardIsShow)
    {
        [self.editorTextView resignFirstResponder];
    
        // setup attachedPictureCtrlView
        if (nil == _attachedPictureCtrlView)
        {
            _attachedPictureCtrlView = [[BSAttachedPictureCtrlView alloc] initWithFrame:CGRectMake(0, 0, kImageMaxWidth, kImageMaxHeight)];
            [_attachedPictureCtrlView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [_attachedPictureCtrlView setAttachedPictureCtrlViewDelegate:self];
            [_attachedPictureCtrlView setAttachedImage:self.imageReadyPost];
            [_attachedPictureCtrlView setCenter:CGPointMake(_viewDownContainer.frame.size.width * 0.5f, _viewDownContainer.frame.size.height * 0.5f)];
            [_viewDownContainer addSubview:_attachedPictureCtrlView];
        }
    }
    else
    {
        [self.editorTextView becomeFirstResponder];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BSAttachedPictureCtrlViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)deleteButtonClickedWithAttachedPictureCtrlView:(BSAttachedPictureCtrlView *)attachedPictureCtrlView
{
    [self setImageReadyPost:nil];
    
    if (_attachedPictureCtrlView)
    {
        [_attachedPictureCtrlView removeFromSuperview];
        [_attachedPictureCtrlView release], _attachedPictureCtrlView = nil;
    }
    
    [self.editorTextView becomeFirstResponder];
}

@end