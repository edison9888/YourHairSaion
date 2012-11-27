//
//  DataAdapter.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#define FILTER_TYPE_NO 0
#define FILTER_TYPE_PRODUCT_TYPE 1
#define FILTER_TYPE_SHOPPING_CART 2

#define STRING_FOR_SHOPPING_CART_FILTER @"SHOPPINGCART"

@interface DataAdapter : NSObject
@property (nonatomic, strong)NSArray* productBases;
@property  (nonatomic, strong)NSArray* productTypes;
@property (nonatomic, strong) NSArray* productPics;
@property (nonatomic, strong) NSArray* productAttrs;
@property (nonatomic, strong) NSArray* organizations;
@property (nonatomic, strong) NSArray* productAmounts;
@property (nonatomic, strong) NSArray* productPricings;
@property (nonatomic, strong) NSArray* productBasesWithFilter;
@property (nonatomic, strong) NSArray* productBasesInShoppingCart;
@property (nonatomic, strong) NSMutableDictionary* productsToBuy;
@property (nonatomic, assign) int filterType;
@property (nonatomic, strong) NSMutableArray* currentFilterLink;
@property (nonatomic, strong) NSArray* discountCards;
+ (DataAdapter*)shareInstance;
- (BOOL)loadData;

- (BOOL)mergeData;
- (int)count;
- (NSString*)captionAtIndex:(NSInteger)index;
- (NSString*)detailAtIndex:(NSInteger)index;
- (NSString*)ImageLinkAtIndex:(NSInteger)index andType:(NSNumber*)type;
- (NSNumber*)priceAtIndex:(NSInteger)index;
- (NSNumber*)amountAtIndex:(NSInteger)index;
- (NSArray*)productFilterByType:(NSString*)type;
- (void)setFilter:(ProductType*)productType;
- (ProductBase*)objectAtIndex:(NSInteger)index;
- (NSArray*)pricingsAtIndex:(NSInteger)index;
- (void)addProductToBuy:(NSString*)productId;
- (NSString*)ProductIdAtIndex:(NSInteger)index;
- (BOOL)productIsInShoppingCart:(NSString*)productId;
- (void)setFilterByTypeId:(NSString*)productTypeId;
- (NSArray*)productTypeForParent:(NSString*)productTypeId;
- (void)reduceProductToBuy:(NSString*)productId;
- (ProductBase*)productBaseByProduceId:(NSString*)productId;
- (NSUInteger)numInShoppingCart:(NSString*)productId;
- (NSString*)currentFilter;

@end
