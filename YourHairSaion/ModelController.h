//
//  ModelController.h
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//


#define ITEMS_PER_PAGE 6

#import <UIKit/UIKit.h>

typedef enum {
    ViewControllerProduct = 0,
    ViewControllerDetail,
    ViewControllerMap,
    ViewControllerPolicy,
    ViewControllerShoppingCart
} enumViewControllerType;

#define MAP_SUBTYPE_MAP   @"MAP"
#define MAP_SUBTYPE_LIST  @"LIST"

@class RootViewController;
@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;
@property (nonatomic, strong) RootViewController* rootViewController;

- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType;
- (NSUInteger)pageCount;
- (enumViewControllerType)currentVCType;
- (NSString*)currentSubType;

+ (NSInteger)calcPageCount:(NSInteger)itemCount;
@end
