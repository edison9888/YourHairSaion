//
//  MyBaseButton.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-30.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "MyBaseButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyBaseButton

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
    self.titleLabel.textColor = [UIColor whiteColor];
    CGSize labelSize = CGSizeZero;
    labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:self.titleLabel.lineBreakMode];
    CGRect rect = self.frame;
    rect.size.width = labelSize.width+15;
    self.frame = rect;
}

- (void)setup
{
    self.layer.cornerRadius = 10;
    self.layer.backgroundColor = [COLOR_GRAY CGColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    self.titleLabel.textColor = [UIColor whiteColor];

}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.layer.backgroundColor = [backgroundColor CGColor];
}
@end
