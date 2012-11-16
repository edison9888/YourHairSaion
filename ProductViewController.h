//
//  PSViewController.h
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSCollectionView.h"
#import "MainSplitViewController.h"

@interface ProductViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource>
@property (nonatomic, strong)MainSplitViewController* rootview;

@end
