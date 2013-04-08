//
//  BasePagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "BasePagePolicy.h"
#import "RootViewController.h"
#import "PsViewController.h"

@interface BasePagePolicy()
@property (nonatomic, strong)NSString* subType;
@end
@implementation BasePagePolicy
@synthesize subType=_subType;

- (NSString*)subType
{
    return _subType;
}

- (BOOL)isProduct
{
    return YES;
}
- (UIViewController*)createRightVC
{
    return [[DetailViewController alloc]init];
}
- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase*)dvc andIndex:(NSInteger)index andRvc:(RootViewController*)rvc
{
    int recodeCount = [[DataAdapter shareInstance] count];
    int fromIndex = index / 2 * [self itemPerPage];
    int toIndex = fromIndex + [self itemPerPage] - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    NSLog(@"record count[%d], page count[%d], record from[%d], to[%d], index[%d]", recodeCount, [self calcPageCount], fromIndex, toIndex, index);
    ProductViewController* lvc= [[ProductViewController alloc]initProductViewControllerWithTitle:[self title] fromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
    lvc.rootViewController = rvc;
    lvc.pagePolicy = self;
    return lvc;
}

- (void)loadData:(PsViewController *)pvc
{
    [pvc setPageCount:[self calcPageCount]];
}

- (void)reloadData:(PsViewController *)pvc
{
    
}

- (NSString*)genKey4Index:(NSInteger)index
{
    return [NSString stringWithFormat:@"Product%@%d", _subType == nil ? @"ALL" : _subType, index];
}
- (void)setFilter
{
    [[DataAdapter shareInstance]setFilterByTypeId:_subType];
}

- (NSInteger)calcPageCount
{
    int itemCount = [[DataAdapter shareInstance] count];
    int pageCount = itemCount / [self itemPerPage];
    pageCount = itemCount - (pageCount*[self itemPerPage]) > 0  ? pageCount+1 : pageCount;
    return pageCount;
}
- (NSString*)title
{
    return [[DataAdapter shareInstance]currentFilterLinkString];
}


- (BOOL)need2RefreshWhenAppear
{
    return NO;
}

- (void)refreshData
{
    
}

- (id)initWithSubType:(NSString *)subType
{
    self = [super init];
    if (self)
    {
        self.subType = subType;
        if (nil == self.subType)
        {
            self.subType = @"";
        }
    }
    return self;
}

- (void)bindVcPair:(UIViewController *)rvc withLvc:(UIViewController *)lvc
{
    ((PsDetailViewControllerBase*)rvc).psViewController = (PsViewController*)lvc;
    ((PsViewController*)lvc).detailViewController = (PsDetailViewControllerBase*)rvc;
}

- (BOOL)isEqual:(BasePagePolicy *)object
{
    if ([self class] == [object class] && [self.subType isEqual:object.subType])
        return YES;
    return NO;
}

- (NSInteger)itemPerPage
{
    return ITEMS_PER_PAGE;
}
@end
