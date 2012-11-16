//
//  DetailViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"
#import "MainSplitViewController.h"

@interface DetailViewController : UIViewController
@property (nonatomic, strong) MainSplitViewController* rootViewController;
- (void)fillData:(ProductShowingDetail*)psd;
- (void)addProduct2Buy:(id)sender;
@end
