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

#import "MapPsItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "PsItemView.h"
#import "PsDataItem.h"

#define MARGIN 7

@interface MapPsItemView ()
@property (nonatomic, strong)UIImageView* ivBackground;
@property (nonatomic, strong)UIImageView* ivFrontground;

@property (nonatomic, strong)UIImage* imgNormal;
@property (nonatomic, strong)UIImage* imgSelected;

@end

@implementation MapPsItemView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imgNormal = [UIImage imageNamed:@"map_left_pic.png"];
        self.imgSelected = [UIImage imageNamed:@"map_left_pic_hit.png"];
        self.ivBackground = [[UIImageView alloc]initWithImage:self.imgNormal];
        self.ivBackground.contentMode = UIViewContentModeScaleAspectFill;
        [self.content insertSubview:self.ivBackground atIndex:0];
        self.imageView.layer.borderWidth = 0;
        self.ivFrontground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map_left_pic_bright.png"]];
        self.ivFrontground.contentMode = UIViewContentModeScaleAspectFit;
        [self.content addSubview:self.ivFrontground];
    }
    return self;
}


- (void)layoutSubviews
{
    NSLog(@"%s", __FUNCTION__);
    
    [super layoutSubviews];
    [self reflash];
    self.backgroundColor = nil;
    self.content.backgroundColor = [UIColor clearColor];
    self.captionLabel.font = [UIFont boldSystemFontOfSize:12];
    self.captionLabel.textColor = [UIColor darkGrayColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
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
    
    self.ivBackground.frame = CGRectMake(0, 0, self.content.bounds.size.width, self.imageView.bounds.size.height+2*MARGIN);
    self.ivFrontground.frame = self.imageView.frame;
    
//    CALayer *layer = [self.imageView layer];
//    layer.borderColor = [[UIColor whiteColor] CGColor];
//    layer.borderWidth = 3;
    /*
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

//- (void)setContentBackGroundColor:(UIColor *)backgroundColor
//{
//    NSLog(@"%s", __FUNCTION__);
//    
//    self.imageView.layer.borderColor = [backgroundColor CGColor];
//}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    return columnWidth  + [UIFont boldSystemFontOfSize:10].xHeight + MARGIN;
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.ivBackground.image = self.imgSelected;
        self.captionLabel.textColor = COLOR_LIGHTBLUE;

    }
    else
    {
        self.ivBackground.image = self.imgNormal;
        self.captionLabel.textColor = [UIColor darkGrayColor];

    }
}
@end
