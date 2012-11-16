//
//  ShoppingCartViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"
#import "MainSplitViewController.h"

@interface ShoppingCartViewController : UIViewController<PSCollectionViewDelegate, PSCollectionViewDataSource>
@property (nonatomic, strong)MainSplitViewController* rootview;
- (void)refresh;

@end
