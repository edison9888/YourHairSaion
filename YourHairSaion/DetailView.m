//
//  DetailViewCell.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#define MARGIN 8.0



#import "RootViewController.h"
#import "DetailView.h"
#import "ImgFullViewController.h"
#import "L1SearchButton.h"
#import "DetailImageView.h"
#import "DetailInDetailViewController.h"
@interface DetailView()

@property (nonatomic, retain) IBOutlet UIImageView *imageBg;

@property (nonatomic, retain) IBOutlet UITextView *captionLabel;
@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UIButton *btnBuy;
@property (nonatomic, retain) IBOutlet UIButton* btnStatement;
@property (nonatomic, retain) IBOutlet UIButton* btnSearch;
@property (nonatomic, retain) IBOutlet UIButton* btnTakeFace;
@property (nonatomic, strong)IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong)IBOutlet UIPageControl* pageControl;

@property (nonatomic, retain) IBOutlet UITextView *labelDetail;
@property (nonatomic, retain) IBOutlet UIButton *btnBuy1;
@property (nonatomic, strong) IBOutlet UIView* viewDetailBg;

@property (nonatomic, retain) IBOutlet UIImageView *ivBg;



- (void)formatLabel:(ProductShowingDetail*)psd;
- (void)resetDetailView;
@end
@implementation DetailView
@synthesize
captionLabel = _captionLabel;
@synthesize scrollView, pageControl;
@synthesize detailViewController;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /*
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        self.captionLabel.text = @"";
        self.captionLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.captionLabel];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(FRAME_DETAILVIEW_TITLE_X, FRAME_DETAILVIEW_TITLE_Y, FRAME_DETAILVIEW_TITLE_W, FRAME_DETAILVIEW_TITLE_H)];
        label.font = [UIFont boldSystemFontOfSize:30.0];
        label.textColor = [UIColor redColor];
        label.numberOfLines = 0;
        label.text = @"介绍";
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        */
        //self.alwaysBounceVertical = YES;

    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = nil;
//    self.imageBg.image = [UIImage imageNamed:@"bgRightImg.png"];
    //self.imageBg.frame = CGRectMake(FRAME_DETAILVIEW_BGIMG_X, FRAME_DETAILVIEW_BGIMG_Y,FRAME_DETAILVIEW_BGIMG_W, FRAME_DETAILVIEW_BGIMG_H);
    //self.labelTitle.frame = CGRectMake(FRAME_DETAILVIEW_TITLE_X, FRAME_DETAILVIEW_TITLE_Y, FRAME_DETAILVIEW_TITLE_W, FRAME_DETAILVIEW_TITLE_H);
//    self.btnBuy.frame = CGRectMake(FRAME_DETAILVIEW_SHOPPING_CART_X, FRAME_DETAILVIEW_SHOPPING_CART_Y, 32, 30);
//    self.btnSearch.frame = CGRectMake(370, 10, 25, 25);
//    self.btnStatement.frame = CGRectMake(370, 75, 25, 25);
    //[self resetDetailView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 3;
    
    //self.viewDetailBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgStatementPage.png"]];
    
    }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)fillData:(ProductShowingDetail *)psd
{
    self.psd = psd;
    [self formatLabel:psd];
    //[self resetDetailView];
    
    
    for (UIView* view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    self.labelDetail.text = psd.detail;
    [self.labelDetail sizeToFit];
    

    [self.btnBuy1 setTitle:[NSString stringWithFormat:@"￥%@", psd.price] forState:UIControlStateNormal];
    int pageCount = [psd imageCount];
    pageControl.numberOfPages = pageCount;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pageCount, scrollView.frame.size.height);
    for (int i = 0; i < pageCount; i ++)
    {
        DetailInDetailViewController* vc  = [[DetailInDetailViewController alloc]initWithNibName:@"DetailInDetailViewController" bundle:nil];
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        vc.view.frame = frame;
        [scrollView addSubview:vc.view];
        vc.imageView.image = [psd imageAtIndex:i];
        vc.labelInfo.text = psd.name;
    }
    
    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
    


}

//- (void)resetDetailView
//{
//    CGFloat width = FRAME_DETAILVIEW_IMG_W;
//    CGFloat top = FRAME_DETAILVIEW_IMG_Y;
//    CGFloat left = FRAME_DETAILVIEW_IMG_X;
//    
//    // Image
//    CGFloat objectWidth = FRAME_DETAILVIEW_IMG_W;//self.imageView.image.size.width;
//    CGFloat objectHeight = FRAME_DETAILVIEW_IMG_H;//self.imageView.image.size.height;
//    CGFloat scaledHeight = FRAME_DETAILVIEW_IMG_H;//floorf(objectHeight / (objectWidth / width));
//    //CGFloat scaledHeight = 0.0f;
//    if (objectHeight < 0.01 || objectWidth < 0.01)
//    {
//        scaledHeight = 0.0f;
//    }
//    
//    //    NSLog(@"left=%f, top=%f, width=%f, heigh=%f, owidth=%f, oheight=%f", left, top, width, scaledHeight, objectWidth, objectHeight);
//   
//
//    // Label
//    CGSize labelSize = CGSizeZero;
//    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(FRAME_DETAILVIEW_DETAIL_W, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
//    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
//    
//    self.captionLabel.frame = CGRectMake(FRAME_DETAILVIEW_DETAIL_X, FRAME_DETAILVIEW_DETAIL_Y, FRAME_DETAILVIEW_DETAIL_W, FRAME_DETAILVIEW_DETAIL_H);
//    
//    //self.captionLabel = CGSizeMake(width, totalHeigh);
//
//}

- (void)formatLabel:(ProductShowingDetail*)psd
{
    self.captionLabel.text = psd.productDetail;
}


@end
