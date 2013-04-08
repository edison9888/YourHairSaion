//
//  UIView+CornerAddition.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tools)
- (void)setCornerContent:(NSString*)content;
- (void)putSubview:(UIView*)subView aboveSubview:(UIView*)aboveView;
@end
