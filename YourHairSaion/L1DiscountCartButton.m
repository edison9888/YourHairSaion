//
//  L1DiscountCartButton.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-19.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "L1DiscountCartButton.h"

@implementation L1DiscountCartButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (L1DiscountCartButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy *)pagePolicy andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
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

@end
