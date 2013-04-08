//
//  L1RightButton.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-19.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "L1RightButton.h"
#import "L1Button.h"
#import "RootViewController.h"
#import "L2Button.h"


@implementation L1RightButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (L1RightButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy *)pagePolicy andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    
    self = [super initAll:frame andPagePolicy:pagePolicy andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    [self setVerticalTitle:title];
    if (self)
    {
        
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
    [super onTouchUp:sender];
    if (![self.pagePolicy isEqual:[self.rvc pagePolicy]])
    {
        [self.rvc setPagePolicy:self.pagePolicy];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L1Button class]])
            {
                [((L1Button*)view) setOnTouch:NO];
            }
            if ([view isKindOfClass:[L2Button class]])
            {
                [((L2Button*)view) setHidden:YES];
            }
            if ([view isKindOfClass:[L1RightButton class]])
            {
                [((L1RightButton*)view)setStateOnTouch:NO];
            }

        }
    [self setStateOnTouch:YES];
    }
}

- (void)setStateOnTouch:(BOOL)touched
{
    if (touched)
    {
        [self.rvc.view bringSubviewToFront:self];
    }
    else
    {
        [self.rvc.view putSubview:self aboveSubview:self.rvc.ivRight];

    }
}
@end
