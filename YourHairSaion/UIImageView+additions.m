//
//  UIImageView+additions.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-4.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "UIImageView+additions.h"

@implementation UIImageView (additions)
- (CGSize)imageScale
{
    CGFloat sx = self.frame.size.width / self.image.size.width;
    CGFloat sy = self.frame.size.height / self.image.size.height;
    CGFloat s = 1.0;
    switch (self.contentMode)
    {
        case UIViewContentModeScaleAspectFit:
            s = fminf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleAspectFill:
            s = fmaxf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleToFill:
            return CGSizeMake(sx, sy);
            
        default:
            return CGSizeMake(s, s);
    }
}

- (void)setWidth:(CGFloat)width
{
    if (self.image)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height* (width/self.image.size.width));
    }
    else
    {
        self.bounds = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height);
    }
}

@end

