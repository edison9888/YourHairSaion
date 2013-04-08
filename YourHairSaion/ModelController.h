//
//  ModelController.h
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//


#define ITEMS_PER_PAGE 12
#define ITEMS_PER_PAGE_DISCOUNT_CARD 12
#define ITEMS_PER_PAGE_MAP   12


#import <UIKit/UIKit.h>
/*
typedef enum {
    ViewControllerProduct = 0,
    ViewControllerDetail,
    ViewControllerMap,
    ViewControllerPolicy,
    ViewControllerShoppingCart,
    ViewControllerSearch
} enumViewControllerType;
*/
#define MAP_SUBTYPE_MAP   @"MAP"
#define MAP_SUBTYPE_LIST  @"LIST"

@class RootViewController;
@class BasePagePolicy;
@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;
@property (nonatomic, strong) RootViewController* rootViewController;

//- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType;
- (NSUInteger)pageCount;
//- (enumViewControllerType)currentVCType;
//- (NSString*)currentSubType;

+ (NSInteger)calcPageCount:(NSInteger)itemCount;

- (void)setPagePolicy:(BasePagePolicy*)basepagePolicy;
- (BasePagePolicy*)pagePolicy;

- (void)reset;
@end
