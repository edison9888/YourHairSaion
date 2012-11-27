//
//  ModelController.m
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ModelController.h"

#import "DetailViewController.h"
#import "ProductViewController.h"
#import "DataAdapter.h"
#import "MapViewController.h"
#import "OrgDetailViewController.h"
#import "MapPsViewController.h"
#import "DiscountCardDetailViewController.h"
#import "DiscountPsViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
{
    int itemsPerPage;
    int pageCount;
    int currentPage;
    enumViewControllerType currentVcType;
}

@property (nonatomic, strong) NSString* currentFilter;
@property (nonatomic, strong) NSMutableDictionary* leftViewController;
@property (nonatomic, strong) NSMutableDictionary* rightViewController;

@property (readonly, strong, nonatomic) NSArray *pageData;
- (void)loadViewControllers;
@property (nonatomic, strong) DetailViewController* nextDetailViewController;

- (NSString*)genKey:(NSUInteger)pageIndex andVcType:(enumViewControllerType)vcType andSubType:(NSString*)subType;
@end

@implementation ModelController
@synthesize rootViewController, leftViewController, rightViewController, currentFilter;
- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = [[dateFormatter monthSymbols] copy];
        itemsPerPage = ITEMS_PER_PAGE;
        pageCount = 0;
        currentPage = 0;
        self.leftViewController = [[NSMutableDictionary alloc]init];
        self.rightViewController = [[NSMutableDictionary alloc]init];
        currentVcType = ViewControllerProduct;
        self.currentFilter = nil;
    }
    return self;
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    // Create a new view controller and pass suitable data.
    int recodeCount = [[DataAdapter shareInstance] count];
    int fromIndex = index / 2 * itemsPerPage;
    int toIndex = fromIndex + itemsPerPage - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    NSLog(@"record count[%d], page count[%d], current page[%d], record from[%d], to[%d], index[%d]", recodeCount, pageCount, currentPage, fromIndex, toIndex, index);
    if (currentVcType == ViewControllerProduct)
    {
        if (index % 2) //right side
        {
            NSString* key = [self genKey:index andVcType:ViewControllerDetail andSubType:currentFilter];
            DetailViewController* dvc = [self.rightViewController objectForKey:key];
            if (nil == dvc)
            {
                dvc = [[DetailViewController alloc]init];
                dvc.rootViewController = self.rootViewController;
                //gen the product VC at the left side
                NSString* keyForLeft = [self genKey:index - 1 andVcType:ViewControllerProduct andSubType:currentFilter];
                ProductViewController* pvc = [self.leftViewController objectForKey:keyForLeft];
                if ( nil == pvc)
                {
                    pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
                    pvc.rootViewController = self.rootViewController;
                    [self.leftViewController setObject:pvc forKey:keyForLeft];
                    
                }
                else
                {
                    pvc.detailViewController = dvc;
                }
                dvc.productViewController = pvc;
                [self.rightViewController setObject:dvc forKey:key];
                [self.leftViewController setObject:pvc forKey:keyForLeft];
                
            }
            return dvc;
        }
        else //left side
        {
            NSString* key = [self genKey:index andVcType:ViewControllerProduct andSubType:currentFilter];
            ProductViewController* pvc = [self.leftViewController objectForKey:key];
            if (nil == pvc)
            {
                NSString* keyForRight = [self genKey:index + 1 andVcType:ViewControllerDetail andSubType:currentFilter];
                DetailViewController *dvc = [self.rightViewController objectForKey:keyForRight];
                if ( nil == dvc)
                {
                    dvc = [[DetailViewController alloc]init];
                    dvc.rootViewController = self.rootViewController;
                    
                }
                pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
                [pvc setPageCount:pageCount];
                dvc.productViewController = pvc;
                pvc.rootViewController = self.rootViewController;
                
                [self.rightViewController setObject:dvc forKey:keyForRight];
                [self.leftViewController setObject:pvc forKey:key];
            }
            return pvc;
        }
    }
    else if (ViewControllerMap == currentVcType)
    {
        if ([[self currentSubType] isEqualToString:MAP_SUBTYPE_MAP])
        {
            if (index % 2)
            {
                return [self.rightViewController objectForKey:[self genKey:index andVcType:currentVcType andSubType:self.currentFilter]];
            }
            else
            {
                NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
                MapViewController* mvc = [self.leftViewController objectForKey:key];
                if (nil == mvc)
                {
                    mvc = [[MapViewController alloc]init];
                    NSString* keyForRight = [self genKey:index+1 andVcType:currentVcType andSubType:self.currentFilter];
                    OrgDetailViewController* ovc = [self.rightViewController objectForKey:keyForRight];
                    if (nil == ovc)
                    {
                        ovc = [[OrgDetailViewController alloc] initWithNibName:@"OrgDetailTableView" bundle:nil];
                    }
                    mvc.detailOnMap = ovc;
                    [self.rightViewController setObject:ovc forKey:keyForRight];
                    [self.leftViewController setObject:mvc forKey:key];
                }
                return mvc;
            }
        }
        else
        {
            recodeCount = [[DataAdapter shareInstance].organizations count];
            fromIndex = index / 2 * itemsPerPage;
            toIndex = fromIndex + itemsPerPage - 1;
            toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
            NSLog(@"record count[%d], page count[%d], current page[%d], record from[%d], to[%d], index[%d]", recodeCount, pageCount, currentPage, fromIndex, toIndex, index);
            if (index % 2) //right side
            {
                NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
                OrgDetailViewController* odv = [self.rightViewController objectForKey:key];
                if (nil == odv)
                {
                    odv = [[OrgDetailViewController alloc] init];//initWithNibName:@"PsDetailViewController" bundle:nil];
                    //gen the product VC at the left side
                    NSString* keyForLeft = [self genKey:index - 1 andVcType:currentVcType andSubType:currentFilter];
                    MapPsViewController* mpvc = [self.leftViewController objectForKey:keyForLeft];
                    if ( nil == mpvc)
                    {
                        mpvc = [[MapPsViewController alloc]initProductViewControllerWithTitle:@"分店介绍" fromIndex:fromIndex endIndex:toIndex withDetailViewController:odv];
                        mpvc.rootViewController = self.rootViewController;
                        [mpvc setPageCount:pageCount];
                        [self.leftViewController setObject:mpvc forKey:keyForLeft];
                        
                    }
                    else
                    {
                        mpvc.detailViewController = odv;
                    }
                    odv.psViewController = mpvc;
                    [self.rightViewController setObject:odv forKey:key];
                    [self.leftViewController setObject:mpvc forKey:keyForLeft];
                    
                }
                return odv;
            }
            else //left side
            {
                NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
                MapPsViewController* mpvc = [self.leftViewController objectForKey:key];
                if (nil == mpvc)
                {
                    NSString* keyForRight = [self genKey:index + 1 andVcType:currentVcType andSubType:currentFilter];
                    OrgDetailViewController *odv = [self.rightViewController objectForKey:keyForRight];
                    if ( nil == odv)
                    {
                        odv = [[OrgDetailViewController alloc] init];//initWithNibName:@"OrgDetailTableView" bundle:nil];
                    }
                    mpvc = [[MapPsViewController alloc]initProductViewControllerWithTitle:@"分店介绍" fromIndex:fromIndex endIndex:toIndex withDetailViewController:odv];
                    [mpvc setPageCount:pageCount];
                    odv.psViewController = mpvc;
                    mpvc.rootViewController = self.rootViewController;
                    
                    [self.rightViewController setObject:odv forKey:keyForRight];
                    [self.leftViewController setObject:mpvc forKey:key];
                }
                return mpvc;
            }
        }
    }
    else if (ViewControllerShoppingCart == currentVcType)
    {
        if (index % 2) //right side
        {
            NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
            DetailViewController* dvc = [self.rightViewController objectForKey:key];
            if (nil == dvc)
            {
                dvc = [[DetailViewController alloc]init];
                dvc.rootViewController = self.rootViewController;
                //gen the product VC at the left side
                NSString* keyForLeft = [self genKey:index - 1 andVcType:currentVcType andSubType:currentFilter];
                ProductViewController* pvc = [self.leftViewController objectForKey:keyForLeft];
                if ( nil == pvc)
                {
                    pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
                    pvc.rootViewController = self.rootViewController;
                    [self.leftViewController setObject:pvc forKey:keyForLeft];
                    
                }
                else
                {
                    pvc.detailViewController = dvc;
                }
                dvc.productViewController = pvc;
                [self.rightViewController setObject:dvc forKey:key];
                [self.leftViewController setObject:pvc forKey:keyForLeft];
                
            }
            return dvc;
        }
        else //left side
        {
            NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
            ProductViewController* pvc = [self.leftViewController objectForKey:key];
            if (nil == pvc)
            {
                NSString* keyForRight = [self genKey:index + 1 andVcType:currentVcType andSubType:currentFilter];
                DetailViewController *dvc = [self.rightViewController objectForKey:keyForRight];
                if ( nil == dvc)
                {
                    dvc = [[DetailViewController alloc]init];
                    dvc.rootViewController = self.rootViewController;
                    
                }
                pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
                [pvc setPageCount:pageCount];
                dvc.productViewController = pvc;
                pvc.rootViewController = self.rootViewController;
                
                [self.rightViewController setObject:dvc forKey:keyForRight];
                [self.leftViewController setObject:pvc forKey:key];
            }
            else
            {
                [pvc setRangWithFromIndex:fromIndex toIndex:toIndex];
                [pvc reloadData];
            }
            return pvc;
        }
    }
    else if (ViewControllerPolicy == currentVcType)
    {
        recodeCount = [[DataAdapter shareInstance].discountCards count];
        fromIndex = index / 2 * itemsPerPage;
        toIndex = fromIndex + itemsPerPage - 1;
        toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
        NSLog(@"record count[%d], page count[%d], current page[%d], record from[%d], to[%d], index[%d]", recodeCount, pageCount, currentPage, fromIndex, toIndex, index);
        if (index % 2) //right side
        {
            NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
            DiscountCardDetailViewController* ddvc = [self.rightViewController objectForKey:key];
            if (nil == ddvc)
            {
                ddvc = [[DiscountCardDetailViewController alloc] init];
                NSString* keyForLeft = [self genKey:index - 1 andVcType:currentVcType andSubType:currentFilter];
                DiscountPsViewController* dpvc = [self.leftViewController objectForKey:keyForLeft];
                if ( nil == dpvc)
                {
                    dpvc = [[DiscountPsViewController alloc]initProductViewControllerWithTitle:@"会员优惠" fromIndex:fromIndex endIndex:toIndex withDetailViewController:ddvc];
                    dpvc.rootViewController = self.rootViewController;
                    [dpvc setPageCount:pageCount];
                    [self.leftViewController setObject:dpvc forKey:keyForLeft];
                    
                }
                else
                {
                    dpvc.detailViewController = ddvc;
                }
                ddvc.psViewController = dpvc;
                [self.rightViewController setObject:ddvc forKey:key];
                [self.leftViewController setObject:dpvc forKey:keyForLeft];
                
            }
            return ddvc;
        }
        else //left side
        {
            NSString* key = [self genKey:index andVcType:currentVcType andSubType:currentFilter];
            DiscountPsViewController* dpvc = [self.leftViewController objectForKey:key];
            if (nil == dpvc)
            {
                NSString* keyForRight = [self genKey:index + 1 andVcType:currentVcType andSubType:currentFilter];
                DiscountCardDetailViewController *ddvc = [self.rightViewController objectForKey:keyForRight];
                if ( nil == ddvc)
                {
                    ddvc = [[DiscountCardDetailViewController alloc] init];
                }
                dpvc = [[DiscountPsViewController alloc]initProductViewControllerWithTitle:@"会员优惠" fromIndex:fromIndex endIndex:toIndex withDetailViewController:ddvc];
                [dpvc setPageCount:pageCount];
                ddvc.psViewController = dpvc;
                dpvc.rootViewController = self.rootViewController;
                
                [self.rightViewController setObject:ddvc forKey:keyForRight];
                [self.leftViewController setObject:dpvc forKey:key];
            }
            return dpvc;
        }
    }
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    if ([viewController isKindOfClass:[DetailViewController class]])
    {
        return [((DetailViewController*)viewController) indexInPage];
    }
    else if ([viewController isKindOfClass:[ProductViewController class]])
    {
        return [((ProductViewController*)viewController) indexInPage];
    }
    else if ([viewController isKindOfClass:[MapViewController class]])
    {
        if ([[self currentSubType] isEqualToString:MAP_SUBTYPE_LIST])
        {
            return [((MapPsViewController*)viewController) indexInPage];
        }
        else
        {
            return 0;
        }
    }
    else if ([viewController isKindOfClass:[OrgDetailViewController class]])
    {
        if ([[self currentSubType] isEqualToString:MAP_SUBTYPE_LIST])
        {
            return [((OrgDetailViewController*)viewController) indexInPage];
        }
        else
        {
            return 1;
        }
    }
    else if ([viewController isKindOfClass:[PsViewController class]])
    {
        return [((PsViewController*)viewController) indexInPage];
    }
    else if ([viewController isKindOfClass:[PsDetailViewController class]])
    {
        return [((PsDetailViewController*)viewController) indexInPage];
    }
    return 0;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index <= 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index --;
    currentPage --;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //    [((DetailViewController*)viewController) fillData:nil];
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index <= 0) || (index == NSNotFound) || index > (pageCount - 1) * 2 )
    {
        return nil;
    }
    
    index++;
    currentPage ++;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}


- (NSString*)genKey:(NSUInteger)pageIndex andVcType:(enumViewControllerType)vcType andSubType:(NSString *)subType
{
    NSString* key = nil;
    switch (vcType) {
        case ViewControllerProduct:
            key = [NSString stringWithFormat:@"Product%@%d", subType == nil ? @"ALL" : subType, pageIndex];
            break;
        case ViewControllerDetail:
            key = [NSString stringWithFormat:@"Detail%@%d", subType == nil ? @"ALL" : subType, pageIndex];
            break;
        case ViewControllerMap:
            key = [NSString stringWithFormat:@"Map%@%d", subType, pageIndex];
            break;
        case ViewControllerPolicy:
            key = [NSString stringWithFormat:@"Policy%d", pageIndex];
            break;
        case ViewControllerShoppingCart:
            key = [NSString stringWithFormat:@"ShoppingCart%d", pageIndex];
            break;
        default:
            break;
    }
    return key;
}

- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType
{
    currentVcType = enumVcType;
    self.currentFilter = subType;
    if (currentVcType == ViewControllerProduct)
    {
        [[DataAdapter shareInstance]setFilterByTypeId:subType];
        int recodeCount = [[DataAdapter shareInstance] count];
        pageCount = recodeCount / itemsPerPage;
        pageCount = pageCount % itemsPerPage == 0 ? pageCount : pageCount + 1;
    }
    else if (currentVcType == ViewControllerMap)
    {
        if ([subType isEqualToString:MAP_SUBTYPE_LIST])
        {
            int recodeCount = [[DataAdapter shareInstance].organizations count];
            pageCount = recodeCount / itemsPerPage;
            pageCount = pageCount % itemsPerPage == 0 ? pageCount : pageCount + 1;
        }
        else
        {
            pageCount = 0;
        }
    }
    else if (currentVcType == ViewControllerPolicy)
    {
        int recodeCount = [[DataAdapter shareInstance].discountCards count];
        pageCount = recodeCount / itemsPerPage;
        pageCount = pageCount % itemsPerPage == 0 ? pageCount : pageCount + 1;
    }
    else if (currentVcType == ViewControllerShoppingCart)
    {
        [[DataAdapter shareInstance]setFilterByTypeId:STRING_FOR_SHOPPING_CART_FILTER];
        int recodeCount = [[DataAdapter shareInstance] count];
        pageCount = recodeCount / itemsPerPage;
        pageCount = pageCount % itemsPerPage == 0 ? pageCount : pageCount + 1;
    }
}

- (NSUInteger)pageCount
{
    return pageCount;
}




- (enumViewControllerType)currentVCType
{
    return currentVcType;
}
- (NSString*)currentSubType
{
    return self.currentFilter;
}

@end
