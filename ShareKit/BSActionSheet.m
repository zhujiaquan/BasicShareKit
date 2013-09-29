//
//  BSActionSheet.m
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-24.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import "BSActionSheet.h"
#import <QuartzCore/QuartzCore.h>

#define ITEM_PER_PAGE 6

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface BSActionSheet() <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, assign) id<BSActionSheetDelegate> actionSheetDelegate;
@property (nonatomic, assign) NSInteger numberOfItems;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSActionSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize scrollView  = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize items       = _items;
@synthesize actionSheetDelegate = _actionSheetDelegate;
@synthesize numberOfItems = _numberOfItems;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initwithIconSheetDelegate:(id<BSActionSheetDelegate>)delegate itemCount:(int)count
{
    int rowCount = (count <= 3) ? 1 : 2;
    
    NSString* titleBlank = @"\n\n\n\n\n\n";
    for (int i = 1 ; i < rowCount; i++)
    {
        titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
    }
    
    self = [super initWithTitle:titleBlank delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self)
    {
        [self setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        _actionSheetDelegate = delegate;
    
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 105 * rowCount)] autorelease];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setBackgroundColor:[UIColor clearColor]];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        [self.scrollView setDelegate:self];
        [self.scrollView setScrollEnabled:YES];
        [self.scrollView setBounces:NO];
        [self addSubview:self.scrollView];
        
        if (count > ITEM_PER_PAGE)
        {
            self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, 105 * rowCount, 0, 20)] autorelease];
            [self.pageControl setNumberOfPages:0];
            [self.pageControl setCurrentPage:0];
            [self.pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
            [self addSubview:self.pageControl];
        }
    
        self.items = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];
        self.numberOfItems = count;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    _actionSheetDelegate = nil;
    
    [_scrollView release];
    [_pageControl release];
    [_items release];
    
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)showInView:(UIView *)view
{
    [super showInView:view];
    [self reloadData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadData
{
    for (BSActionSheetCell* cell in self.items)
    {
        [cell removeFromSuperview];
        [self.items removeObject:cell];
    }
    
    int count = self.numberOfItems;
    if (count <= 0)
    {
        return;
    }
    
    int rowCount = 2;
    if (count <= 3)
    {
        [self setTitle:@"\n\n\n\n\n\n"];
        [self.scrollView setFrame:CGRectMake(0, 10, 320, 105)];
        rowCount = 1;
    }
    else
    {
        [self setTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"];
        [self.scrollView setFrame:CGRectMake(0, 10, 320, 210)];
        rowCount = 2;
    }
    

    int numberOfPages = (count % ITEM_PER_PAGE == 0) ? count / ITEM_PER_PAGE : count / ITEM_PER_PAGE + 1;
    [self.scrollView setContentSize:CGSizeMake(320 * numberOfPages, self.scrollView.frame.size.height)];
    [self.pageControl setNumberOfPages:count/ITEM_PER_PAGE+1];
    [self.pageControl setCurrentPage:0];
    
    for (int i = 0; i< count; i++)
    {
        BSActionSheetCell* cell = [self.actionSheetDelegate cellForActionAtIndex:i];
        int pageNo = i / ITEM_PER_PAGE;
        int index  = i % ITEM_PER_PAGE;
        
        if (ITEM_PER_PAGE == 6)
        {
            int row = index / 3;
            int column = index % 3;
            int numberOfRow = (count < 3) ? count * 2 : 6;
        
            float centerY = (1 + row * 2) * self.scrollView.frame.size.height / ( 2 * rowCount);
            float centerX = (1 + column * 2) * (self.scrollView.frame.size.width / numberOfRow);

            [cell setCenter:CGPointMake(centerX + 320 * pageNo, centerY)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            [tap release];
        }
        
        [self.items addObject:cell];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    BSActionSheetCell* cell = (BSActionSheetCell*)[recongizer view];
    [self.actionSheetDelegate didTapOnItemAtIndex:cell.index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)changePage:(id)sender
{
    int page = self.pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(320 * page, 0)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma scrollview delegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    int page = self.scrollView.contentOffset.x / 320;
    self.pageControl.currentPage = page;
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - BSActionSheetCell

///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSActionSheetCell

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize iconView   = _iconView;
@synthesize titleLabel = _titleLabel;
@synthesize index      = _index;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)] autorelease];
        [self.iconView setBackgroundColor:[UIColor clearColor]];
        [[self.iconView layer] setCornerRadius:8.0f];
        [[self.iconView layer] setMasksToBounds:YES];
        [self addSubview:self.iconView];
    
        CGPoint center = self.iconView.center;
        [self.iconView setCenter:CGPointMake(self.bounds.size.width * 0.5f, center.y)];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 13)] autorelease];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextAlignment:UITextAlignmentCenter];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setShadowColor:[UIColor blackColor]];
        [self.titleLabel setShadowOffset:CGSizeMake(0, 0.5)];
        [self.titleLabel setText:@""];
        [self addSubview:self.titleLabel];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    [_iconView release];
    [_titleLabel release];
    [super dealloc];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - BSWeiboActionSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
@interface BSShareActionSheet()

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BSShareActionSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize shareActionSheetDelegate = _shareActionSheetDelegate;
@synthesize actionBlock = _actionBlock;
@synthesize shareList = _shareList;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initialization

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithShareList:(NSArray *)shareList shareActionSheetDelegate:(id<BSShareActionSheetDelegate>)shareActionSheetDelegate
{
    self = [super initwithIconSheetDelegate:self itemCount:shareList.count];
    if (self)
    {
        _shareActionSheetDelegate = shareActionSheetDelegate;
        _actionBlock = nil;
        _shareList = [shareList retain];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithShareList:(NSArray *)shareList actionBlock:(BSShareActionSheetActionBlock)actionBlock
{
    NSParameterAssert(shareList);
    NSParameterAssert(actionBlock);
    self = [super initwithIconSheetDelegate:self itemCount:shareList.count];
    if (self)
    {
        _shareActionSheetDelegate = nil;
        _actionBlock = [actionBlock copy];
        _shareList = [shareList retain];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    NSLog(@" %@ %@ ", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    _shareActionSheetDelegate = nil;
    [_actionBlock release];
    [_shareList release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BSActionSheetDelegate methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BSActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    NSNumber *shareNumber = [self.shareList objectAtIndex:index];
    
    BSActionSheetCell* cell = [[[BSActionSheetCell alloc] init] autorelease];
    [cell.iconView setImage:ShareIconWithType(SHARE_TYPE_FROM_NUMBER(shareNumber))];
    [cell.titleLabel setText:ShareTitleWithType(SHARE_TYPE_FROM_NUMBER(shareNumber))];
    cell.index = index;
    
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didTapOnItemAtIndex:(NSInteger)index
{
    NSNumber *shareNumber = [self.shareList objectAtIndex:index];
    
    if (_shareActionSheetDelegate &&
        [_shareActionSheetDelegate respondsToSelector:@selector(shareActionSheet:didSelectWithShareType:)])
    {
        [_shareActionSheetDelegate shareActionSheet:self didSelectWithShareType:SHARE_TYPE_FROM_NUMBER(shareNumber)];
    }
    
    if (_actionBlock)
    {
        _actionBlock(SHARE_TYPE_FROM_NUMBER(shareNumber));
    }
}

@end
