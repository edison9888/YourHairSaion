//
//  L2Button.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L2Button.h"
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "L1Button.h"

@implementation L2Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        CALayer *layer = [self layer];
//        //添加四个边阴影
//        //        layer.shadowColor = [UIColor blackColor].CGColor;
//        //        layer.shadowOffset = CGSizeMake(0, 0);
//        //        layer.shadowOpacity = 0.5;
//        //        layer.shadowRadius = 10.0;
//        //添加两个边阴影
//        layer.shadowColor = [UIColor blackColor].CGColor;
//        layer.shadowOffset = CGSizeMake(0, 10);
//        layer.shadowOpacity = 10;
//        layer.shadowRadius = 10.0;
//        layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;

    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    //donothing
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)onTouchUp:(id)sender
{
    if (![self.pagePolicy isEqual:[self.rvc pagePolicy]])
    {
        [self.rvc setPagePolicy:self.pagePolicy];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L2Button class]])
            {
                [self.rvc.view putSubview:view aboveSubview:self.rvc.ivBack];
                
                //self.titleLabel.textColor = [UIColor whiteColor];
                
            }
        }
//        [self.rvc.view bringSubviewToFront:self.superview];
        [self.rvc.view bringSubviewToFront:self];
        [self.l1Btn setStateOnTouch:NO];
        //self.titleLabel.textColor = [UIColor blackColor];
        //self.tintColor = [UIColor blackColor];
    }
}


//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    BOOL ret =  [super pointInside:point withEvent:event];
//    if (ret == YES)
//    {
//        NSLog(@"point:%f, %f", point.x, point.y);
//    }
//    if(point.x > FRAME_L2LSide_Btn_First_X && point.x < (FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*MAX_L2Button_NUM))
//    {
//        return YES;
//    }
//    return ret;
//}

@end
