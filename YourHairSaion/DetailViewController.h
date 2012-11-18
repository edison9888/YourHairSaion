//
//  DetailViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"
@class ProductViewController;
@class RootViewController;

@interface DetailViewController : UIViewController
@property (nonatomic, strong) RootViewController* rootViewController;
@property (nonatomic, strong) ProductViewController* productViewController;
- (void)fillData:(ProductShowingDetail*)psd;
- (void)addProduct2Buy:(id)sender;
@property (strong, nonatomic) id dataObject;

- (NSUInteger)indexInPage;
@end
