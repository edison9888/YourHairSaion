//
//  MySplitViewController.h
//  UITest3
//
//  Created by chen loman on 12-11-9.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGTabBarController.h"

@interface MySplitViewController : UISplitViewController<NGTabBarControllerDelegate>

@property (nonatomic, strong) NGTabBarController* tabBarController;
- (void)loadTabbarController;

@end


