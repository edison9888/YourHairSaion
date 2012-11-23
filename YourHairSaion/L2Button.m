//
//  L2Button.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L2Button.h"
#import "RootViewController.h"

@implementation L2Button

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

- (void)onTouchUp:(id)sender
{
    [self.rvc setVcType:self.vcType andSubType:self.subType];
    for (UIView* view in self.rvc.view.subviews)
    {
        if ([view isKindOfClass:[L2Button class]])
        {
            [self.rvc.view sendSubviewToBack:view];
            //self.titleLabel.textColor = [UIColor whiteColor];
            
        }
    }
    [self.rvc.view bringSubviewToFront:self];
    //self.titleLabel.textColor = [UIColor blackColor];
    //self.tintColor = [UIColor blackColor];
    
}

@end
