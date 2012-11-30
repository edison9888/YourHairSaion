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
@class DetailViewController;
@class ImgFullViewController;
@class StatementViewController;
typedef enum {
    LeftTabBarViewControllerProduct = 0,
    LeftTabBarViewControllerPolicy,
    LeftTabBarViewControllerMap,
    LeftTabBarViewControllerShoppingCart
} LeftTabBarViewControllerItem;


#define SPLIT_POSITION_MID 512.0f
#define SPLIT_POSITION_RIGHT_END 1024.0f


@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, strong) ProductViewController* productViewController;
@property (nonatomic, strong) DetailViewController* detailViewController;
@property (nonatomic, strong) NSMutableArray* l1Btns;
@property (nonatomic, strong) ImgFullViewController* imgFullViewController;
@property (nonatomic, strong) StatementViewController* statementViewController;


- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType;
- (enumViewControllerType)currentVCType;
- (NSString*)currentSubType;
- (void)setPage:(NSInteger)leftPageIndex animated:(BOOL)animated;
- (UIViewController*)page:(NSInteger)index;
@end
