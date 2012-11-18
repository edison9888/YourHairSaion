//
//  RootViewController.h
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGTabBarController.h"
#import "MyTabBarViewController.h"
#import "ProductViewController.h"
@class MyToolBar;
@class DetailViewController;
typedef enum {
    LeftTabBarViewControllerProduct = 0,
    LeftTabBarViewControllerPolicy,
    LeftTabBarViewControllerMap,
    LeftTabBarViewControllerShoppingCart
} LeftTabBarViewControllerItem;


#define SPLIT_POSITION_MID 512.0f
#define SPLIT_POSITION_RIGHT_END 1024.0f

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, strong) MyTabBarViewController* leftTabBarController;
@property (nonatomic, strong) MyTabBarViewController* rightTabBarController;
@property (nonatomic, strong) ProductViewController* productViewController;
@property (nonatomic, strong) DetailViewController* detailViewController;
@property (nonatomic, strong) MyToolBar* leftToolBar;


- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType;
@end
