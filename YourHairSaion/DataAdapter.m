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
- (void)generateProductsInShoppingCart;
@end
@implementation DataAdapter
@synthesize productPricings;
@synthesize productAttrs;
@synthesize productAmounts;
@synthesize productBases;
@synthesize productPics;
@synthesize productTypes;
@synthesize organizations;
@synthesize productBasesWithFilter, productBasesInShoppingCart;
@synthesize filterType;
@synthesize productsToBuy, discountCards;

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
    self.filterType = FILTER_TYPE_NO;
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
    
    self.discountCards = [dbManager getAll:@"DiscountCard"];

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
for (DiscountCard* dc in self.discountCards)
{
    for (ProductPricing* productPricing in self.productPricings)
    {
        if ([dc.cardId isEqualToString:productPricing.productId])
        {
            dc.productPricing = productPricing;
            break;
        }
    }
}
    return YES;
}

- (int)count
{
    switch (self.filterType)
    {
        case FILTER_TYPE_NO:
            return [self.productBases count];
        case FILTER_TYPE_PRODUCT_TYPE:
            return [self.productBasesWithFilter count];
        case FILTER_TYPE_SHOPPING_CART:
            return [self.productBasesInShoppingCart count];
    }
    return 0;
}

- (NSString*)captionAtIndex:(NSInteger)index
{
    return [self objectAtIndex:index].productName;
}

- (NSString*)detailAtIndex:(NSInteger)index
{
    return [self objectAtIndex:index].productDetail;
}

- (NSString*)ImageLinkAtIndex:(NSInteger)index andType:(NSNumber *)type
{
    ProductBase* productBase = [self objectAtIndex:index];
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
    return [self objectAtIndex:index].productPrice;
}

- (NSNumber*)amountAtIndex:(NSInteger)index
{
    return [self objectAtIndex:index].productAmount.amount;

}

- (NSString*)ProductIdAtIndex:(NSInteger)index
{
    return [self objectAtIndex:index].productId;
    
}

- (NSArray*)productFilterByType:(NSString *)type
{
    self.filterType = FILTER_TYPE_PRODUCT_TYPE;
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

//根据类型设置过滤标志
- (void)setFilter:(ProductType *)productType
{
    if (nil == productType)
    {
        self.filterType = FILTER_TYPE_NO;
    }
    else
    {
        
        NSArray* result = nil;
        [self setCurrentFilter:productType];
        if (0 == [self.currentFilterLink count])
        {
            self.filterType = FILTER_TYPE_NO;
            return;
        }
        
        self.filterType = FILTER_TYPE_PRODUCT_TYPE;
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
    //产生productInshoppingcart队列
    else if ([productTypeId isEqualToString:STRING_FOR_SHOPPING_CART_FILTER])
    {
        self.filterType = FILTER_TYPE_SHOPPING_CART;
        [self generateProductsInShoppingCart];

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
    switch (self.filterType)
    {
        case FILTER_TYPE_NO:
            return [self.productBases objectAtIndex:index];
        case FILTER_TYPE_PRODUCT_TYPE:
            return [self.productBasesWithFilter objectAtIndex:index];
        case FILTER_TYPE_SHOPPING_CART:
            return [self.productBasesInShoppingCart objectAtIndex:index];
    }
    return[self.productBases objectAtIndex:index];
}

- (NSArray*)pricingsAtIndex:(NSInteger)index
{

    return [self objectAtIndex:index].productPricings;
}

- (void)addProductToBuy:(NSString *)productId
{
    //若id已经存在，则购买数量加1
    if ([self productIsInShoppingCart:productId])
    {
        NSNumber* count = [self.productsToBuy objectForKey:productId];
        int icount = [count intValue];
        icount ++;
        count = [[NSNumber alloc]initWithInt:icount];
        [self.productsToBuy setObject:count forKey:productId];
    }
    //否则，增加购买物品
    else
    {
        NSNumber* count = [[NSNumber alloc]initWithInt:1];
        [self.productsToBuy setObject:count forKey:productId];
    }
}

- (void)reduceProductToBuy:(NSString *)productId
{
    //若id已经存在，则购买数量-1
    if ([self productIsInShoppingCart:productId])
    {
        NSNumber* count = [self.productsToBuy objectForKey:productId];
        int icount = [count intValue];
        icount --;
        if (icount > 0)
        {
            count = [[NSNumber alloc]initWithInt:icount];
            [self.productsToBuy setObject:count forKey:productId];
        }
        else
        {
            [self.productsToBuy removeObjectForKey:productId];
            [self generateProductsInShoppingCart];
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
//返回该产品在购物车中的数量
- (NSUInteger)numInShoppingCart:(NSString *)productId
{
    if ([self productIsInShoppingCart:productId])
    {
        NSNumber* count = [self.productsToBuy objectForKey:productId];
        return (NSUInteger)[count intValue];
    }
    return 0;
}
//设置当前过滤链
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

//在指定product array里查找符合类型type的集合
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

//查找以productTypeid为父类的类型
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

- (ProductBase*)productBaseByProduceId:(NSString *)productId
{
    for (ProductBase* productBase in self.productBases)
    {
        if ([productBase.productId isEqualToString:productId])
        {
            return productBase;
        }
    }
}

- (NSString*)currentFilter
{
    return ((ProductType*)[self.currentFilterLink lastObject]).productType;
}

- (NSUInteger)totalNumInShoppingCart
{
    NSUInteger total = 0;
    for (ProductBase* product in self.productBasesInShoppingCart)
    {
        total =  total + [self numInShoppingCart:product.productId];
    }
    return total;
}

- (CGFloat)totalPriceInShoppingCart
{
    CGFloat total = 0.0f;
    for (ProductBase* product in self.productBasesInShoppingCart)
    {
        total += [self numInShoppingCart:product.productId] * [product.productPrice floatValue];
    }
    return total;
}

- (void)generateProductsInShoppingCart
{
    NSArray* productIdArray = [self.productsToBuy allKeys];
    NSMutableArray *products = [[NSMutableArray alloc]init];
    for (NSString* productId in productIdArray)
    {
        [products addObject:[self productBaseByProduceId:productId]];
    }
    self.productBasesInShoppingCart = [NSArray arrayWithArray:products];
}

- (NSString*)currentFilterLinkString
{
    NSMutableString *result = [[NSMutableString alloc]init];
    for(ProductType* type in self.currentFilterLink)
    {
        [result appendFormat:@"%@ - ", type.typeName];
    }
    NSLog(@"currentFilterLinkString:%@", result);
[result deleteCharactersInRange:NSMakeRange(result.length -3, 3)];
NSLog(@"currentFilterLinkString:%@", result);
return result;
}

@end
