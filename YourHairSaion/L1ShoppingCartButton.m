//
//  L1ShoppingCartButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-7.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L1ShoppingCartButton.h"
#import "CMPopTipView.h"
#import <QuartzCore/QuartzCore.h>


@implementation L1ShoppingCartButton

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

- (L1ShoppingCartButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy *)pagePolicy andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    
    self = [super initAll:frame andPagePolicy:pagePolicy andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    [self setVerticalTitle:title];
    if (self)
    {
        //[self setup];

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
    if ([[DataAdapter shareInstance].productsToBuy count] <= 0 )
    {
        CMPopTipView* popTipView = [[CMPopTipView alloc] initWithMessage:@"亲还木有购买任何产品哦！"];
        //popTipView.delegate = self;
        //popTipView.disableTapToDismiss = YES;
        //popTipView.preferredPointDirection = PointDirectionUp;
//        if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
//            popTipView.backgroundColor = backgroundColor;
//        }
//        if (textColor && ![textColor isEqual:[NSNull null]]) {
//            popTipView.textColor = textColor;
//        }
        popTipView.backgroundColor = [UIColor grayColor];
        popTipView.animation = YES;
        
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
        //if ([sender isKindOfClass:[UIButton class]]) {
            //UIButton *button = (UIButton *)sender;
            [popTipView presentPointingAtView:self inView:self.superview animated:YES];
//        }
//        else {
//            UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
//            [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
//        }
        
//        [visiblePopTipViews addObject:popTipView];
//        self.currentPopTipViewTarget = sender;
    }
    
    else
    {
        [super onTouchUp:sender];
    }
}

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
