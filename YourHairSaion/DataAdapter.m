//
//  DataAdapter.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DataAdapter.h"

@interface DataAdapter()
- (void)setCurrentFilter:(ProductType*)type;
- (NSArray*)productsInType:(NSArray*)products filterByType:(ProductType*)type;
@end
@implementation DataAdapter
@synthesize productPricings;
@synthesize productAttrs;
@synthesize productAmounts;
@synthesize productBases;
@synthesize productPics;
@synthesize productTypes;
@synthesize organizations;
@synthesize productBasesWithFilter;
@synthesize filterFlag;
@synthesize productsToBuy;

+ (DataAdapter*)shareInstance;
{
    static dispatch_once_t pred;
    static DataAdapter *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DataAdapter alloc] init];
        
    });
    
    return shared;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if ([self loadData])
        {
            productsToBuy = [[NSMutableDictionary alloc]init];
            self.currentFilterLink = [[NSMutableArray alloc]init];
            return self;
        }
        
    }
    return nil;
}

- (BOOL)loadData
{
    self.filterFlag = NO;
    DBManager* dbManager = [DBManager shareInstance];
    self.productBases = [dbManager getAll:@"ProductBase"];
    if (nil == self.productBases || [self.productBases count] <= 0)
    {
        NSLog(@"load productBase error!");
        return NO;
    }
    
    self.productTypes = [dbManager getAll:@"ProductType"];
    if (nil == self.productTypes || [self.productTypes count] <= 0)
    {
        NSLog(@"load productType error!");
        return NO;
    }
    
    self.productPricings = [dbManager getAll:@"ProductPricing"];
    if (nil == self.productPricings || [self.productPricings count] <= 0)
    {
        NSLog(@"load productPricing error!");
        return NO;
    }
    
    self.productPics = [dbManager getAll:@"ProductPic"];
    if (nil == self.productPics || [self.productPics count] <= 0)
    {
        NSLog(@"load productPic error!");
        return NO;
    }
    
    self.productAmounts = [dbManager getAll:@"ProductAmount"];
    if (nil == self.productAmounts || [self.productAmounts count] <= 0)
    {
        NSLog(@"load productAmount error!");
        return NO;
    }
    
    self.productAttrs = [dbManager getAll:@"ProductAttr"];
    
    self.organizations = [dbManager getAll:@"Organization"];
    
    return [self mergeData];
}

- (BOOL)mergeData
{
    for (ProductBase* productBase in self.productBases)
    {
        [productBase initExt];
        NSArray* tmpProductTypes = [productBase.productType componentsSeparatedByString:@"," ];
        for (NSString* typeId in tmpProductTypes)
        {
            for (ProductType* productType in self.productTypes)
            {
                if ( [typeId isEqualToString:productType.productType] )
                {
                    [productBase.productTypes addObject:productType];
                    break;
                    
                }
            }
        }
        
        for (ProductPricing* productPricing in self.productPricings)
        {
            if ([productPricing.productId isEqualToString:productBase.productId])
            {
                [productBase.productPricings addObject:productPricing];
            }
        }
        
        for (ProductPic* productPic in self.productPics)
        {
            if ([productPic.productId isEqualToString:productBase.productId])
            {
                [productBase.productPics addObject:productPic];
            }
        }
        
        for (ProductAttr* productAttr in self.productAttrs)
        {
            if ([productAttr.productId isEqualToString:productBase.productId])
            {
                [productBase.productAttrs addObject:productAttr];
            }
        }

        for (ProductAmount* productAmount in self.productAmounts)
        {
            if ([productAmount.productId isEqualToString:productBase.productId])
            {
                productBase.productAmount = productAmount;
                break;
            }
            
        }

    for (Organization* org in self.organizations)
        {
    if ([org.orgId isEqualToString:productBase.orgId])
    {
        productBase.org = org;
        break;
    }
    
}
    }
    return YES;
}

- (int)count
{
    if (self.filterFlag)
    {
        return [self.productBasesWithFilter count];
    }
    return [self.productBases count];
}

- (NSString*)captionAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productName;

    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productName;
}

- (NSString*)detailAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productDetail;
    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productDetail;
}

- (NSString*)ImageLinkAtIndex:(NSInteger)index andType:(NSNumber *)type
{
    ProductBase* productBase = nil;
    if (self.filterFlag)
    {
        productBase = [self.productBasesWithFilter objectAtIndex:index];
        
    }
    else
    {
        productBase = [self.productBases objectAtIndex:index];
    }
    for (ProductPic* pic in productBase.productPics)
    {
        if ([pic.picType isEqualToNumber:type])
        {
            return pic.picLink;
        }
    }
    return nil;
}

- (NSNumber*)priceAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productPrice;
    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productPrice;
}

- (NSNumber*)amountAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productAmount.amount;
    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productAmount.amount;

}

- (NSString*)ProductIdAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productId;
    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productId;
    
}

- (NSArray*)productFilterByType:(NSString *)type
{
    self.filterFlag = YES;
    NSMutableArray* result = [[NSMutableArray alloc]init];
    for (ProductBase* product in self.productBases)
    {
        for (ProductType* productType in product.productTypes)
        {
            if ([type isEqualToString:productType.productType])
            {
                [result addObject:product];
            }
        }
    }
    return result;
}


- (void)setFilter:(ProductType *)productType
{
    if (nil == productType)
    {
        self.filterFlag = NO;
    }
    else
    {
        
        NSArray* result = nil;
        [self setCurrentFilter:productType];
        if (0 == [self.currentFilterLink count])
        {
            self.filterFlag = NO;
            return;
        }
        
        self.filterFlag = YES;
        result = self.productBases;
        for (ProductType* type in self.currentFilterLink)
        {
            result = [self productsInType:result filterByType:type];
        }
        
        self.productBasesWithFilter = [NSArray arrayWithArray:result];
    }
}

- (void)setFilterByTypeId:(NSString *)productTypeId
{
    if (nil == productTypeId)
    {
        [self setFilter:nil];
    }
    else
    {
        for (ProductType* type in self.productTypes)
        {
            if ([productTypeId isEqualToString:type.productType])
            {
                [self setFilter:type];
                return;
            }
        }
    }
}

- (ProductBase*)objectAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return (ProductBase*)[self.productBasesWithFilter objectAtIndex:index];
    }
    return (ProductBase*)[self.productBases objectAtIndex:index];
}

- (NSArray*)pricingsAtIndex:(NSInteger)index
{
    if (self.filterFlag)
    {
        return ((ProductBase*)[self.productBasesWithFilter objectAtIndex:index]).productPricings;
    }
    return ((ProductBase*)[self.productBases objectAtIndex:index]).productPricings;
}

- (void)addProductToBuy:(NSString *)productId
{
    //若id已经存在，则删除
    if ([self productIsInShoppingCart:productId])
    {
        [self.productsToBuy removeObjectForKey:productId];
    }
    //否则，增加
    else
    {
    for (ProductBase* product in self.productBases)
    {
        if ([productId isEqualToString:product.productId])
        {
            [self.productsToBuy setObject:product forKey:productId];
            break;
        }
    }
    }
}

- (BOOL)productIsInShoppingCart:(NSString *)productId
{
    if (nil == [self.productsToBuy objectForKey:productId])
    {
        return NO;
    }
    return YES;
}

- (void)setCurrentFilter:(ProductType*)type
{
    int count = [self.currentFilterLink count];
    if (count == 0)
    {
        [self.currentFilterLink addObject:type];
    }
    else
    {
        int insertIndex = 0;
        BOOL isFindSubType = 0;
        for (int i = 0; i < count; i++)
        {
            if ([((ProductType*)self.currentFilterLink[i]) isSubType:type])
            {
                [self.currentFilterLink setObject:type atIndexedSubscript:i+1];
                insertIndex = i+1;
                isFindSubType = YES;
            }
            
            if (isFindSubType && i > insertIndex)
            {
                [self.currentFilterLink removeObjectAtIndex:i];
            }
        }
        if (NO == isFindSubType)
        {
            [self.currentFilterLink setObject:type atIndexedSubscript:0];
            [self.currentFilterLink removeObjectsInRange:NSMakeRange(1, count-1)];
        }
    }
    
}

- (NSArray*)productsInType:(NSArray *)products filterByType:(ProductType *)type
{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    for (ProductBase* product in products)
    {
        for (ProductType* productType in product.productTypes)
        {
            if ([productType.productType isEqualToString:type.productType])
            {
                [result addObject:product];
                break;
            }
        }
    }
    
    return result;
}

- (NSArray*)productTypeForParent:(NSString *)productTypeId
{
    NSMutableArray* resutl = [[NSMutableArray alloc]init];
    for (ProductType* productType in self.productTypes)
    {
        if ([productTypeId isEqualToString:productType.typeParent])
        {
            [resutl addObject:productType];
            [productType show];
        }
    }
    return resutl;
}
@end
