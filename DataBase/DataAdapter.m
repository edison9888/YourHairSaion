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
- (NSArray*)arrayWithFilter;
- (ProductType*)findParent:(ProductType*)productType;
- (void)validData;
@end
@implementation DataAdapter
@synthesize productPricings;
@synthesize productAttrs;
@synthesize productAmounts;
@synthesize productBases;
@synthesize productPics;
@synthesize productTypes;
@synthesize organizations;
@synthesize productBasesWithFilter, productBasesInShoppingCart, productBasesWithSearch, currentSearchKey;
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

- (ProductType*)findParent:(ProductType*)productType
{
    if (![productType.typeParent isEqualToString:PRODUCT_TYPE_ROOT])
    {
    
    for (ProductType* productParent in self.productTypes)
    {
        if ([productType.typeParent isEqualToString:productParent.productType])
        {
            return productParent;
        }
    }
    }
    return nil;

}

- (BOOL)mergeData
{
    for (ProductType* productType in self.productTypes)
    {
        productType.parentType = [self findParent:productType];
    }
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
    
    [self validData];
    return YES;
}

- (void)validData
{
    int count = [self.productBases count];
    NSMutableArray* array = [[NSMutableArray alloc]initWithArray:self.productBases];
    for (int i = 0; i < count; i++)
    {
        if (nil == [self ImageLinkAtIndex:i andType:PRODUCT_PIC_TYPE_THUMB])
        {
            [array removeObjectAtIndex:i];
            i --;
            continue;
        }
    }
    self.productBases = [[NSArray alloc]initWithArray:array];
}

- (int)count
{
    return [[self arrayWithFilter] count];
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
    NSString* defaultImgLink = nil;
    for (ProductPic* pic in productBase.productPics)
    {
        if ([pic.picType isEqualToNumber:type])
        {
            return pic.picLink;
        }
        if ([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_THUMB])
        {
            defaultImgLink = pic.picLink;
        }
    }
    //找不到对应的pic，则返回缩略图

    return defaultImgLink;
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
    else if ([productTypeId isEqualToString:STRING_FOR_SEARCH_FILTER])
    {
        [self generateProductsWithSearch];
        //完成搜索后再进行属性设置，以便获取上一个过滤器
        self.filterType = FILTER_TYPE_SEARCH;
        
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
    return [[self arrayWithFilter] objectAtIndex:index];
}

- (NSArray*)arrayWithFilter
{
    switch (self.filterType)
    {
        case FILTER_TYPE_NO:
            return self.productBases;
        case FILTER_TYPE_PRODUCT_TYPE:
            return self.productBasesWithFilter;
        case FILTER_TYPE_SHOPPING_CART:
            return self.productBasesInShoppingCart;
        case FILTER_TYPE_SEARCH:
            return self.productBasesWithSearch;
    }
    return self.productBases;
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
    return nil;
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

- (void)generateProductsWithSearch
{
    if (nil == self.currentSearchKey || [@"" isEqualToString:self.currentSearchKey])
    {
        return;
    }
    NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
    int count = 0;
    //通过在不同的属性中进行查找，每种属性匹配的话，字典里数值增加相应的权值，最后根据匹配度进行结果输出
    NSArray* arrayToSearch = [self arrayWithFilter];
    NSRange compareRang = NSMakeRange(NSNotFound, 0);
    
    for (ProductBase* product in arrayToSearch)
    {
        //1.在产品名字中查询
        compareRang = [product.productName rangeOfString:self.currentSearchKey options:NSCaseInsensitiveSearch];
        if (compareRang.location != NSNotFound && compareRang.length > 0)
        {
            count += 4;
        }
        //2.在产品细节中查询
        compareRang = [product.productDetail rangeOfString:self.currentSearchKey options:NSCaseInsensitiveSearch];
        if (compareRang.location != NSNotFound && compareRang.length > 0)
        {
            count += 3;
        }
        //3.在产品类型中查询
        for (ProductType *type in product.productTypes)
        {
            compareRang = [type.typeName rangeOfString:self.currentSearchKey options:NSCaseInsensitiveSearch];
            if (compareRang.location != NSNotFound && compareRang.length > 0)
            {
                count += 2;
            }
            //4.在父类型中查询,只查找上一级类型
            if (nil != type.parentType)
            {
                compareRang = [type.parentType.typeName rangeOfString:self.currentSearchKey options:NSCaseInsensitiveSearch];
                if (compareRang.location != NSNotFound && compareRang.length > 0)
                {
                    count += 2;
                }
            }
        }
        if (count > 0)
        {
            [result setObject:[NSNumber numberWithInt:count] forKey:product.productId];
        }
    }
    NSArray* sortArray = [result keysSortedByValueUsingComparator:^(id ob1, id ob2)
                          {
                              NSNumber *num1 = ob1;
                              NSNumber *num2 = ob2;
                              return [num1 compare:num2];
                          }] ;
    self.productBasesWithSearch = [[NSMutableArray alloc]initWithCapacity:sortArray.count];
    for (NSString* productId in sortArray)
    {
        [self.productBasesWithSearch addObject:[self productBaseByProduceId:productId]];
    }
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

- (void)setSearchKey:(NSString *)searchKey
{
    self.currentSearchKey = searchKey;
}

- (NSString*)filePath
{
    NSURL *storeURL = [[[DBManager shareInstance] applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourHairSaion.sqlite"];
    return [storeURL path];
}
- (NSString*)path
{
    NSURL *storeURL = [[DBManager shareInstance] applicationDocumentsDirectory];
    return [storeURL path];
}
@end
