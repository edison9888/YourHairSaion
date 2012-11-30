//
//  PSViewController.h
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "DetailViewController.h"
#import "PsViewController.h"
#import "PSBroView.h"
@protocol ProductBuyingDelegate;
@interface ProductViewController : PsViewController<ProductBuyingDelegate>

@end
