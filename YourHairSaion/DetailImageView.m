//
//  DetailImageView.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-7.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DetailImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "DataAdapter.h"

@implementation DetailImageView
@synthesize rotation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)layoutSubviews
{
    CALayer* layer = self.layer;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 5.0f;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 10.0f;
    layer.shadowRadius = 10.0f;
    layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
}

- (void)setImage:(NSString *)imgLink withType:(NSNumber*)type;
{
    UIImage * img = [UIImage imageWithContentsOfFile:imgLink];
    [super setImage:img];
    //[UIView beginAnimations:@"sdfsdf" context:nil];
    //[UIView setAnimationDuration:5];
    rotation = 0.0f;
    if ([PRODUCT_PIC_TYPE_LEFT isEqualToNumber:type])
    {
        rotation = 10.0f;
    }
    else if ([PRODUCT_PIC_TYPE_RIGHT isEqualToNumber:type])
    {
        rotation = 30.0f;
    }
    else if ([PRODUCT_PIC_TYPE_BACK isEqualToNumber:type])
    {
        rotation = 20.0f;
    }
    if (rotation > 0.0f)
    {
        self.transform = CGAffineTransformMakeRotation(-rotation*M_PI/180.0f);
    }
    
    //[UIView commitAnimations];
    //self.transform = CGAffineTransformIdentity;
    //self.frame = CGRectMake(0, 0, 200, 200);

}
- (void)setRotation:(CGFloat)rota
{
    rotation = rota;
    if (rotation != 0.0f)
    {
        self.transform = CGAffineTransformMakeRotation(-rotation*M_PI/180.0f);
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
    }
}
@end
