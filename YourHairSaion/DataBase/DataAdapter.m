//
//  DataAdapter.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DataAdapter.h"
#import "ProductShowingDetail.h"
#import "ProductTypeItem.h"
#import "UIImage+fixOrientation.h"
#import "OrganizationItem.h"
#import "DiscountCardItem.h"
#import "ConfAdapter.h"
static NSString* img_path_in_document;
@interface DataAdapter()
- (void)setCurrentFilter:(ProductType*)type;
- (NSArray*)productsInType:(NSArray*)products filterByType:(ProductType*)type;
- (void)generateProductsInShoppingCart;
- (NSArray*)arrayWithFilter;
- (ProductType*)findParent:(ProductType*)productType;
- (void)doFilter;
- (void)validData;
- (BOOL)loadProductFromDatabase;
- (void)resetFilter;
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
        if ([self initData])
        {
            return self;
        }
        
    }
    return nil;
}

- (NSString*) serialNo
{
    return [[DBManager shareInstance]serialNo];
}

- (BOOL)loadProductFromDatabase
{
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
        //return NO;
    }
    
    self.productAttrs = [dbManager getAll:@"ProductAttr"];
    
    if( [self mergeData])
    {
        [self resetFilter];
    }
    return YES;
    
}
- (BOOL)initData
{
    self.filterType = FILTER_TYPE_NO;
    img_path_in_document = [[self path]stringByAppendingString:PATH_IMG_PATH_IN_DOCUMENTS];
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
        //return NO;
    }
    
    self.productAttrs = [dbManager getAll:@"ProductAttr"];
    
    self.organizations = [dbManager getAll:@"Organization"];
    
    self.discountCards = [dbManager getAll:@"DiscountCard"];
    
    [self mergeData];
    [self validData];
    
    productsToBuy = [[NSMutableDictionary alloc]init];
    self.currentFilterLink = [[NSMutableArray alloc]init];
    
    return YES;
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
                    if (![productBase.productTypes containsObject:productType])
                    {
                        [productBase.productTypes addObject:productType];
                        break;
                    }
                    
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
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [productBase.dicImages setObject:img forKey:productPic.picType];
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
    
    
    [self mergeOrg];
    [self mergeDiscountCard];
    
    
    return YES;
}

- (void)mergeOrg
{
    for (Organization* org in self.organizations)
    {
        org.dicImages = [NSMutableDictionary dictionary];
        for (ProductPic* productPic in self.productPics)
        {
            if ([org.orgId isEqualToString:productPic.productId])
            {
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [org.dicImages setObject:img forKey:productPic.picType];
            }
        }
        if ([org.dicImages objectForKey:PRODUCT_PIC_TYPE_DEFAULT] == nil)
        {
            UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:org.imgLink]];
            [org.dicImages setObject:img forKey:PRODUCT_PIC_TYPE_DEFAULT];
        }
    }
}

- (void)mergeDiscountCard
{
    for (DiscountCard* card in self.discountCards)
    {
        card.dicImages = [NSMutableDictionary dictionary];
        for (ProductPic* productPic in self.productPics)
        {
            if ([card.cardId isEqualToString:productPic.productId])
            {
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [card.dicImages setObject:img forKey:productPic.picType];
            }
        }
        if ([card.dicImages objectForKey:PRODUCT_PIC_TYPE_DEFAULT] == nil)
        {
            UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:card.imgLink]];
            [card.dicImages setObject:img forKey:PRODUCT_PIC_TYPE_DEFAULT];
        }
        
        for (ProductPricing* productPricing in self.productPricings)
        {
            if ([card.cardId isEqualToString:productPricing.productId])
            {
                card.productPricing = productPricing;
                break;
            }
        }
    }
}

- (void)validData
{
    int count = [self.productBases count];
    NSMutableArray* array = [[NSMutableArray alloc]initWithArray:self.productBases];
    for (int i = 0; i < count; i++)
    {
        NSString* tmp = [self ImageLinkAtIndex:i andType:PRODUCT_PIC_TYPE_THUMB];
        if (nil == tmp )
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
            return [self getLocalPath:pic.picLink];
        }
        //找不到对应的pic，则返回缩略图
        if ([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_THUMB])
        {
            defaultImgLink = pic.picLink;
        }
    }
    
    return [self getLocalPath:defaultImgLink];
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
        [self setCurrentFilter:productType];
        if (0 == [self.currentFilterLink count])
        {
            self.filterType = FILTER_TYPE_NO;
            return;
        }
        [self doFilter];
        
    }
}

- (void)doFilter
{
    NSArray* result = nil;
    
    self.filterType = FILTER_TYPE_PRODUCT_TYPE;
    result = self.productBases;
    for (ProductType* type in self.currentFilterLink)
    {
        result = [self productsInType:result filterByType:type];
    }
    
    self.productBasesWithFilter = [NSArray arrayWithArray:result];
    
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
        [self generateProductsInShoppingCart];

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

- (void)deleteProductToBuy:(NSString *)productId
{
    if ([self productIsInShoppingCart:productId])
    {
        [self.productsToBuy removeObjectForKey:productId];
        [self generateProductsInShoppingCart];

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
    NSArray* array = [self.productsToBuy allValues];
    for (NSNumber* count in array)
    {
        total += [count intValue];
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
    NSRange compareRang;
    
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

- (NSString*)dbFilePath
{
    NSURL *storeURL = [[[DBManager shareInstance] applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourHairSaion.sqlite"];
    return [storeURL path];
}

- (NSString*)dbPath
{
    NSURL *storeURL = [[[DBManager shareInstance] applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourHairSaion.sqlite"];
    return [[storeURL path] stringByDeletingLastPathComponent];
}

- (NSString*)path
{
    NSURL *storeURL = [[DBManager shareInstance] applicationDocumentsDirectory];
    return [storeURL path];
}

- (NSString*)imgPath
{
    return [[self path]stringByAppendingPathComponent:PATH_IMG_PATH_IN_DOCUMENTS];
}

- (NSString*)defaultProductImg
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:PRODUCT_PIC_DEFALUT_THUMB];
}

- (NSString*)getLocalPath:(NSString*)fileName
{
    NSString *path = [self defaultProductImg];
    if (nil == fileName || [@"" isEqualToString:fileName])
    {
        return path;
    }
    //检查文件是否存在,并返回正确路径
    path = [[DBManager shareInstance]pathForImageResource:fileName];
    NSError * error = nil;
    if (![[LCFileManager shareInstance]checkSourPath:path error:&error])
    {
        path = [img_path_in_document stringByAppendingString:fileName];
        if (![[LCFileManager shareInstance]checkSourPath:path error:&error])
        {
            path = [self defaultProductImg];
            
        }
    }
    return path;
}

//重新生成当前“过滤数据”
- (void)resetFilter
{
    switch (self.filterType)
    {
        case FILTER_TYPE_NO:
            //do nothing
            break;
        case FILTER_TYPE_SHOPPING_CART:
            [self setFilterByTypeId:STRING_FOR_SHOPPING_CART_FILTER];
            break;
        case FILTER_TYPE_SEARCH:
            [self setFilterByTypeId:STRING_FOR_SEARCH_FILTER];
            break;
        case FILTER_TYPE_PRODUCT_TYPE:
            [self doFilter];
            break;
            
        default:
            break;
    }
}

- (void)deletebyProductId:(NSString *)productId
{
    ProductBase* product = [self productBaseByProduceId:productId];
    DBManager* dm = [DBManager shareInstance];
    [dm deleteRecord:product.productAmount];
    [dm deleteRecords:product.productAttrs];
    //[dm deleteRecords:product.productPics];
    [dm deletePicsById:productId];
    [dm deletePricingsById:productId];
    [dm deleteRecord:product];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.productBases];
    [array removeObject:product];
    self.productBases = [NSArray arrayWithArray:array];
    
    //[self loadProductFromDatabase];
    
}

- (NSString*)imgFileNameGenerator
{
    return [[DBManager shareInstance]serialNo];
}

- (void)updateProduct:(ProductShowingDetail *)dataItem
{
    ProductBase* product = [self productBaseByProduceId:dataItem.productId];
    //[[DBManager shareInstance]updateProduct:dataItem.productId andName:dataItem.name andDetail:dataItem.detail andState:nil andType:[self productTypeString:dataItem.productId] andPricingId:product.pricingTypeId andPrice:dataItem.price andPriority:nil andOrgId:dataItem.orgId allowCustomize:nil andEffDate:nil andExpDate:nil];
    
    [self updateProductPic:dataItem.productId withPicDic:dataItem.imgLinkDic];
    [self reloadPicForProductId:dataItem.productId];
    [dataItem setImgDicWithDic:[self productBaseByProduceId:dataItem.productId].dicImages];
}

- (NSString*)productTypeString:(NSString*)productId
{
    ProductBase* product = [self productBaseByProduceId:productId];
    NSMutableString* result = [NSMutableString stringWithString:@""];
    for (ProductType* type in product.productTypes)
    {
        [result appendString:type.productType];
        [result appendString:@","];
    }
    NSLog(@"productTypeString:%@", result);
    return result;
}
- (NSString*)createNewProduct
{
    NSString* productId = [[DBManager shareInstance]insertNewProduct:@"请输入产品名称" andDetail:@"请输入产品描述" andState:PRODUCT_STATE_ONSALE andType:@"" andPricingId:@"" andPrice:[NSNumber numberWithDouble:0.0f] andPriority:PRODUCT_PRIORITY_NORMAL andOrgId:@"" allowCustomize:PRODUCT_CUSTOMIZE_FLAG_OFF andEffDate:[NSDate date] andExpDate:[NSDate date]];
    [self loadProductFromDatabase];
    ProductBase* product = [[DBManager shareInstance]getProductInDbById:productId];
    product.dicImages  = [NSMutableDictionary dictionary];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.productBases];
    [array addObject:product];
    self.productBases = [NSArray arrayWithArray:array];
    return productId;
}



- (void)updateProductPic:(NSString*)productId withPicDic:(NSDictionary*)picDic;
{
    NSArray* keys = [picDic allKeys];
    NSString* fileName = nil;
    //update pic
    for (NSNumber* key in keys)
    {
        BOOL founded = NO;
        fileName = [picDic objectForKey:key];
        if (fileName)
        {
            NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
            NSLog(@"%@ updateProductPic type:%@", productId, key);;

            for (ProductPic* pic in pics)
            {
                if ([pic.productId isEqualToString:productId] && [pic.picType isEqualToNumber:key])
                {
                    [[DBManager shareInstance]updateProductPic:productId andPicType:key andValue:nil andLink:fileName];
                    founded = YES;
                    break;
                }
            }
            if (!founded)
            {
                [[DBManager shareInstance]insertNewProductPic:productId andPicType:key andValue:nil andLink:fileName];
            }
        }
    }
}


- (void)resetDatabaseWithFile:(NSString*)filePath
{
    [[DBManager shareInstance]resetDatabaseWithFile:filePath];
    [self initData];
    [[ConfAdapter shareInstance]initData];

}

- (void)resetUserData
{
    self.filterType = FILTER_TYPE_NO;
    productsToBuy = [[NSMutableDictionary alloc]init];
    self.currentFilterLink = [[NSMutableArray alloc]init];
    self.currentSearchKey = @"";
    self.productBasesInShoppingCart = [NSArray array];
    self.productBasesWithSearch = [NSMutableArray array];
    
}


- (void)updateProductType:(ProductTypeItem *)dataItem
{
    [[DBManager shareInstance]updateProductType:dataItem.productType andName:dataItem.name andParent:dataItem.typeParent andPricingId:dataItem.typePricingId];
}
- (ProductType*)productTypeById:(NSString*)productTypeId
{
    for (ProductType* type in self.productTypes)
    {
        if ([type.productType isEqualToString:productTypeId])
        {
            return type;
        }
    }

}

- (void)deleteByProductTypeId:(NSString*)productTypeId
{
    [self deleteProductType:[self productTypeById:productTypeId]];
}
- (void)deleteProductType:(ProductType*)type
{
    [[DBManager shareInstance]deleteRecord:type];
}

- (void)insertProductType:(ProductTypeItem*)dataItem
{
    [[DBManager shareInstance]insertNewProductType:dataItem.name andParent:dataItem.typeParent andPricingId:dataItem.typePricingId];
    [self loadProductFromDatabase];

}

- (Organization*)orgByOrgId:(NSString*)orgId
{
    for (Organization* org in self.organizations)
    {
        if ([org.orgId isEqualToString:orgId])
        {
            return org;
        }
    }
    return nil;
}

- (void)reloadOrgs
{
    self.organizations = [[DBManager shareInstance] getAll:@"Organization"];
    self.productPics = [[DBManager shareInstance] getAll:@"ProductPic"];
    [self mergeOrg];
    for (ProductBase* productBase in self.productBases)
    {
        for (Organization* org in self.organizations)
        {
            if ([org.orgId isEqualToString:productBase.orgId])
            {
                productBase.org = org;
                break;
            }
            
        }
    }
    
}

- (void)deleteOrgByOrgId:(NSString*)orgId
{
    Organization* org = [self orgByOrgId:orgId];
    [[DBManager shareInstance]deletePicsById:orgId];
    [[DBManager shareInstance]deleteRecord:org];
    //[self reloadOrgs];
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.organizations];
    [array removeObject:org];
    self.organizations = [NSArray arrayWithArray:array];
}

- (void)updateOrg:(OrganizationItem *)dataItem
{
    Organization* org = [self orgByOrgId:dataItem.key];
    [[DBManager shareInstance]updateOrganization:dataItem.key andName:dataItem.name andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:dataItem.detail andParent:ORG_ROOT andStreet:dataItem.street andCity:dataItem.city andState:dataItem.state andZip:dataItem.zip andLatitude:[NSNumber numberWithDouble:dataItem.latitude] andLongitude:[NSNumber numberWithDouble:dataItem.longitude] andPhone:dataItem.phone andWebsite:dataItem.url andEmail:dataItem.email andImgLink:[dataItem.imgLinkDic objectForKey:PRODUCT_PIC_TYPE_DEFAULT]];
    
    //update pic
//    for (NSNumber* key in [dataItem.imgLinkDic allKeys])
//    {
//        BOOL founded = NO;
//        NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
//        for (ProductPic* pic in pics)
//        {
//            if ([pic.productId isEqualToString:dataItem.key] && [pic.picType isEqualToNumber:key])
//            {
//                [[DBManager shareInstance]updateProductPic:dataItem.key andPicType:key andValue:nil andLink:[dataItem.imgLinkDic objectForKey:key]];
//                founded = YES;
//                break;
//            }
//        }
//        if (!founded)
//        {
//        [[DBManager shareInstance]insertNewProductPic:dataItem.key andPicType:key andValue:nil andLink:[dataItem.imgLinkDic objectForKey:key]];
//        }
//    }
    [self updateProductPic:dataItem.key withPicDic:dataItem.imgLinkDic];
    [self reloadPicForOrgId:dataItem.key];
    org = [self orgByOrgId:dataItem.key];
    [dataItem setImgDicWithDic:org.dicImages];
}

- (NSString*)createNewOrg
{
    NSString* orgId = [[DBManager shareInstance]insertNewOrganization:@"请输入分店名称" andOrgType:ORG_TYPE_ROOT_FAXING andOrgDetail:@"无" andParent:ORG_ROOT andStreet:@"" andCity:@"广州" andState:@"中国" andZip:@"526000" andLatitude:[NSNumber numberWithDouble:111.111] andLongitude:[NSNumber numberWithDouble:222.222] andPhone:@"000000" andWebsite:@"" andEmail:@"" andImgLink:PRODUCT_PIC_DEFALUT_THUMB];
    Organization* org = [[DBManager shareInstance]getOrgInDbById:orgId];
    org.dicImages  = [NSMutableDictionary dictionary];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.organizations];
    [array addObject:org];
    self.organizations = [NSArray arrayWithArray:array];
    return orgId;
}

- (NSString*)createNewDiscountCard
{
    NSString* cardId = [[DBManager shareInstance]insertNewDiscountCard:@"会员卡" andType:PRODUCT_DISCOUNT_TYPE_CUT andDetail:@"会员卡" andOverlay:DISCOUNT_CARD_NO_OVERLAY andImgLink:@"vipcard1.png"];
    DiscountCard* dc = [[DBManager shareInstance]getDiscountCardInDbById:cardId];
    dc.dicImages = [NSMutableDictionary dictionary];
    dc.productPricing = [[DBManager shareInstance] insertNewProductPricing:cardId andProductType:@""  andDiscountType:PRODUCT_DISCOUNT_TYPE_CUT andDiscountName:@"立减" andCalcValue:[NSString stringWithFormat:@"%d", arc4random()%100+100]];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.discountCards];
    [array addObject:dc];
    self.discountCards = [NSArray arrayWithArray:array];
    return cardId;
}
- (DiscountCard*)discountCardByCardId:(NSString*)cardId
{
    for (DiscountCard* card in self.discountCards)
    {
        if ([card.cardId isEqualToString:cardId])
        {
            return card;
        }
    }

    return nil;
}
- (void)reloadDiscountCards
{
    self.discountCards = [[DBManager shareInstance] getAll:@"DiscountCard"];
    [self reloadPics];
    self.productPricings = [[DBManager shareInstance] getAll:@"ProductPricing"];

    [self mergeDiscountCard];
}

- (void)deleteDiscountCardByCardId:(NSString*)cardId
{
    DiscountCard* card = [self discountCardByCardId:cardId];
    [[DBManager shareInstance]deletePicsById:cardId];
    [[DBManager shareInstance]deletePricingsById:cardId];
    [[DBManager shareInstance]deleteRecord:card];
    //[self reloadDiscountCards];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.discountCards];
    [array removeObject:card];
    self.discountCards = [NSArray arrayWithArray:array];

}
- (void)updateDiscountCard:(DiscountCardItem*)dataItem
{
    DiscountCard* card = [self discountCardByCardId:dataItem.key];
    NSLog(@"key=%@ name=%@", dataItem.key, dataItem.name);
    [[DBManager shareInstance]updateDiscountCard:dataItem.key andName:dataItem.name andType:dataItem.type andDetail:dataItem.detail andOverlay:dataItem.overlay andImgLink:[dataItem.imgLinkDic objectForKey:PRODUCT_PIC_TYPE_DEFAULT]];
    if (card.productPricing)
    {
        card.productPricing = [[DBManager shareInstance]upateProductPricing:dataItem.key andProductType:card.productPricing.productType andDiscountType:dataItem.discountType andDiscountName:dataItem.discountName andCalcValue:dataItem.calcValue];
    }
    else
    {
        card.productPricing = [[DBManager shareInstance]insertNewProductPricing:dataItem.key andProductType:@"" andDiscountType:dataItem.discountType andDiscountName:dataItem.discountName andCalcValue:dataItem.calcValue];
    }
    
    //update pic
//    NSArray* keys = [dataItem.imgLinkDic allKeys];
//    for (NSNumber* key in keys)
//    {
//        BOOL founded = NO;
//        NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
//        for (ProductPic* pic in pics)
//        {
//            if ([pic.productId isEqualToString:dataItem.key] && [pic.picType isEqualToNumber:key])
//            {
//                [[DBManager shareInstance]updateProductPic:dataItem.key andPicType:key andValue:nil andLink:[dataItem.imgLinkDic objectForKey:key]];
//                founded = YES;
//                break;
//            }
//        }
//        if (!founded)
//        {
//            [[DBManager shareInstance]insertNewProductPic:dataItem.key andPicType:key andValue:nil andLink:[dataItem.imgLinkDic objectForKey:key]];
//        }
//    }
    [self updateProductPic:dataItem.key withPicDic:dataItem.imgLinkDic];
    [self reloadPicForDiscountCardId:dataItem.key];
    card = [self discountCardByCardId:dataItem.key];
    [dataItem setImgDicWithDic:card.dicImages];
}


- (void)reloadPics
{
    self.productPics = [[DBManager shareInstance] getAll:@"ProductPic"];
    
}

- (NSArray*)pics
{
    return [[DBManager shareInstance] getAll:@"ProductPic"];
}

- (NSArray*)products
{
    return [[DBManager shareInstance] getAll:@"ProductBase"];
}

- (NSArray*)discountcards
{
    return [[DBManager shareInstance] getAll:@"DiscountCard"];
}


- (NSArray*)orgs
{
    return [[DBManager shareInstance] getAll:@"Organization"];

}


- (NSArray*)picsInUse
{
    NSArray* pics = [[DataAdapter shareInstance] pics];
    NSMutableArray* picsInUse = [NSMutableArray array];
    
    for (ProductPic* pic in pics)
    {
        BOOL founded = NO;
        for (ProductBase* product in self.productBases)
        {
            if ([product.productId isEqualToString:pic.productId])
            {
                [picsInUse addObject:pic.picLink];
                founded = YES;
                break;
            }
        }
        if (founded)
        {
            continue;
        }
        for (Organization* org in self.organizations)
        {
            if ([org.orgId isEqualToString:pic.productId])
            {
                [picsInUse addObject:pic.picLink];
                founded = YES;
                break;
            }
        }
        if (founded)
        {
            continue;
        }
        for (DiscountCard* card in self.discountCards)
        {
            if ([card.cardId isEqualToString:pic.productId])
            {
                [picsInUse addObject:pic.picLink];
                founded = YES;
                break;
            }
        }
        if (founded)
        {
            continue;
        }
    }
    
    return [NSArray arrayWithArray:picsInUse];
}


- (void)reloadPicForDiscountCardId:(NSString*)cardId
{
    DiscountCard* card = [self discountCardByCardId:cardId];
    if (card)
    {
        NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
        for (ProductPic* productPic in pics)
        {
            if ([card.cardId isEqualToString:productPic.productId])
            {
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [card.dicImages setObject:img forKey:productPic.picType];
            }
        }
        if ([card.dicImages objectForKey:PRODUCT_PIC_TYPE_DEFAULT] == nil)
        {
            UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:card.imgLink]];
            [card.dicImages setObject:img forKey:PRODUCT_PIC_TYPE_DEFAULT];
        }
    }
}

- (void)reloadPicForOrgId:(NSString*)orgId
{
    Organization* org = [self orgByOrgId:orgId];
    if (org)
    {
        NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
        for (ProductPic* productPic in pics)
        {
            if ([org.orgId isEqualToString:productPic.productId])
            {
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [org.dicImages setObject:img forKey:productPic.picType];
            }
        }
        if ([org.dicImages objectForKey:PRODUCT_PIC_TYPE_DEFAULT] == nil)
        {
            UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:org.imgLink]];
            [org.dicImages setObject:img forKey:PRODUCT_PIC_TYPE_DEFAULT];
        }
    }
}

- (void)reloadPicForProductId:(NSString*)productId
{
    ProductBase* product = [self productBaseByProduceId:productId];
    if (product)
    {
        NSArray* pics = [[DBManager shareInstance] getAll:@"ProductPic"];
        for (ProductPic* productPic in pics)
        {
            if ([product.productId isEqualToString:productPic.productId])
            {
                UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:productPic.picLink]];
                [product.dicImages setObject:img forKey:productPic.picType];
            }
        }
        if ([product.dicImages objectForKey:PRODUCT_PIC_TYPE_DEFAULT] == nil)
        {
            UIImage* img = [UIImage imageWithContentsOfFile:[self getLocalPath:PRODUCT_PIC_DEFALUT_THUMB]];
            [product.dicImages setObject:img forKey:PRODUCT_PIC_TYPE_DEFAULT];
        }
    }
}


@end
