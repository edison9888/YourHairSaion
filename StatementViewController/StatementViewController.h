//
//  StatementViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-28.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductViewController;

@interface StatementViewController : UITableViewController

- (void)setProductViewController:(ProductViewController*)productViewController andIndex:(NSInteger)index;
@end
