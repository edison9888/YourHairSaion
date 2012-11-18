//
//  PSViewController.h
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "PSCollectionView.h"
#import "DetailViewController.h"
@class RootViewController;
@interface ProductViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource>
@property (nonatomic, strong)RootViewController* rootViewController;

@property (nonatomic, strong) DetailViewController* detailViewController;

- (id)initProductViewControllerFromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(DetailViewController*)detailViewController;

- (NSUInteger)indexInPage;
@end
