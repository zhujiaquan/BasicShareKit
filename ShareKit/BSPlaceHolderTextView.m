//
//  BSPlaceHolderTextView.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-25.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSPlaceHolderTextView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface BSPlaceHolderTextView()

-(void)textChangedNotification:(NSNotification *)notification;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSPlaceHolderTextView

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize placeHolderLabel = _placeHolderLabel;
@synthesize placeholder      = _placeholder;
@synthesize placeholderColor = _placeholderColor;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textChangedNotification:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChangedNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_placeHolderLabel release];
    _placeHolderLabel = nil;
    
    [_placeholderColor release];
    _placeholderColor = nil;
    
    [_placeholder release];
    _placeholder = nil;
    
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Protected methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textChangedNotification:(NSNotification *)notification
{
    if ([[self placeholder] length] == 0)
    {
        return;
    }
    
    if ([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark Override methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChangedNotification:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect
{
    if ([[self placeholder] length] > 0)
    {
        if (_placeHolderLabel == nil)
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] > 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
