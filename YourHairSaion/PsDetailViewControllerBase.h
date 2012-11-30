//
//  PsDetailViewControllerBase.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-30.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PsDataItem.h"
#import "PsViewController.h"

@interface PsDetailViewControllerBase : UIViewController
@property (nonatomic, retain) PsDataItem *item;
@property (nonatomic, strong) PsViewController* psViewController;

- (NSUInteger)indexInPage;
@end
