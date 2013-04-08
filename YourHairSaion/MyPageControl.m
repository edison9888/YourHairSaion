//
//  MyPageControl.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-2.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        activeImage = [UIImage imageNamed:@"pot_hit.png"];
        inactiveImage = [UIImage imageNamed:@"pot.png"];
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    activeImage = [UIImage imageNamed:@"pot_hit.png"];
    inactiveImage = [UIImage imageNamed:@"pot.png"];

    return self;
}
-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) dot.image = activeImage;
        else dot.image = inactiveImage;
    }
}
-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
