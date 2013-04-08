//
//  ShoppingCartPsViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-9.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ShoppingCartPsViewController.h"
#import "ShoppingCartItemView.h"

@interface ShoppingCartPsViewController ()

@end

@implementation ShoppingCartPsViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBuy:(PSCollectionViewCell *)cell
{    NSLog(@"%s", __FUNCTION__);
    
    return YES;
}


- (PsItemView*)createNewItemViewWithIndex:(NSInteger)index
{
    NSLog(@"%s", __FUNCTION__);
    
    ProductShowingDetail* item = [self.items objectAtIndex:index];
    ShoppingCartItemView* cell = [[ShoppingCartItemView alloc] initWithFrame:CGRectZero];
    cell.productBuyingDelegate = self;
    [cell setTag:TAG_PSVIEW_BASE+index ];
    [cell fillViewWithObject:item];
    return cell;
}

@end
