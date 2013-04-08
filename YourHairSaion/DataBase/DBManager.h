//
//  DBManager.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-7.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "ProductBase.h"
#import "ProductType.h"
#import "ProductPic.h"
#import "ProductAttr.h"
#import "ProductAmount.h"
#import "ProductPricing.h"
#import "Organization.h"
#import "DiscountCard.h"
#import "SysConf.h"
#import "UpdateHistory.h"

#define LOCAL_DB_FILE_NAME @"YourHairSaion.sqlite"

//for product type
#define PRODUCT_TYPE_ROOT @"root"

//for pic type
#define PRODUCT_PIC_TYPE_DEFAULT ([NSNumber numberWithInt:0])
#define PRODUCT_PIC_TYPE_THUMB ([NSNumber numberWithInt:0])
#define PRODUCT_PIC_TYPE_MIDDLE ([NSNumber numberWithInt:1])
#define PRODUCT_PIC_TYPE_FULL ([NSNumber numberWithInt:2])
#define PRODUCT_PIC_TYPE_HEADER ([NSNumber numberWithInt:3])
#define PRODUCT_PIC_TYPE_LEFT ([NSNumber numberWithInt:4])
#define PRODUCT_PIC_TYPE_RIGHT ([NSNumber numberWithInt:5])
#define PRODUCT_PIC_TYPE_BACK ([NSNumber numberWithInt:6])
#define PRODUCT_PIC_TYPE_NOFACE ([NSNumber numberWithInt:7])


#define PRODUCT_PIC_DEFALUT_FULL @"default_full.JPG"
#define PRODUCT_PIC_DEFALUT_THUMB @"default.JPG"


//for discount type
#define PRODUCT_DISCOUNT_TYPE_PERCENT ([NSNumber numberWithInt:0])
#define PRODUCT_DISCOUNT_TYPE_CUT ([NSNumber numberWithInt:1])

//for org type
#define ORG_TYPE_ROOT_FAXING ([NSNumber numberWithInt:0])
#define ORG_ROOT @"root"

//for discount overlay type
#define DISCOUNT_CARD_NO_OVERLAY ([NSNumber numberWithInt:0])
#define DISCOUNT_CARD_CAN_OVERLAY ([NSNumber numberWithInt:1])

//for product state
#define PRODUCT_STATE_ONSALE ([NSNumber numberWithInt:0])

//for product priority
#define PRODUCT_PRIORITY_NORMAL ([NSNumber numberWithInt:0])

//for product custom flag
#define PRODUCT_CUSTOMIZE_FLAG_OFF ([NSNumber numberWithInt:0])
#define PRODUCT_CUSTOMIZE_FLAG_ON ([NSNumber numberWithInt:1])




@interface DBManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (DBManager*)shareInstance;
- (void)resetDatabaseWithFile:(NSString*)filePath;
- (NSString*) serialNo;
- (NSString*) generateProductId;
- (NSString*) generateProductType;
- (NSString*)insertNewProduct:(NSString *)productName andDetail:(NSString*)productDetail andState:(NSNumber*)productState andType:(NSString*)productType andPricingId:(NSString*)pricingId andPrice:(NSNumber*)productPrice andPriority:(NSNumber*)priority andOrgId:(NSString*)orgId allowCustomize:(NSNumber*)customizeFlag andEffDate:(NSDate*)effDate andExpDate:(NSDate*)expDate;
- (NSArray*) allProduct;

- (void)insertNewProductType:(NSString*)productType andName:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
- (NSString*)insertNewProductType:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
- (ProductPic*)insertNewProductPic:(NSString*)productId andPicType:(NSNumber*)picType andValue:(NSData*)value andLink:(NSString*)link;

- (void)insertNewProductAmount:(NSString*)productId andAmount:(NSNumber*)amount;
- (ProductPricing*)insertNewProductPricing:(NSString*)productId andProductType:(NSString*)productType andDiscountType:(NSNumber*)discountType andDiscountName:(NSString*)discountName andCalcValue:(NSString*)calcValue;
- (NSString*)insertNewOrganization:(NSString*)orgName andOrgType:(NSNumber*)orgType andOrgDetail:(NSString*)orgDetail andParent:(NSString*)parent andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andZip:(NSString*)zip andLatitude:(NSNumber*)latitude andLongitude:(NSNumber*)longitude andPhone:(NSString*)phone andWebsite:(NSString*)webSite andEmail:(NSString*)email andImgLink:(NSString*)imgLink;

- (NSString*)insertNewDiscountCard:(NSString*)name andType:(NSNumber*)type andDetail:(NSString*)detail andOverlay:(NSNumber*)overlay andImgLink:(NSString*)imgLink;
- (void)insertNewConf:(NSString*)key andValue:(NSString*)value;
- (void)updateNewConfForKey:(NSString*)key andValue:(NSString*)value;

- (NSArray*) getAll:(NSString*) entityName;

- (void)deleteRecord:(id)record;
- (void)deleteRecords:(NSArray*)records;

- (void)updateProduct:(NSString*)productID andName:(NSString *)productName andDetail:(NSString *)productDetail andState:(NSNumber *)productState andType:(NSString *)productType andPricingId:(NSString *)pricingId andPrice:(NSNumber *)productPrice andPriority:(NSNumber *)priority andOrgId:(NSString *)orgId allowCustomize:(NSNumber *)customizeFlag andEffDate:(NSDate *)effDate andExpDate:(NSDate *)expDate;

- (ProductPic*)updateProductPic:(NSString*)productId andPicType:(NSNumber*)picType andValue:(NSData*)value andLink:(NSString*)link;
- (void)updateProductType:(NSString*)productType andName:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
- (void)updateOrganization:(NSString*)orgId andName:(NSString *)orgName andOrgType:(NSNumber *)orgType andOrgDetail:(NSString *)orgDetail andParent:(NSString *)parent andStreet:(NSString *)street andCity:(NSString *)city andState:(NSString *)state andZip:(NSString *)zip andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andPhone:(NSString *)phone andWebsite:(NSString *)webSite andEmail:(NSString *)email andImgLink:(NSString *)imgLink;
- (void)updateDiscountCard:(NSString*)cardId andName:(NSString *)name andType:(NSNumber *)type andDetail:(NSString *)detail andOverlay:(NSNumber *)overlay andImgLink:(NSString *)imgLink;
- (ProductPricing*)upateProductPricing:(NSString *)productId andProductType:(NSString *)productType andDiscountType:(NSNumber *)discountType andDiscountName:(NSString *)discountName andCalcValue:(NSString *)calcValue;
- (void)test;

- (NSString*)pathForImageResource:(NSString*)fileName;
- (Organization*)getOrgInDbById:(NSString*)orgId;
- (DiscountCard*)getDiscountCardInDbById:(NSString*)cardId;
- (ProductBase*)getProductInDbById:(NSString *)productId;

- (void)deletePicsById:(NSString*)key;
- (void)deletePricingsById:(NSString*)key;

@end
