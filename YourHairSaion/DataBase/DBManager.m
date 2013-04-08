//
//  DBManager.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-7.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DBManager.h"
#import "LCFileManager.h"
#import "ConfAdapter.h"
#define NEW_UUID_KEY    @"uuid_created_by_loman"


static const NSArray* image_resource_paths;
@interface DBManager()
{
    NSString* typeMan1, *typeMan2, *typeMan3, *typeMan4;
    NSString* typeGirl1, *typeGirl2, *typeGirl3, *typeGirl4;
    NSString *typePop1, *typePop2;
    NSString *typeOther1, *typeOther2, *typeOther3;
    NSString* typeGirl, *typeMan, *typeOther, *typePop;
}
- (NSString*)buildProductType;
- (NSString*) generateOrgId;
@end
@implementation DBManager



@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSString*) serialNo
{
    NSString* serialNo = nil;
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyMMddHHmmss"];
    serialNo = [formatter stringFromDate:date];
    return [serialNo stringByAppendingString:[NSString stringWithFormat:@"%d", arc4random()%9999]];
    
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"YourHairSaion" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSError *error = nil;
    
    //NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourHairSaion.sqlite"];
    NSURL *storeURL = [[NSBundle mainBundle] URLForResource:@"YourHairSaion" withExtension:@"sqlite"];
    if (nil == storeURL)
    {
        //exit
    }
    else
    {
        NSString* sourPath = [storeURL path];
        NSString* destPath = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:LOCAL_DB_FILE_NAME] path];
        if (![[LCFileManager shareInstance] moveFile:sourPath toDestPath:destPath overWrite:NO error:&error])
        {
            //do some exit
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourHairSaion.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)resetDatabaseWithFile:(NSString *)filePath
{
    NSError* error = nil;
    if ([[LCFileManager shareInstance]checkSourPath:filePath error:&error])
    {
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[filePath lastPathComponent]];
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    else
    {
        NSLog(@"resetDatabaseWithFile error:%@", error.description);
    }
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


//单例
+(DBManager *)shareInstance {
	static dispatch_once_t pred;
	static DBManager *shared = nil;
	
	dispatch_once(&pred, ^{
		shared = [[DBManager alloc] init];
        image_resource_paths = [NSArray arrayWithObjects:@"", @"hair_pic", @"女士发型/短发", @"女士发型/可爱", @"女士发型/卷发", @"女士发型/直发", @"男士发型/短发", @"男士发型/烫染", @"男士发型/职业", @"男士发型/长发", @"流行发型/男士",@"流行发型/女士", @"护发产品/洗发水", @"护发产品/发蜡", @"护发产品/焗油",nil];
        
	});
	
	return shared;
}

- (NSString*)insertNewProduct:(NSString *)productName andDetail:(NSString *)productDetail andState:(NSNumber *)productState andType:(NSString *)productType andPricingId:(NSString *)pricingId andPrice:(NSNumber *)productPrice andPriority:(NSNumber *)priority andOrgId:(NSString *)orgId allowCustomize:(NSNumber *)customizeFlag andEffDate:(NSDate *)effDate andExpDate:(NSDate *)expDate
{
    NSString* productID = nil;
    if ( nil == productName || nil == productDetail || nil == productType)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        ProductBase *product = [NSEntityDescription insertNewObjectForEntityForName:@"ProductBase" inManagedObjectContext:[self managedObjectContext]];
        if (product)
        {
            product.productId = [self generateProductId];
            NSLog(@"productid = %@", product.productId);
            product.productName = productName;
            product.productDetail = productDetail;
            product.productState = productState;
            product.productType = productType;
            NSLog(@"productType=%@", productType);
            product.priority = priority;
            product.orgId = orgId;
            product.allowCustomizeFlag = customizeFlag;
            product.createTime = [NSDate date];
            product.effDate = effDate;
            product.expDate = expDate;
            product.pricingTypeId = pricingId;
            product.productPrice = productPrice;
            NSError * error = nil;
            if ([[self managedObjectContext] save:&error])
            {
                NSLog(@"insert success!");
                productID = product.productId;
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
        
    }
    
    return productID;
    
}

- (void)updateProduct:(NSString*)productID andName:(NSString *)productName andDetail:(NSString *)productDetail andState:(NSNumber *)productState andType:(NSString *)productType andPricingId:(NSString *)pricingId andPrice:(NSNumber *)productPrice andPriority:(NSNumber *)priority andOrgId:(NSString *)orgId allowCustomize:(NSNumber *)customizeFlag andEffDate:(NSDate *)effDate andExpDate:(NSDate *)expDate
{
    if ( nil == productID || nil == productName || nil == productDetail || nil == productType)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductBase" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@)",productID]];
        ProductBase *productBase = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        //        @property (nonatomic, retain) NSNumber * allowCustomizeFlag;
        //        @property (nonatomic, retain) NSDate * createTime;
        //        @property (nonatomic, retain) NSDate * effDate;
        //        @property (nonatomic, retain) NSDate * expDate;
        //        @property (nonatomic, retain) NSString * orgId;
        //        @property (nonatomic, retain) NSString * pricingTypeId;
        //        @property (nonatomic, retain) NSNumber * priority;
        //        @property (nonatomic, retain) NSString * productDetail;
        //        @property (nonatomic, retain) NSString * productId;
        //        @property (nonatomic, retain) NSString * productName;
        //        @property (nonatomic, retain) NSNumber * productState;
        //        @property (nonatomic, retain) NSString * productType;
        //        @property (nonatomic, retain) NSNumber * productPrice;
        
        if (productBase)
        {
            //[productBase setValue:productID forKey:@"productId"];
            [productBase setValue:productName forKey:@"productName"];
            [productBase setValue:productDetail forKey:@"productDetail"];
            if (nil != productState)
            {
                [productBase setValue:productState forKey:@"productState"];
            }
            
            [productBase setValue:productType forKey:@"productType"];
            [productBase setValue:pricingId forKey:@"pricingTypeId"];
            [productBase setValue:productPrice forKey:@"productPrice"];
            if (nil != priority)
            {
                [productBase setValue:priority forKey:@"priority"];
            }
            [productBase setValue:orgId forKey:@"orgId"];
            if (nil != customizeFlag)
            {
                [productBase setValue:customizeFlag forKey:@"allowCustomizeFlag"];
            }
            if (nil != effDate)
            {
                [productBase setValue:effDate forKey:@"effDate"];
            }
            if (nil != expDate)
            {
                [productBase setValue:expDate forKey:@"expDate"];
            }
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    
}
//查询所有产品
- (NSArray*) allProduct
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProductBase" inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]init];
    [fetchReq setEntity:entity];
    NSError * error = nil;
    NSArray *result = [[self managedObjectContext] executeFetchRequest:fetchReq error:&error];
    if (nil == result || nil != error)
    {
        NSLog(@"fetch request error:%@", error);
    }
    return result;
}

- (NSString*)insertNewProductType:(NSString *)typeName andParent:(NSString *)parent andPricingId:(NSString *)pricingId
{
    NSString* result = nil;
    if (nil == typeName || nil == parent)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        ProductType *type = [NSEntityDescription insertNewObjectForEntityForName:@"ProductType" inManagedObjectContext:self.managedObjectContext];
        if (type)
        {
            type.productType = [self generateProductType];
            type.typeName = typeName;
            type.typeParent = parent;
            type.typePricingId = pricingId;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert type success!");
                result = type.productType;
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    return result;
}

- (void)insertNewConf:(NSString *)key andValue:(NSString *)value
{
    
    if (nil == key || nil == value)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        SysConf *conf = [NSEntityDescription insertNewObjectForEntityForName:@"SysConf" inManagedObjectContext:self.managedObjectContext];
        if (conf)
        {
            conf.key = key;
            conf.value = value;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert conf success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
}

- (void)updateNewConfForKey:(NSString *)key andValue:(NSString *)value
{
    
    if (nil == key || nil == value)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"SysConf" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(key=%@)",key]];
        SysConf *conf = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        
        if (conf)
        {
            conf.key = key;
            conf.value = value;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update conf success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
}

- (void)insertNewProductType:(NSString*)productType andName:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
{
    
    if (nil == productType || nil == typeName || nil == pricingId)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        ProductType *type = [NSEntityDescription insertNewObjectForEntityForName:@"ProductType" inManagedObjectContext:self.managedObjectContext];
        if (type)
        {
            type.productType = productType;
            type.typeName = typeName;
            type.typeParent = parent;
            type.typePricingId = pricingId;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert type success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
}


- (void)updateProductType:(NSString*)productType andName:(NSString*)typeName andParent:(NSString*)parent andPricingId:(NSString*)pricingId;
{
    
    if (nil == productType || nil == typeName || nil == pricingId)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductType" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productType=%@)",productType]];
        ProductType *type = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        
        if (type)
        {
            //type.productType = productType;
            type.typeName = typeName;
            type.typeParent = parent;
            type.typePricingId = pricingId;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update type success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
}

- (ProductPic*)insertNewProductPic:(NSString *)productId andPicType:(NSNumber *)picType andValue:(NSData *)value andLink:(NSString *)link
{
    ProductPic *pic = nil;
    if (nil == productId || nil == picType || nil == link)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        
        pic = [NSEntityDescription insertNewObjectForEntityForName:@"ProductPic" inManagedObjectContext:self.managedObjectContext];
        if (pic)
        {
            pic.productId = productId;
            pic.picType = picType;
            pic.picValue = value;
            pic.picLink = link;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert pic success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    return pic;
}

- (ProductPic*)updateProductPic:(NSString *)productId andPicType:(NSNumber *)picType andValue:(NSData *)value andLink:(NSString *)link
{
    ProductPic *pic = nil;
    if (nil == productId || nil == picType )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductPic" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@) AND (picType=%@)",productId, picType]];
        pic = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        if (pic)
        {
            pic.productId = productId;
            pic.picType = picType;
            pic.picValue = value;
            pic.picLink = link;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update pic success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    return pic;
}

- (void)insertNewProductAmount:(NSString *)productId andAmount:(NSNumber *)amount
{
    if (nil == productId || nil == amount )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        ProductAmount *productAmount = [NSEntityDescription insertNewObjectForEntityForName:@"ProductAmount" inManagedObjectContext:self.managedObjectContext];
        if (productAmount)
        {
            productAmount.productId = productId;
            productAmount.amount = amount;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert amount success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    
}

- (ProductPricing*)insertNewProductPricing:(NSString *)productId andProductType:(NSString *)productType andDiscountType:(NSNumber *)discountType andDiscountName:(NSString *)discountName andCalcValue:(NSString *)calcValue
{
    ProductPricing *pricing = nil;
    if (nil == productId || nil == calcValue )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        pricing = [NSEntityDescription insertNewObjectForEntityForName:@"ProductPricing" inManagedObjectContext:self.managedObjectContext];
        if (pricing)
        {
            pricing.productId = productId;
            pricing.productType = productType == nil ? @"" : productType;
           
            if (nil == discountType)
            {
                pricing.discountType = PRODUCT_DISCOUNT_TYPE_CUT;
            }
            else
            {
                pricing.discountType = discountType;
            }
            pricing.discountName = discountName == nil ? @"" : discountName;
                
            pricing.calcValue = calcValue;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert pricing success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    return pricing;

}

- (ProductPricing*)upateProductPricing:(NSString *)productId andProductType:(NSString *)productType andDiscountType:(NSNumber *)discountType andDiscountName:(NSString *)discountName andCalcValue:(NSString *)calcValue
{
    ProductPricing *pricing = nil;
    if (nil == productId || nil == calcValue )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductPricing" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@)",productId]];
        pricing = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        
        if (pricing)
        {
            pricing.productType = productType == nil ? @"" : productType;
            if (nil == discountType)
            {
                pricing.discountType = PRODUCT_DISCOUNT_TYPE_CUT;
            }
            else
            {
                pricing.discountType = discountType;
            }
            pricing.discountName = discountName == nil ? @"" : discountName;
            pricing.calcValue = calcValue;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update pricing success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    return pricing;
}

- (NSString*)insertNewOrganization:(NSString *)orgName andOrgType:(NSNumber *)orgType andOrgDetail:(NSString *)orgDetail andParent:(NSString *)parent andStreet:(NSString *)street andCity:(NSString *)city andState:(NSString *)state andZip:(NSString *)zip andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andPhone:(NSString *)phone andWebsite:(NSString *)webSite andEmail:(NSString *)email andImgLink:(NSString *)imgLink
{
    NSString* orgId = nil;
    if (nil == orgName || nil == orgType || nil == orgDetail || nil == parent || nil == street || nil == city || nil == state || nil == zip || nil == latitude || nil == longitude || nil == phone )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        
        Organization *org = [NSEntityDescription insertNewObjectForEntityForName:@"Organization" inManagedObjectContext:self.managedObjectContext];
        if (org)
        {
            org.orgId = [self generateOrgId];
            org.orgName = orgName;
            org.orgType = orgType;
            org.orgDetail = orgDetail;
            org.parent = parent;
            org.phone = phone;
            org.email = email;
            org.street = street;
            org.city = city;
            org.state = state;
            org.zip = zip;
            org.latitude = latitude;
            org.longitude = longitude;
            org.website = webSite;
            org.imgLink = imgLink;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert pricing success!");
                orgId = org.orgId;
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    
    return orgId;
}
- (void)updateOrganization:(NSString*)orgId andName:(NSString *)orgName andOrgType:(NSNumber *)orgType andOrgDetail:(NSString *)orgDetail andParent:(NSString *)parent andStreet:(NSString *)street andCity:(NSString *)city andState:(NSString *)state andZip:(NSString *)zip andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andPhone:(NSString *)phone andWebsite:(NSString *)webSite andEmail:(NSString *)email andImgLink:(NSString *)imgLink
{
    if (nil == orgId || nil == orgName || nil == orgType || nil == parent || nil == street || nil == city || nil == state || nil == zip || nil == latitude || nil == longitude || nil == phone )
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Organization" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(orgId=%@)",orgId]];
        Organization *org = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        if (org)
        {
            org.orgName = orgName;
            org.orgType = orgType;
            org.parent = parent;
            org.orgDetail = orgDetail;
            org.phone = phone;
            org.email = email;
            org.street = street;
            org.city = city;
            org.state = state;
            org.zip = zip;
            org.latitude = latitude;
            org.longitude = longitude;
            org.website = webSite;
            org.imgLink = imgLink;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update org success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
}

- (NSString*)insertNewDiscountCard:(NSString *)name andType:(NSNumber *)type andDetail:(NSString *)detail andOverlay:(NSNumber *)overlay andImgLink:(NSString *)imgLink
{
    NSString* cardId = nil;
    if (nil == name || nil == type || nil == detail || nil == imgLink)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        DiscountCard *dc = [NSEntityDescription insertNewObjectForEntityForName:@"DiscountCard" inManagedObjectContext:self.managedObjectContext];
        if (dc)
        {
            dc.cardId = [self generateProductId];
            dc.name = name;
            dc.type = type;
            dc.detail = detail;
            if (nil == overlay)
            {
                dc.overlay = DISCOUNT_CARD_NO_OVERLAY;
                
            }
            else
            {
                dc.overlay = overlay;
            }
            dc.imgLink = imgLink;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"insert discountcard success!");
                cardId =dc.cardId;
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    
    return cardId;
}

- (void)updateDiscountCard:(NSString*)cardId andName:(NSString *)name andType:(NSNumber *)type andDetail:(NSString *)detail andOverlay:(NSNumber *)overlay andImgLink:(NSString *)imgLink
{
    if (nil == cardId || nil == name || nil == type || nil == detail || nil == imgLink)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"DiscountCard" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(cardId=%@)",cardId]];
        DiscountCard *dc = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        
        if (dc)
        {
            dc.name = name;
            dc.type = type;
            dc.detail = detail;
            if (nil == overlay)
            {
                dc.overlay = DISCOUNT_CARD_NO_OVERLAY;

            }
            else
            {
                dc.overlay = overlay;
            }
            dc.imgLink = imgLink;
            NSError * error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"update discountcard success!");
            }
            else
            {
                NSLog(@"error=%@", error.debugDescription);
            }
        }
        else
        {
            NSLog(@"DB error!");
            
        }
    }
    
}
- (ProductBase*)getProductInDbById:(NSString *)productId
{
    ProductBase* product = nil;
    if (nil == productId)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductBase" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@)",productId]];
        product = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
    }
    
    return product;
}
- (DiscountCard*)getDiscountCardInDbById:(NSString *)cardId
{
    DiscountCard* dc = nil;
    if (nil == cardId)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"DiscountCard" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(cardId=%@)",cardId]];
        dc = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
    }
    
    return dc;
}

- (Organization*)getOrgInDbById:(NSString *)orgId
{
    Organization* org = nil;
    if (nil == orgId)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Organization" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(orgId=%@)",orgId]];
        org = [[[self managedObjectContext] executeFetchRequest:request error:&error] lastObject];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
    }
    
    return org;
}

- (NSArray*)getAll:(NSString *)entityName
{
    if (nil == entityName)
    {
        NSLog(@"Parameter error!");
        return nil;
    }
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]init];
    [fetchReq setEntity:entity];
    NSError * error = nil;
    NSArray *result = [[self managedObjectContext] executeFetchRequest:fetchReq error:&error];
    if (nil == result || nil != error)
    {
        NSLog(@"fetch request error:%@", error.debugDescription);
    }
    return result;
    
}

- (void)deleteRecord:(id)record
{
    if (record)
    {
        [[self managedObjectContext] deleteObject:record];
        NSError* error = nil;
        if (![[self managedObjectContext] save:&error])
        {
            NSLog(@"Delete record error:%@", error.debugDescription);
        }
    }
}

- (void)deleteRecords:(NSArray *)records
{
    for (NSManagedObject* object in records)
    {
        [self deleteRecord:object];
    }
}

- (void)deletePicsById:(NSString *)key
{
    if (nil == key)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductPic" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@)",key]];
        NSArray* array = [[self managedObjectContext] executeFetchRequest:request error:&error];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        [self deleteRecords:array];
    }
}

- (void)deletePricingsById:(NSString *)key
{
    if (nil == key)
    {
        NSLog(@"Parameter error!");
    }
    else
    {
        NSError* error = nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ProductPricing" inManagedObjectContext:[self managedObjectContext]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(productId=%@)",key]];
        NSArray* array = [[self managedObjectContext] executeFetchRequest:request error:&error];
        
        if (error)
        {
            NSLog(@"error=%@", error.debugDescription);
        }
        [self deleteRecords:array];
    }
}

- (void) test
{
    DBManager* dm = [DBManager shareInstance];
    [dm insertNewConf:CONF_KEY_SHOW_DISCOUNT_CARD andValue:CONF_VALUE_YES];
    [dm insertNewConf:CONF_KEY_SHOW_SUBBRANCH andValue:CONF_VALUE_YES];
    //ProductBase *product = [[ProductBase alloc] init];
    int vipcardcount = [[[DBManager shareInstance]getAll:@"DiscountCard"]count];
    if (vipcardcount < 7)
    {
        NSString* cardId = [[DBManager shareInstance] insertNewDiscountCard:@"会员卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"就是很普通的会员卡" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard1.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_CUT andDiscountName:@"立减" andCalcValue:[NSString stringWithFormat:@"%d", arc4random()%100+100]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"会员卡蓝卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"比普通的会员卡高一级" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard2.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_CUT andDiscountName:@"立减" andCalcValue:[NSString stringWithFormat:@"%d", arc4random()%100+120]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"贵宾卡" andType:PRODUCT_DISCOUNT_TYPE_PERCENT andDetail:@"很普通的贵宾卡" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard3.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_PERCENT andDiscountName:@"折扣" andCalcValue:[NSString stringWithFormat:@"%d", (arc4random()%8+1)*10]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"贵宾卡蓝卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"比普通的贵宾卡高一级" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard4.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_PERCENT andDiscountName:@"折扣" andCalcValue:[NSString stringWithFormat:@"%d", (arc4random()%7+1)*10]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"贵宾金卡" andType:PRODUCT_DISCOUNT_TYPE_PERCENT andDetail:@"最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡最吊的卡" andOverlay:DISCOUNT_CARD_CAN_OVERLAY andImgLink:@"vipcard5.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_PERCENT andDiscountName:@"折扣" andCalcValue:[NSString stringWithFormat:@"%d", (arc4random()%3+1)*10]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"贵宾卡黑卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"比贵宾卡蓝卡高一级" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard6.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_PERCENT andDiscountName:@"折扣" andCalcValue:[NSString stringWithFormat:@"%d", (arc4random()%6+1)*10]];
        
        cardId = [[DBManager shareInstance] insertNewDiscountCard:@"会员卡黑卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"比普通会员卡蓝卡高一级" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard7.png"];
        [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_CUT andDiscountName:@"立减" andCalcValue:[NSString stringWithFormat:@"%d", arc4random()%100+140]];
        
    }
    int typecount = [[[DBManager shareInstance]getAll:@"ProductType"] count];
    
    
    if (typecount < 17)
    {
        typeGirl = [[DBManager shareInstance] insertNewProductType:@"女士发型" andParent:PRODUCT_TYPE_ROOT andPricingId:@"1211081018589888"];
        typeMan = [[DBManager shareInstance] insertNewProductType:@"男士发型" andParent:PRODUCT_TYPE_ROOT andPricingId:@"1211081018589888"];
        typePop = [[DBManager shareInstance] insertNewProductType:@"流行发型" andParent:PRODUCT_TYPE_ROOT andPricingId:@"1211081018589888"];
        typeOther = [[DBManager shareInstance] insertNewProductType:@"护发产品" andParent:PRODUCT_TYPE_ROOT andPricingId:@"1211081018589888"];
        typeMan1 = [[DBManager shareInstance] insertNewProductType:@"烫染" andParent:typeMan andPricingId:@"1211081018589888"];
        typeMan2 = [[DBManager shareInstance] insertNewProductType:@"职业" andParent:typeMan andPricingId:@"1211081018589888"];
        typeMan3 = [[DBManager shareInstance] insertNewProductType:@"短发" andParent:typeMan andPricingId:@"1211081018589888"];
        typeMan4 = [[DBManager shareInstance] insertNewProductType:@"长发" andParent:typeMan andPricingId:@"1211081018589888"];
        typeGirl1 = [[DBManager shareInstance] insertNewProductType:@"卷发" andParent:typeGirl andPricingId:@"1211081018589888"];
        typeGirl2 = [[DBManager shareInstance] insertNewProductType:@"可爱" andParent:typeGirl andPricingId:@"1211081018589888"];
        typeGirl3 = [[DBManager shareInstance] insertNewProductType:@"直发" andParent:typeGirl andPricingId:@"1211081018589888"];
        typeGirl4 = [[DBManager shareInstance] insertNewProductType:@"短发" andParent:typeGirl andPricingId:@"1211081018589888"];
        typePop1 = [[DBManager shareInstance] insertNewProductType:@"女士" andParent:typePop andPricingId:@"1211081018589888"];
        typePop2 = [[DBManager shareInstance] insertNewProductType:@"男士" andParent:typePop andPricingId:@"1211081018589888"];
        typeOther1 = [[DBManager shareInstance] insertNewProductType:@"发蜡" andParent:typeOther andPricingId:@"1211081018589888"];
        typeOther2 = [[DBManager shareInstance] insertNewProductType:@"洗发水" andParent:typeOther andPricingId:@"1211081018589888"];
        typeOther3 = [[DBManager shareInstance] insertNewProductType:@"焗油" andParent:typeOther andPricingId:@"1211081018589888"];
    }
    
    NSMutableArray* orgIds = [[NSMutableArray alloc]initWithCapacity:4];
    int orgcount = [[[DBManager shareInstance]getAll:@"Organization"] count];
    if (orgcount < 4)
    {
        NSString* parentId = [[DBManager shareInstance] insertNewOrganization:@"八佰伴(广州总店)" andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:@"我觉得八佰伴系做得ok嘅， 理由就系发型师剪发都比较细心啦 剪过最长时间差不多2个小时（+洗头时间） 效果出来系几满意的。 服务的话都几好。。 不过都系通病啦， 依家剪发发廊都升价啦， 之前剪过都系38 依家去到45 不过整体觉得可以， 环境都几好， 值得一试" andParent:ORG_ROOT andStreet:@"天河路586号总统酒店2楼" andCity:@"广州" andState:@"中国" andZip:@"526000" andLatitude:[NSNumber numberWithDouble:23.13958] andLongitude:[NSNumber numberWithDouble:113.344892] andPhone:@"38803071" andWebsite:@"www.babaiban.com" andEmail:nil andImgLink:@"babaibang0.jpeg"];
        [orgIds addObject:parentId];
        NSString* orgId = [[DBManager shareInstance] insertNewOrganization:@"八佰伴(农林店)" andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:@"服务态度不错，最喜欢的是发型师不会一个劲推销产品。 出示广发卡可以打九折。 晚上八点多去，人不多，速度很快，不到一个小时全部完成。" andParent:parentId andStreet:@"农林下路58号" andCity:@"广州" andState:@"中国" andZip:@"526000" andLatitude:[NSNumber numberWithDouble:23.1361] andLongitude:[NSNumber numberWithDouble:113.304507] andPhone:@"87600161" andWebsite:@"www.babaiban.com" andEmail:nil andImgLink:@"babaibang1.jpeg"];
        [orgIds addObject:orgId];
        orgId = [[DBManager shareInstance] insertNewOrganization:@"八佰伴(广东外经贸大厦店)" andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:@"看见点评上有他们家的“烫或染可赠送198元歌薇蚕丝蛋白水分护理”的优惠， 在门口看到他们店门面后， 心大心细甘不知道去染发还是不去好！ 谁知道一进去，报了自己的姓和约定时间后， 马上听见店员说：因为这是点评的优惠148RMB染发套餐， 而你的是长发，不在这个套餐的使用范围内， 如果你选择用染发相同的牌子，费用大概是3-400元， （嘲笑的说着）如果你一定要使用这优惠-148RMB染发套餐，只能染半头！！！ 气得我。。。马上离开， 这个店已拨入到我个人的商户黑名单里，永不再使用此家！！ 点解这个优惠里没有写明只限短发呢？ 点解预约时，没有对客户讲明呢？ 点解客户到门口后，又带有嘲笑的说，只有店里才有这些优惠的详细说明呢？ " andParent:parentId andStreet:@"天河路351号广东外经贸大厦1楼" andCity:@"广州" andState:@"中国" andZip:@"526000" andLatitude:[NSNumber numberWithDouble:23.139364] andLongitude:[NSNumber numberWithDouble:113.335679] andPhone:@"87593194" andWebsite:@"www.babaiban.com" andEmail:nil andImgLink:@"babaibang2.jpeg"];
        [orgIds addObject:orgId];
        orgId = [[DBManager shareInstance] insertNewOrganization:@"八佰伴(天河北店)" andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:@"靠近东站的位置，和朋友一起去的。服务很好。技师水平更是好。还没有等我说要剪什么样的。他就可以根据他的判断说出来。剪出来也非常满意的" andParent:parentId andStreet:@"天河北路381号" andCity:@"广州" andState:@"中国" andZip:@"526000" andLatitude:[NSNumber numberWithDouble:23.147451] andLongitude:[NSNumber numberWithDouble:113.336134] andPhone:@"38803071" andWebsite:@"www.babaiban.com" andEmail:nil andImgLink:@"babaibang3.jpeg"];
        [orgIds addObject:orgId];
    }
    
    int count = [[[DBManager shareInstance]getAll:@"ProductBase"] count];
    if (count < 122)
    {
        //产生随机数列
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1000];
        for (int i = 0; i < 1000; i ++)
        {
            [tempArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        int i;
        int count = 1000;
        for (i = 0; i < count; i ++) {
            int index = arc4random() % (count - i);
            [resultArray addObject:[tempArray objectAtIndex:index]];
            [tempArray removeObjectAtIndex:index];
        }
        
        NSLog(@"resultArray is %@",resultArray);
        
        
        for (int t = 1; t < 1000 ; t ++)
        {
            NSString* randomNum = [resultArray objectAtIndex:t];
            int i = [randomNum intValue];
            NSString* productID = nil;
            
            //检查图片名
            NSString* picLink = [dm getImgFileNameWithIndex:i andType:PRODUCT_PIC_TYPE_THUMB];
            if (nil == picLink)
            {
                continue;
            }
            NSString* picFullLink = [dm getImgFileNameWithIndex:i andType:PRODUCT_PIC_TYPE_FULL];
            NSString* picLeft = [dm getImgFileNameWithIndex:i andType:PRODUCT_PIC_TYPE_LEFT];
            NSString* picBack = [dm getImgFileNameWithIndex:i andType:PRODUCT_PIC_TYPE_BACK];
            NSString* picNoface = [dm getImgFileNameWithIndex:i andType:PRODUCT_PIC_TYPE_NOFACE];
            
            
            NSString* productName = [@"演示产品" stringByAppendingFormat:@"%d", arc4random()%999];
            NSString* productdDetail = @"演示产品，暂未提供说明，以下价格均为虚拟价格，具体可通过管理端统一修正。";
            NSString* productType = [self generateProductTypeForIndex:i];
            productID = [self insertNewProduct:productName andDetail:productdDetail andState:[NSNumber numberWithInt:0] andType:productType andPricingId:@"1211081018589888" andPrice:[NSNumber numberWithInt:arc4random()%10000] andPriority:[NSNumber numberWithInt:0] andOrgId:[orgIds objectAtIndex:arc4random()%4] allowCustomize:[NSNumber numberWithInt:0] andEffDate:[NSDate date] andExpDate:[NSDate date]];
            
            [[DBManager shareInstance] insertNewProductPic:productID andPicType:PRODUCT_PIC_TYPE_THUMB andValue:nil andLink:picLink];

            if (picFullLink != nil)
            {
                [[DBManager shareInstance] insertNewProductPic:productID andPicType:PRODUCT_PIC_TYPE_FULL andValue:nil andLink:picFullLink];
            }
            if (picLeft != nil)
            {
                [[DBManager shareInstance] insertNewProductPic:productID andPicType:PRODUCT_PIC_TYPE_LEFT andValue:nil andLink:picLeft];
            }
            
            if (picBack != nil)
            {
                [[DBManager shareInstance] insertNewProductPic:productID andPicType:PRODUCT_PIC_TYPE_BACK andValue:nil andLink:picBack];
            }
            
            if (picNoface != nil)
            {
                [[DBManager shareInstance] insertNewProductPic:productID andPicType:PRODUCT_PIC_TYPE_NOFACE andValue:nil andLink:picNoface];
            }
            
            [[DBManager shareInstance] insertNewProductAmount:productID andAmount:[NSNumber numberWithInt:arc4random()%100]];
            if (i%2 == 0)
            {
                [[DBManager shareInstance] insertNewProductPricing:productID andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_PERCENT andDiscountName:@"折扣" andCalcValue:[NSString stringWithFormat:@"%d", (arc4random()%8+1)*10]];
            }
            else
            {
                [[DBManager shareInstance] insertNewProductPricing:productID andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_CUT andDiscountName:@"立减" andCalcValue:[NSString stringWithFormat:@"%d", arc4random()%100+100]];
            }
            
            
        }
    }
    
    /*
     NSArray* allProduct = [[DBManager shareInstance] getAll:@"ProductBase"];
     if ( [allProduct count] > 0)
     {
     for (ProductBase* product in allProduct)
     {
     [product show];
     }
     }
     
     NSArray* allProductType = [[DBManager shareInstance] getAll:@"ProductType"];
     if ( [allProductType count] > 0)
     {
     for (ProductType* type in allProductType)
     {
     [type show];
     }
     }
     NSArray* allProductPic = [[DBManager shareInstance] getAll:@"ProductPic"];
     if ( [allProductPic count] > 0)
     {
     for (ProductPic* pic in allProductPic)
     {
     [pic show];
     }
     }
     
     NSArray* allProductAmount = [[DBManager shareInstance] getAll:@"ProductAmount"];
     if ( [allProductAmount count] > 0)
     {
     for (ProductAmount* amount in allProductAmount)
     {
     [amount show];
     }
     }
     
     NSArray* allProductPricing = [[DBManager shareInstance] getAll:@"ProductPricing"];
     if ( [allProductPricing count] > 0)
     {
     for (ProductPricing* pricing in allProductPricing)
     {
     [pricing show];
     }
     }
     
     ProductBase* productTmp = [allProduct objectAtIndex:0];
     NSArray* tmp = [productTmp.productType componentsSeparatedByString:@"," ];
     
     for (NSString* typeId in tmp)
     {
     for (ProductType * typeTmp in allProductType)
     {
     if ( [typeId isEqualToString:typeTmp.productType])
     {
     if (nil == productTmp.productTypes)
     {
     productTmp.productTypes = [[NSMutableArray alloc] init];
     }
     [productTmp.productTypes addObject:typeTmp];
     }
     }
     }
     NSLog(@"--------%d", [productTmp.productTypes count]);
     
     for (ProductType* type in productTmp.productTypes)
     {
     [type show];
     }
     
     */
    
}

- (NSString*)getImgFileNameWithIndex:(NSInteger)index andType:(NSNumber*)type
{
    LCFileManager* fm = [LCFileManager shareInstance];
    NSString* picLink;
    
    if ([type isEqualToNumber:PRODUCT_PIC_TYPE_DEFAULT] || [type isEqualToNumber:PRODUCT_PIC_TYPE_THUMB])
    {
        picLink = [NSString stringWithFormat:@"%d", index];
        
    }
    else if ([type isEqualToNumber:PRODUCT_PIC_TYPE_LEFT])
    {
        picLink = [NSString stringWithFormat:@"%d_left", index];
    }
    else if ([type isEqualToNumber:PRODUCT_PIC_TYPE_RIGHT])
    {
        picLink = [NSString stringWithFormat:@"%d_right", index];
    }
    else if ([type isEqualToNumber:PRODUCT_PIC_TYPE_BACK])
    {
        picLink = [NSString stringWithFormat:@"%d_back", index];
    }
    else if ([type isEqualToNumber:PRODUCT_PIC_TYPE_FULL])
    {
        picLink = [NSString stringWithFormat:@"%d_full", index];
    }
    else if ([type isEqualToNumber:PRODUCT_PIC_TYPE_NOFACE])
    {
        picLink = [NSString stringWithFormat:@"%d_noface", index];
    }
    
    NSString* fileName = [picLink stringByAppendingString:@".jpg"];
    NSString* path = [[self pathForResource:fileName]lastObject];
    if (path == nil || ![fm checkSourPath:path error:nil] )
    {
        fileName = [picLink stringByAppendingString:@".png"];
        path = [[self pathForResource:fileName]lastObject];
        if (path == nil || ![fm checkSourPath:path error:nil] )
        {
            return nil;
        }
    }
    return fileName;
}

- (NSArray*)pathForResource:(NSString*)fileName
{

    NSString *path = nil;
    NSMutableArray* paths = [NSMutableArray array];
    for (NSString* dir in image_resource_paths)
    {
        path = [[NSBundle mainBundle]pathForResource:fileName ofType:nil inDirectory:dir];
        if (path != nil)
        {
            [paths addObject:path];
        }
    }
    
    return paths;
    
}

- (NSString*)pathForImageResource:(NSString*)fileName
{

    NSString *path = nil;
    for (NSString* dir in image_resource_paths)
    {
        path = [[NSBundle mainBundle]pathForResource:fileName ofType:nil inDirectory:dir];
        if (path != nil)
        {
            break;
        }
    }
    
    return path;
}

- (NSString*) generateProductId
{
    NSUserDefaults *handler = [NSUserDefaults standardUserDefaults];
    NSString* identify = [NSString stringWithFormat:@"%@", [handler objectForKey:NEW_UUID_KEY]];
    
    
    if (nil == identify || 46 > [identify length])
    {
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        
        identify = [NSString stringWithFormat:@"%@", uuidStr];
        
        CFRelease(uuidStr);
        CFRelease(uuid);
        
        
        [handler setObject:identify forKey:NEW_UUID_KEY];
        [handler synchronize];
    }
    
    return [identify stringByAppendingString:[self serialNo] ];
}

- (NSString*) generateProductType
{
    return [self serialNo];//[formater numberFromString:typeStr];
}

- (NSString*) generateProductTypeForIndex:(NSInteger)index
{
    NSString* picName = [self getImgFileNameWithIndex:index andType:PRODUCT_PIC_TYPE_THUMB];
    NSArray* arrayGirl = [self pathForResource:picName];
    NSString* productType = @"";
    for (NSString* path in arrayGirl)
    {
        if ([[path lastPathComponent] isEqualToString:[self getImgFileNameWithIndex:index andType:PRODUCT_PIC_TYPE_THUMB]])
        {
            if ([path rangeOfString:@"女士发型"].location != NSNotFound)
            {
                productType = [productType stringByAppendingFormat:@",%@",typeGirl];
                if ([path rangeOfString:@"卷发"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeGirl1];
                }
                else if ([path rangeOfString:@"可爱"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeGirl2];
                }
                else if ([path rangeOfString:@"直发"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeGirl3];
                    
                }
                else if ([path rangeOfString:@"短发"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeGirl4];
                }
            }
            else if ([path rangeOfString:@"男士发型"].location != NSNotFound)
            {
                productType = [productType stringByAppendingFormat:@",%@",typeMan];
                if ([path rangeOfString:@"烫染"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeMan1];
                    
                }
                else if ([path rangeOfString:@"职业"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeMan2];
                    
                }
                else if ([path rangeOfString:@"短发"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeMan3];
                    
                }
                else if ([path rangeOfString:@"长发"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeMan4];
                    
                }
            }
            else if ([path rangeOfString:@"流行发型"].location != NSNotFound)
            {
                productType = [productType stringByAppendingFormat:@",%@",typePop];
                if ([path rangeOfString:@"男士"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typePop1];
                    
                }
                else if ([path rangeOfString:@"女士"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typePop2];
                    
                }
            }
            
            else if ([path rangeOfString:@"护发产品"].location != NSNotFound)
            {
                productType = [productType stringByAppendingFormat:@",%@",typeOther];
                if ([path rangeOfString:@"焗油"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeOther1];
                }
                else if ([path rangeOfString:@"洗发水"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeOther2];
                    
                }
                else if ([path rangeOfString:@"发蜡"].location != NSNotFound)
                {
                    productType = [productType stringByAppendingFormat:@",%@",typeOther3];
                    
                }
            }
        }
    }
    return productType;
}



- (NSString*)buildProductType
{
    NSArray* productTypes = [[DBManager shareInstance]getAll:@"ProductType"];
    NSString* productType = @"";
    int total = productTypes.count;
    int typeCount = arc4random()%total+1;
    NSLog(@"TypeCount=%d", typeCount);
    for (int i = 0; i < typeCount; i++)
    {
        int index = arc4random()%total;
        productType = [productType stringByAppendingFormat:@"%@,",((ProductType*)productTypes[index]).productType];
    }
    NSLog(@"Type = %@", productType);
    return productType;
}

- (NSString*) generateOrgId
{
    return [NSString stringWithFormat:@"ORG_%@", [self serialNo]];
}
@end

