//
//  BSCustomButtons.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSCustomButtons.h"

#define MIN_WIDTH 55.0
#define MIN_HEIGHT 32.0

@implementation BSCancelButton

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, MIN_WIDTH, MIN_HEIGHT)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [self setBackgroundColor:[UIColor grayColor]];
        // [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"取消" forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, MIN_WIDTH, MIN_HEIGHT)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [self setBackgroundColor:[UIColor grayColor]];
        [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"取消" forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [self setBackgroundColor:[UIColor grayColor]];
        [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"取消" forState:UIControlStateNormal];
    }
    return self;
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect rect = self.frame;
    if (rect.size.width < MIN_WIDTH)
    {
        rect.size.width = MIN_WIDTH;
    }
    if (rect.size.height < MIN_HEIGHT)
    {
        rect.size.height = MIN_HEIGHT;
    }
    self.frame = rect;
}

@end

@implementation BSShareButton

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, MIN_WIDTH, MIN_HEIGHT)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"发表" forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialization code
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"发表" forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"ShareButtonBG.png"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self setTitle:@"发表" forState:UIControlStateNormal];
    }
    return self;
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect rect = self.frame;
    if (rect.size.width < MIN_WIDTH)
    {
        rect.size.width = MIN_WIDTH;
    }
    if (rect.size.height < MIN_HEIGHT)
    {
        rect.size.height = MIN_HEIGHT;
    }
    self.frame = rect;
}

@end
