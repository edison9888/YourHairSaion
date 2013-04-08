//
//  MyBaseButtonYellow.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "MyBaseButtonYellow.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyBaseButtonYellow

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

- (void)setup
{
    //self.layer.cornerRadius = 10;
    self.layer.backgroundColor = [COLOR_ORANGE CGColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    self.titleLabel.textColor = [UIColor whiteColor];

    //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bt_yellow.png"]];
//    [self setImage:[UIImage imageNamed:@"bt_yellow.png"] forState:UIControlStateNormal];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

}

//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
////    self.layer.shadowColor = [UIColor blackColor].CGColor;
////    self.layer.shadowOffset = CGSizeMake(0, 9);
////    self.layer.shadowOpacity = 0.5;
////    self.layer.shadowRadius = 1;
////    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//
//}
//
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    int len = [title length];
    len = len <= 2 ? 2 : len;
    len = len >= 5 ? 5 : len;
    NSString* bgImgLink = [NSString stringWithFormat:@"bt_yellow_%d.png", len];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:bgImgLink]];
    [super setTitle:title forState:UIControlStateNormal];
    CGRect rect = self.frame;
    rect.size.height = 21.5;
    switch (len)
    {
        case 2:
            rect.size.width = 35;
            break;
        case 3:
            rect.size.width = 42;
            break;
        case 4:
            rect.size.width = 48;
            break;
        case 5:
            rect.size.width = 57;
            break;
        default:
            rect.size.width = 35;
            break;
    }
    self.frame = rect;
    
    rect = self.titleLabel.frame;
    rect.origin.x -= 2;
    self.titleLabel.frame = rect;
}


@end
