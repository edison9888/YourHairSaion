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
#import <QuartzCore/QuartzCore.h>

#define FRAME_BUTTON_W 27
#define FRAME_BUTTON_H FRAME_BUTTON_W

#define MARGIN 4.0

@interface PSBroView ()

@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UIButton *btnReduct;
@property (nonatomic, strong) UIButton *btnNum;
@property (nonatomic, strong) UIView* content;


- (void)contentOnTap:(id)sender;
- (void)productAdd:(id)sender;
- (void)productReduce:(id)sender;
@end

@implementation PSBroView
@synthesize btnAdd, btnReduct, content;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.imageView removeFromSuperview];
        [self.captionLabel removeFromSuperview];
        
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
        [self.btnNum setTitle:@"0" forState:UIControlStateNormal];
        self.btnNum.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgNum.png"]];
        [self addSubview:self.btnNum];
        
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
    [self reflash];
        
    self.btnAdd.frame = CGRectMake(0, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.btnReduct.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    self.btnNum.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    
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
    [self.productBuyingDelegate productReduct:self];
}

- (void)productAdd:(id)sender
{
    /*
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeBackwards;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionReveal;//@"suckEffect";//这个就是你想要的效果
    animation.subtype = kCATransitionFromTop;
    
    [self.content.layer addAnimation:animation forKey:@"animation"];
    */
    [self.productBuyingDelegate productAdd:self];
    
}

- (void)prepareToBuy
{
    [self.btnAdd setHidden:NO];
    [self.btnReduct setHidden:NO];
    self.btnNum.frame = CGRectMake((self.frame.size.width-FRAME_BUTTON_W)/2, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    [self.btnNum setHidden:NO];
    
}

- (void)finishToBuy
{
    [self.btnAdd setHidden:YES];
    [self.btnReduct setHidden:YES];
    self.btnNum.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    NSUInteger buyCount = [[DataAdapter shareInstance]numInShoppingCart:((ProductShowingDetail*)self.object).productId];
    if (buyCount > 0)
    {
        [self.btnNum setHidden:NO];
    }
    else
    {
        [self.btnNum setHidden:YES];
    }
    
}

- (void)productAdd
{
    NSUInteger buyCount = [[DataAdapter shareInstance]numInShoppingCart:((ProductShowingDetail*)self.object).productId];
    [self.btnNum setTitle:[NSString stringWithFormat:@"%d", buyCount] forState:UIControlStateNormal];
}

- (void)productReduct
{
    NSUInteger buyCount = [[DataAdapter shareInstance]numInShoppingCart:((ProductShowingDetail*)self.object).productId];
    [self.btnNum setTitle:[NSString stringWithFormat:@"%d", buyCount] forState:UIControlStateNormal];
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeBackwards;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionReveal;//@"suckEffect";//这个就是你想要的效果
    animation.subtype = kCATransitionFromBottom;
    
    [self.content.layer addAnimation:animation forKey:@"animation"];
}

- (void)reflash
{
    self.backgroundColor = [UIColor clearColor];
    self.content.backgroundColor = [UIColor whiteColor];
    self.btnNum.frame = CGRectMake(self.frame.size.width-FRAME_BUTTON_W, 0, FRAME_BUTTON_W, FRAME_BUTTON_H);
    [self.btnAdd setHidden:YES];
    [self.btnReduct setHidden:YES];
    NSUInteger buyCount = [[DataAdapter shareInstance]numInShoppingCart:((ProductShowingDetail*)self.object).productId];
    if (buyCount > 0)
    {
        [self.btnNum setHidden:NO];
        [self.btnNum setTitle:[NSString stringWithFormat:@"%d", buyCount] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnNum setHidden:YES];
    }
}


- (CGPoint)realImgViewCenter
{
    NSLog(@"ori x=%f,y=%f", self.imageView.center.x, self.imageView.center.y);
    CGPoint real = [self.imageView convertPoint:self.imageView.center toView:self.superview.superview.superview.superview];
    NSLog(@"real x=%f,y=%f", real.x, real.y);
    return real;
}

- (UIImageView*)imageViewCopy
{
    UIImageView* tmp = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    NSLog(@"x=%f, y=%f", self.imageView.frame.origin.x, self.imageView.frame.origin.y);
    tmp.image = self.imageView.image;
    tmp.clipsToBounds = YES;
    tmp.center = [self realImgViewCenter];
    return tmp;

}
@end
