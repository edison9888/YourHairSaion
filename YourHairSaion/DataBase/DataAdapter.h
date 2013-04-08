//
//  DataAdapter.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "LCFileManager.h"
#define FILTER_TYPE_NO 0
#define FILTER_TYPE_PRODUCT_TYPE 1
#define FILTER_TYPE_SHOPPING_CART 2
#define FILTER_TYPE_SEARCH 3

#define STRING_FOR_SHOPPING_CART_FILTER @"__FILTER_SHOPPINGCART"
#define STRING_FOR_SEARCH_FILTER @"__FILTER_SEARCH"

#define PATH_IMG_PATH_IN_DOCUMENTS @"/IMG/Product/"
//define remote file storage path
#define REMOTE_PATH_ROOT @"YourHairSaion"
#define REMOTE_PATH_DB_FILE @"YourHairSaion/DB"
#define REMOTE_PATH_IMG_FILE @"YourHairSaion/IMG/Product"
#define REMOTE_PATH_DB_TEMP_FILENAME @"temp.db"



@class ProductShowingDetail;
@class ProductTypeItem;
@class OrganizationItem;
@class DiscountCardItem;
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
@property (nonatomic, strong) NSMutableArray* productBasesWithSearch;
@property (nonatomic, strong) NSMutableDictionary* productsToBuy;
@property (nonatomic, assign) int filterType;
@property (nonatomic, strong) NSMutableArray* currentFilterLink;
@property (nonatomic, strong) NSArray* discountCards;
@property (nonatomic, strong) NSString* currentSearchKey;
+ (DataAdapter*)shareInstance;
- (BOOL)initData;
- (NSString*) serialNo;


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
- (ProductType*)productTypeById:(NSString*)productTypeId;
- (void)reduceProductToBuy:(NSString*)productId;
- (void)deleteProductToBuy:(NSString *)productId;
- (ProductBase*)productBaseByProduceId:(NSString*)productId;
- (NSUInteger)numInShoppingCart:(NSString*)productId;
- (NSUInteger)totalNumInShoppingCart;
- (CGFloat)totalPriceInShoppingCart;
- (NSString*)currentFilter;
- (NSString*)currentFilterLinkString;
- (void)setSearchKey:(NSString*)searchKey;
- (NSString*)dbFilePath;
- (NSString*)path;
- (NSString*)dbPath;
- (NSString*)imgPath;
- (NSString*)getLocalPath:(NSString*)fileName;
- (void)deletebyProductId:(NSString*)productId;
- (void)deleteProductType:(ProductType*)type;
- (void)deleteByProductTypeId:(NSString*)productTypeId;

- (void)insertProductType:(ProductTypeItem*)dataItem;
- (NSString*)imgFileNameGenerator;
- (void)updateProduct:(ProductShowingDetail*)dataItem;
- (void)updateProductType:(ProductTypeItem*)dataItem;

- (NSString*)createNewProduct;
- (void)resetDatabaseWithFile:(NSString*)filePath;
- (NSString*)defaultProductImg;
- (void)resetUserData;


- (NSString*)createNewOrg;
- (Organization*)orgByOrgId:(NSString*)orgId;
- (void)reloadOrgs;
- (void)deleteOrgByOrgId:(NSString*)orgId;
- (void)updateOrg:(OrganizationItem*)dataItem;

- (NSString*)createNewDiscountCard;
- (DiscountCard*)discountCardByCardId:(NSString*)cardId;
- (void)reloadDiscountCards;
- (void)deleteDiscountCardByCardId:(NSString*)cardId;
- (void)updateDiscountCard:(DiscountCardItem*)dataItem;

- (void)reloadPics;
- (void)reloadPricings;
- (NSArray*)pics;
- (NSArray*)picsInUse;


@end
