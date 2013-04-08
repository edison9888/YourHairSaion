//
//  DiscountPsViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DiscountPsViewController.h"
#import "DiscountCardItemView.h"

@interface DiscountPsViewController ()

@end

@implementation DiscountPsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)setCollectionViewColum
{
    self.collectionView.numColsPortrait = 3;
    self.collectionView.numColsLandscape = 3;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    for (int i = self.fromIndex; i <= self.toIndex; i++)
    {
        DiscountCardItem* item = [[DiscountCardItem alloc]initWithObject:dataAdapter.discountCards[i]];
        [self.items addObject:item];
    }
    [self dataSourceDidLoad];
    
    
}


- (PsItemView*)createNewItemViewWithIndex:(NSInteger)index
{    NSLog(@"%s", __FUNCTION__);
    
    PsDataItem* item = [self.items objectAtIndex:index];
    
    PsItemView* cell = [[DiscountCardItemView alloc] initWithFrame:CGRectZero];
    [cell setTag:TAG_PSVIEW_BASE+index];
    [cell fillViewWithObject:item];
    return cell;
}


- (CGFloat)heightForViewAtIndex:(NSInteger)index
{
    return [DiscountCardItemView heightForViewWithObject:self.items[index] inColumnWidth:self.collectionView.colWidth];
}


@end
