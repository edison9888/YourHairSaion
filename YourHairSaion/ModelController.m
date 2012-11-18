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
                //gen the product VC at the left side
                NSString* keyForLeft = [self genKey:index - 1 andVcType:ViewControllerProduct andSubType:currentFilter];
                ProductViewController* pvc = [self.leftViewController objectForKey:keyForLeft];
                if ( nil == pvc)
                {
                    pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
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
                    
                }
                pvc = [[ProductViewController alloc]initProductViewControllerFromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
                dvc.productViewController = pvc;
                [self.rightViewController setObject:dvc forKey:keyForRight];
                [self.leftViewController setObject:pvc forKey:key];
            }
            return pvc;
        }
    }
    else if (ViewControllerMap == currentVcType)
    {
        if (index % 2)
        {
            return [self.rightViewController objectForKey:[self genKey:index andVcType:ViewControllerMap andSubType:self.currentFilter]];
        }
        else
        {
            NSString* key = [self genKey:index andVcType:ViewControllerMap andSubType:currentFilter];
            MapViewController* mvc = [self.leftViewController objectForKey:key];
            if (nil == mvc)
            {
                mvc = [[MapViewController alloc]init];
                NSString* keyForRight = [self genKey:index+1 andVcType:ViewControllerMap andSubType:self.currentFilter];
                OrgDetailViewController* ovc = [self.rightViewController objectForKey:keyForRight];
                if (nil == ovc)
                {
                    ovc = [[OrgDetailViewController alloc] initWithNibName:@"OrgDetailTableView" bundle:nil];
                }
                [self.rightViewController setObject:ovc forKey:keyForRight];
                mvc.detailOnMap = ovc;

            }
            [self.leftViewController setObject:mvc forKey:key];
            return mvc;
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
    return 0;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
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
    if ((index == 0) || (index == NSNotFound) || index / 2 >= pageCount - 1)
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
            key = [NSString stringWithFormat:@"Map%d", pageIndex];
            break;
            case ViewControllerPolicy:
            key = [NSString stringWithFormat:@"Policy%d", pageIndex];
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
        pageCount = 2;
    }
    else if (currentVcType == ViewControllerPolicy)
    {
        pageCount = 2;
    }
}

@end
