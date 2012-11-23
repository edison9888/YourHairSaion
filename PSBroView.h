//
//  PSBroView.h
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSCollectionViewCell.h"
@protocol ProductBuyingDelegate <NSObject>

@required
- (BOOL)canBuy:(PSCollectionViewCell *)cell;
- (void)prepareToBuy:(PSCollectionViewCell *)cell;
- (void)productAdd:(PSCollectionViewCell *)cell;
- (void)productReduct:(PSCollectionViewCell *)cell;
- (void)finishToBuy:(PSCollectionViewCell *)cell;
@end

@interface PSBroView : PSCollectionViewCell
@property (nonatomic, strong) id<ProductBuyingDelegate> productBuyingDelegate;

- (void)prepareToBuy;
- (void)finishToBuy;
@end

