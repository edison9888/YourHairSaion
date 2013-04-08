//
//  MapPsViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-24.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MapPsViewController.h"
#import "MapPsItemView.h"
#import "OrganizationItem.h"
#import "DataAdapter.h"
#import "RootViewController.h"
#import "MyBaseButton2.h"
#import "MapViewController.h"

@interface MapPsViewController ()
@property (nonatomic, strong)MapViewController* mapVc;
@property (nonatomic, strong)UIButton* btnMap;
@property (nonatomic, strong)UIButton* btnList;
- (void)onMap:(id)sender;
- (void)onList:(id)sender;
@end

@implementation MapPsViewController
@synthesize btnList, btnMap;
- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    for (int i = self.fromIndex; i <= self.toIndex; i++)
    {
        OrganizationItem* item = [[OrganizationItem alloc]initWithObject:dataAdapter.organizations[i]];
        [self.items addObject:item];
    }
    [self dataSourceDidLoad];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnMap = [[UIButton alloc]initWithFrame:CGRectMake(320, 27, 62, 20)];
//    [btnMap setTitle:@"地图" forState:UIControlStateNormal];
    [btnMap setImage:[UIImage imageNamed:@"map_bt@2x.png"] forState:UIControlStateNormal];
    [btnMap setImage:[UIImage imageNamed:@"map_hit_bt@2x.png"] forState:UIControlStateSelected];

    [btnMap addTarget:self action:@selector(onMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMap];
    btnList = [[UIButton alloc]initWithFrame:CGRectMake(382, 27, 62, 20)];
    [btnList setImage:[UIImage imageNamed:@"list_bt@2x.png"] forState:UIControlStateNormal];
    [btnList setImage:[UIImage imageNamed:@"list_hit_bt@2x.png"] forState:UIControlStateSelected];
    [btnList addTarget:self action:@selector(onList:) forControlEvents:UIControlEventTouchUpInside];
    [btnList setSelected:YES];
    [self.view addSubview:btnList];
    self.mapVc = [[MapViewController alloc]init];
    self.mapVc.detailOnMap = self.detailViewController;
    [self.mapVc.view setHidden:YES];
    [self.view addSubview:self.mapVc.view];
    

}
/*

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    MapPsItemView *v = (MapPsItemView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[MapPsItemView alloc] initWithFrame:CGRectZero];
    }
    [v fillViewWithObject:item];
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [MapPsItemView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    
    [self restoreSelected:collectionView];
    [view setBackgroundColor:selectedColor];
    self.lastSelectedIndex = index;
    //NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    //UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    //nav1.title = is.productName;
    [self.detailViewController setOrgItem:[self.items objectAtIndex:index]];
    //[self.detailViewController.view drawRect:self.detailViewController.view.frame];
}
*/

- (PsItemView*)createNewItemViewWithIndex:(NSInteger)index
{    NSLog(@"%s", __FUNCTION__);
    
    PsDataItem* item = [self.items objectAtIndex:index];
    
    PsItemView* cell = [[MapPsItemView alloc] initWithFrame:CGRectZero];
    [cell setTag:TAG_PSVIEW_BASE+index];
    [cell fillViewWithObject:item];
    return cell;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [MapPsItemView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)setCollectionViewColum
{
    self.collectionView.numColsPortrait = 3;
    self.collectionView.numColsLandscape = 3;
    
}

- (void)onList:(id)sender
{
    [btnList setSelected:YES];
    [btnMap setSelected:NO];

    [self.collectionView setHidden:NO];
    [self.mapVc.view setHidden:YES];
}
- (void)onMap:(id)sender
{
    [btnList setSelected:NO];
    [btnMap setSelected:YES];
    CGRect rect = self.collectionView.frame;
    rect.origin.x += 20;
    rect.origin.y += 20;
    rect.size.width -= 130;
    rect.size.height -= 40;
    self.mapVc.view.frame = rect;
    [self.collectionView setHidden:YES];
    [self.mapVc.view setHidden:NO];
    [self.mapVc showOrganizations];

}
@end
