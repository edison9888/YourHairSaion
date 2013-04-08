//
//  MyBaseButton2.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-5.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "MyBaseButton2.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyBaseButton2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
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
    [super layoutSubviews];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    self.titleLabel.textColor = [UIColor blackColor];
    
}

- (void)setup
{
    self.layer.cornerRadius = 1;
    self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    self.titleLabel.textColor = [UIColor whiteColor];
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.layer.backgroundColor = [backgroundColor CGColor];
    
}

@end
