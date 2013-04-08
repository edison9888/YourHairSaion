//
//  ShoppingCartItemView.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-9.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ShoppingCartItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "DataAdapter.h"


@implementation ShoppingCartItemView

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




- (void)reflash
{    NSLog(@"%s", __FUNCTION__);
    [self setContentBackGroundColor:[UIColor clearColor]];
//    self.content.backgroundColor = [UIColor whiteColor];

}


@end
