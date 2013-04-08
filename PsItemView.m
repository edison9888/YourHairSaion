//
//  PsItemView.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PsItemView.h"
#import "PsDataItem.h"


#define MARGIN 3
static UIImage* imgDefalut;

@interface PsItemView ()

- (void)reflash;
@end

@implementation PsItemView
@synthesize  content, selectedImg;
@synthesize
imageView = _imageView,
captionLabel = _captionLabel;

- (id)initWithFrame:(CGRect)frame {
    NSLog(@"%s", __FUNCTION__);
    if (imgDefalut == nil)
    {
        imgDefalut = [UIImage imageNamed:@"41.JPG"];
    }
    self = [super initWithFrame:frame];
    if (self)
    {/*
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
        
        CALayer *layer = [self layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = MARGIN;
        //添加四个边阴影
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowOpacity = 0.5;
        layer.shadowRadius = 10.0;
        //添加两个边阴影
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(4, 4);
        layer.shadowOpacity = 0.5;
        layer.shadowRadius = 2.0;
        
        */

        self.backgroundColor = [UIColor clearColor];//[UIColor clearColor];
        self.content = [[UIView alloc]init];
        self.content.userInteractionEnabled = NO;
        //self.content.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgLeftImg.png"]];
        self.exclusiveTouch = YES;
        UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentOnTap:)];
        [tapRecongnizer setNumberOfTapsRequired:1];
        //[self.content addGestureRecognizer:tapRecongnizer];
        

        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.imageView.layer.borderWidth = 5.0f;
        [self.content addSubview:self.imageView];

        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 1;
        self.captionLabel.backgroundColor = [UIColor clearColor];
        [self.content addSubview:self.captionLabel];
        
        [self addSubview:self.content];
        
        
        

        
        self.selectedImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imgSelected.png"]];
        [self.selectedImg setHidden:YES];
        [self addSubview:self.self.selectedImg];

    }
    return self;
}

- (void)prepareForReuse {
    NSLog(@"%s", __FUNCTION__);

    [super prepareForReuse];
    self.imageView.image = nil;
    self.captionLabel.text = nil;
}


- (void)layoutSubviews {
    NSLog(@"%s", __FUNCTION__);

    [super layoutSubviews];
    [self reflash];
    
    
    self.selectedImg.frame = CGRectMake(FRAME_BUTTON_W, 0, 23, 55);
    CGFloat width = self.frame.size.width - FRAME_BUTTON_W;
    CGFloat top = FRAME_BUTTON_H/2;
    CGFloat left = FRAME_BUTTON_W/2;
    
    CGFloat contentWidth = self.frame.size.width - MARGIN * 2 - FRAME_BUTTON_W;
    CGFloat contentTop = MARGIN;
    CGFloat contentLeft = MARGIN;
    
    
    // Image
    //UIImage* uiObj = self.object;
    CGFloat objectWidth = self.imageView.image.size.width;
    CGFloat objectHeight = objectWidth;//is.uiImg.size.height;
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
    self.imageView.frame = CGRectMake(contentLeft, contentTop, contentWidth, contentWidth);
    // Label
//    if (![self.object isShowCaption])
//    {
//        self.captionLabel.frame = CGRectZero;
//        self.content.frame = CGRectMake(left, top, width, scaledHeight/*+MARGIN*2*/);
//    }
//    else
//    {
//        CGSize labelSize = CGSizeZero;
//        //labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(contentWidth, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
//        labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
//        self.content.frame = CGRectMake(left, top, width, scaledHeight+labelSize.height+MARGIN*2);
//        top = self.imageView.frame.origin.y + self.imageView.frame.size.height;
//        self.captionLabel.frame = CGRectMake(contentLeft, top, contentWidth, labelSize.height);
//        self.captionLabel.textAlignment = UITextAlignmentCenter;
//
//    }
    
    if (![self.object isShowCaption])
    {
        self.captionLabel.frame = CGRectZero;
        self.content.frame = CGRectMake(left, top, width, scaledHeight+MARGIN*2);
    }
    else
    {
        CGSize labelSize = CGSizeZero;
        //labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(contentWidth, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
        labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
        self.content.frame = CGRectMake(left, top, width, scaledHeight+labelSize.height+MARGIN*3);
        top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
        self.captionLabel.frame = CGRectMake(contentLeft, top, contentWidth, labelSize.height);
        self.captionLabel.textAlignment = UITextAlignmentCenter;
    }
    
    /*
    CALayer *layer = [self.content layer];
//    layer.borderColor = [[UIColor whiteColor] CGColor];
//    layer.borderWidth = 0;

    //添加两个边阴影
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(4, 4);
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 4.0;
    //layer.masksToBounds = YES;
    layer.shadowPath = [UIBezierPath bezierPathWithRect:self.imageView.frame].CGPath;
    
    
    layer = [self.imageView layer];
    layer.cornerRadius = 10.0f;
     */

}

- (void)fillViewWithObject:(id)object
{    NSLog(@"%s", __FUNCTION__);

    [super fillViewWithObject:object];
    
    self.imageView.image = [((PsDataItem*)object) defaultImgLink];
    self.captionLabel.text = ((PsDataItem*)object).name;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    NSLog(@"%s", __FUNCTION__);
    return columnWidth;
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN;
    PsDataItem* item = object;
    UIImage* img = [item defaultImgLink];
    CGFloat objectWidth = img.size.width;    CGFloat objectHeight = objectWidth + 20;//is.uiImg.size.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
    
    // Label
    NSString *caption = item.name;
    CGSize labelSize = CGSizeZero;
    if (![item isShowCaption])
    {
        UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
        labelSize = [caption sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        height -= 30;
    }
    height += labelSize.height;
    height += MARGIN*2;
    return height;
}

- (void)setContentBackGroundColor:(UIColor *)backgroundColor
{
    NSLog(@"%s", __FUNCTION__);

    self.content.layer.borderColor = [backgroundColor CGColor];
}

- (void)reflash
{
    NSLog(@"%s", __FUNCTION__);

    [self setContentBackGroundColor:[UIColor clearColor]];
}


- (void)contentOnTap:(id)sender
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)productReduce:(id)sender
{
    NSLog(@"%s", __FUNCTION__);

    [self.productBuyingDelegate productReduct:self];
}

- (void)productAdd:(id)sender
{
    NSLog(@"%s", __FUNCTION__);

    [self.productBuyingDelegate productAdd:self];
    
}

- (void)prepareToBuy
{
}

- (void)finishToBuy
{
}

- (void)productAdd
{
}

- (void)productReduct
{
}


- (CGPoint)realImgViewCenter
{
    NSLog(@"%s", __FUNCTION__);

    NSLog(@"ori x=%f,y=%f", self.imageView.center.x, self.imageView.center.y);
    CGPoint real = [self.imageView convertPoint:self.imageView.center toView:self.superview.superview.superview.superview];
    NSLog(@"real x=%f,y=%f", real.x, real.y);
    return real;
}

- (UIImageView*)imageViewCopy
{
    NSLog(@"%s", __FUNCTION__);

    UIImageView* tmp = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    NSLog(@"x=%f, y=%f", self.imageView.frame.origin.x, self.imageView.frame.origin.y);
    tmp.image = self.imageView.image;
    tmp.clipsToBounds = YES;
    tmp.center = [self realImgViewCenter];
    return tmp;
    
}

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        //[self setContentBackGroundColor:COLOR_SELECT];
        [selectedImg setHidden:YES];
        self.captionLabel.textColor = COLOR_LIGHTBLUE;

    }
    else
    {
        //[self setContentBackGroundColor:[UIColor whiteColor]];

        [selectedImg setHidden:YES];
        self.captionLabel.textColor = [UIColor darkGrayColor];

    }
}

@end
