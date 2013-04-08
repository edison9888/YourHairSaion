//
//  MyTabBarController.h
//  UITest3
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarController : UITabBarController
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton* btn3;
    UIButton* btn4;
}
- (void)hideExistingTabBar;
-(void) addCustomElements;
- (void)selectTab:(int)tab;
@end
