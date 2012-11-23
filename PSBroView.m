//
//  PSBroView.m
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 This is an example of a subclass of PSCollectionViewCell
 */

#import "PSBroView.h"
#import "ProductShowingDetail.h"

#define FRAME_BUTTON_W 27
#define FRAME_BUTTON_H FRAME_BUTTON_W

#define MARGIN 4.0

@interface PSBroView ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *captionLabel;

@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UIButton *btnReduct;
@property (nonatomic, strong) UIButton *btnNum;
@property (nonatomic, strong) UIView* content;


@property (nonatomic, strong) UIView* buyNumberView;
@property (nonatomic, strong) UILabel* buyNumberLabel;
@property (nonatomic, strong) UIImageView* buyNumberIv;


- (void)contentOnTap:(id)sender;
- (void)productAdd:(id)sender;
- (void)productReduce:(id)sender;
@end

@implementation PSBroView

@synthesize
imageView = _imageView,
captionLabel = _captionLabel;
@synthesize btnAdd, btnReduct, content, buyNumberView,buyNumberLabel,buyNumberIv;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.content = [[UIView alloc]init];
        self.content.backgroundColor = [UIColor whiteColor];
        self.content.userInteractionEnabled = NO;
        self.exclusiveTouch = YES;
        UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentOnTap:)];
        [tapRecongnizer setNumberOfTapsRequired:1];
        //[self.content addGestureRecognizer:tapRecongnizer];
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self.content addSubview:self.imageView];
        self.imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgProductImg.png"]];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        [self.content addSubview:self.captionLabel];
        
        [self addSubview:self.content];
        
        self.btnAdd = [[UIButton alloc]init];
        [self.btnAdd setImage:[UIImage imageNamed:@"imgAdd.png"] forState:UIControlStateNormal];
        [self.btnAdd addTarget:self action:@selector(productAdd:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnAdd];
        self.btnReduct = [[UIButton alloc]init];
        [self.btnReduct setImage:[UIImage imageNamed:@"imgReduce.png"] forState:UIControlStateNormal];
        [self.btnReduct addTarget:self action:@selector(productReduce:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnReduct];
        
        
        self.btnNum = [[UIButton alloc]init];
        //[self.btnNum setImage:[UIImage imageNamed:@"imgNum.png"] forState:UIControlStateNormal];
        //[self.btnNum addTarget:self action:@selector(productAdd:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnNum setTitle:@"1" forState:UIControlStateNormal];
        self.btnNum.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgNum.png"]];
        [self addSubview:self.btnNum];
        //display the number had buy
        self.buyNumberView = [[UIView alloc]init];
        self.buyNumberView.clipsToBounds = YES;
        self.buyNumberView.backgroundColor = [UIColor greenColor];
        self.buyNumberView.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
        
        self.buyNumberIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imgNum.png"]];
        //[self.buyNumberIv sizeToFit];
        self.buyNumberIv.frame = CGRectZero;
        self.buyNumberIv.clipsToBounds = YES;
        
        self.buyNumberLabel = [[UILabel alloc]init];
        self.buyNumberLabel.backgroundColor = [UIColor clearColor];
        self.buyNumberLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.buyNumberLabel.numberOfLines = 1;
        
        [self.buyNumberView addSubview:self.buyNumberIv];
        //[self.buyNumberView addSubview:self.buyNumberLabel];
        //[self addSubview:self.buyNumberView];
        
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    self.captionLabel.text = nil;
}
/*
- (void)dealloc {
    self.imageView = nil;
    self.captionLabel = nil;
    [super dealloc];
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    self.btnAdd.frame = CGRectMake(0, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.btnReduct.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.btnNum.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    [self.btnAdd setHidden:YES];
    [self.btnReduct setHidden:YES];
    [self.btnNum setHidden:YES];
    self.buyNumberView.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.buyNumberIv.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.buyNumberLabel.text = @"88";
    
    
    CGFloat width = self.frame.size.width - FRAME_BUTTON_W;
    CGFloat top = FRAME_BUTTON_H/2;
    CGFloat left = FRAME_BUTTON_W/2;
    
    CGFloat contentWidth = self.frame.size.width - MARGIN * 2 - FRAME_BUTTON_W;
    CGFloat contentTop = MARGIN;
    CGFloat contentLeft = MARGIN;
    
    
    // Image
    //UIImage* uiObj = self.object;
    ProductShowingDetail* is = self.object;
    CGFloat objectWidth = is.uiImg.size.width;
    CGFloat objectHeight = objectWidth + 20;//is.uiImg.size.height;
    //CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    CGFloat scaledHeight = 0.0f;
    if (objectHeight < 0.01 || objectWidth < 0.01)
    {
        scaledHeight = 0.0f;
    }
    else
    {
    scaledHeight = objectHeight / (objectWidth / width);
    }
//    NSLog(@"left=%f, top=%f, width=%f, heigh=%f, owidth=%f, oheight=%f", left, top, width, scaledHeight, objectWidth, objectHeight);
    self.imageView.frame = CGRectMake(contentLeft, contentTop, contentWidth, scaledHeight);
    self.content.frame = CGRectMake(left, top, width, scaledHeight+MARGIN*2);
    // Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    
    self.captionLabel.frame = CGRectZero;//CGRectMake(left, top, self.imageView.frame.size.width, labelSize.height);
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    /*
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        self.imageView.image = [UIImage imageWithData:data];
    }];
    
    self.captionLabel.text = [object objectForKey:@"title"];
     */
    ProductShowingDetail* is = self.object;
    self.imageView.image = is.uiImg;
    self.captionLabel.text = [NSString stringWithFormat : @"%@\n价格:%@", is.productName, is.price];
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN;
    ProductShowingDetail* is = object;
    CGFloat objectWidth = is.uiImg.size.width;
    CGFloat objectHeight = objectWidth + 20;//is.uiImg.size.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
    
    // Label
    NSString *caption = [NSString stringWithFormat : @"%@\n价格:%@", is.productName, is.price];//[object objectForKey:@"title"];
    CGSize labelSize = CGSizeZero;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
    labelSize = [caption sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    //height += labelSize.height;
    
    height += MARGIN*2;
    //NSLog(@"height=%f", height);
    return height;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.content.backgroundColor = backgroundColor;
}

- (UIColor*)backgroundColor
{
    return self.content.backgroundColor;
}


- (void)contentOnTap:(id)sender
{
    
}

- (void)productReduce:(id)sender
{
    [self.productBuyingDelegate productAdd:self];
}

- (void)productAdd:(id)sender
{
    [self.productBuyingDelegate productAdd:self];
}

- (void)prepareToBuy
{
    [self.btnAdd setHidden:NO];
    [self.btnReduct setHidden:NO];
    [self.btnNum setHidden:YES];
}

- (void)finishToBuy
{
    [self.btnAdd setHidden:YES];
    [self.btnReduct setHidden:YES];
    ProductShowingDetail* psd = self.object;
    if (psd.buyCount > 0)
    {
        [self.btnNum setTitle:[NSString stringWithFormat:@"%d", psd.buyCount] forState:UIControlStateNormal];
        [self.btnNum setHidden:NO];
    }
    
}
@end
