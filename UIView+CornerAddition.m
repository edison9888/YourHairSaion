//
//  UIView+CornerAddition.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "UIView+CornerAddition.h"
#import "JSBadgeView.h"

@implementation UIView (Tools)
- (void)setCornerContent:(NSString *)content
{
    if (content == nil || [@"" isEqualToString:content])
    {
        for (UIView* view in self.subviews)
        {
            if ([view isKindOfClass:[JSBadgeView class]])
            {
                [view removeFromSuperview];
            }
        }
    }
    else
    {
        JSBadgeView* view  = [[JSBadgeView alloc]initWithParentView:self alignment:JSBadgeViewAlignmentTopRight];
        view.badgeBackgroundColor = [UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
        view.badgeText = content;
        
    }
}

- (void)putSubview:(UIView *)subView aboveSubview:(UIView *)aboveView
{
    [subView removeFromSuperview];
    [self insertSubview:subView aboveSubview:aboveView];
}
@end
