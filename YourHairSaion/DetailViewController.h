//
//  DetailViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"
#import "DetailView.h"
#import "PsDetailViewControllerBase.h"

@class ProductViewController;
@class RootViewController;

@interface DetailViewController : PsDetailViewControllerBase<DetailViewDelegate>
@end
