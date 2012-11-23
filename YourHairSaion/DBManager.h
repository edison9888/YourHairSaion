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


//for product type
#define PRODUCT_TYPE_ROOT @"root"

//for pic type
#define PRODUCT_PIC_TYPE_THUMB ([NSNumber numberWithInt:0])
#define PRODUCT_PIC_TYPE_MIDDLE ([NSNumber numberWithInt:1])
#define PRODUCT_PIC_TYPE_FULL ([NSNumber numberWithInt:2])
#define PRODUCT_PIC_TYPE_HEADER ([NSNumber numberWithInt:3])
//for discount type
#define PRODUCT_DISCOUNT_TYPE_PERCENT ([NSNumber numberWithInt:0])
#define PRODUCT_DISCOUNT_TYPE_CUT ([NSNumber numberWithInt:1])

//for org type
#define ORG_TYPE_ROOT_FAXING ([NSNumber numberWithInt:0])
#define ORG_ROOT @"root"


@interface DBManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (DBManager*)shareInstance;
- (NSString*) serialNo;
- (NSString*) generateProductId;
- (NSString*) generateProductType;
- (NSString*)insertNewProduct:(NSString *)productName andDetail:(NSString*)productDetail andState:(NSNumber*)productState andType:(NSString*)productType andPricingId:(NSString*)pricingId andPrice:(NSNumber*)productPrice andPriority:(NSNumber*)priority andOrgId:(NSString*)orgId allowCustomize:(NSNumber*)customizeFlag andEffDate:(NSDate*)effDate andExpDate:(NSDate*)expDate;
- (NSArray*) allProduct;

- (void)insertNewProductType:(NSString*)productType andName:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
- (NSString*)insertNewProductType:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
- (void)insertNewProductPic:(NSString*)productId andPicType:(NSNumber*)picType andValue:(NSData*)value andLink:(NSString*)link;

- (void)insertNewProductAmount:(NSString*)productId andAmount:(NSNumber*)amount;
- (void)insertNewProductPricing:(NSString*)productId andProductType:(NSString*)productType andDiscountType:(NSNumber*)discountType andDiscountName:(NSString*)discountName andCalcValue:(NSString*)calcValue;
- (NSString*)insertNewOrganization:(NSString*)orgName andOrgType:(NSNumber*)orgType andOrgDetail:(NSString*)orgDetail andParent:(NSString*)parent andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andZip:(NSString*)zip andLatitude:(NSNumber*)latitude andLongitude:(NSNumber*)longitude andPhone:(NSString*)phone andWebsite:(NSString*)webSite andEmail:(NSString*)email andImgLink:(NSString*)imgLink;

- (NSArray*) getAll:(NSString*) entityName;

+ (void)test;
@end
