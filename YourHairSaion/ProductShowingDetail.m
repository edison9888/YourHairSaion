//
//  ImageSource.m
//  UITest3
//
//  Created by chen loman on 12-11-11.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductShowingDetail.h"
#import "LifeBarDataProvider.h"

@implementation ProductShowingDetail
@synthesize productName;
@synthesize productDetail;
//@synthesize uiImg;
@synthesize fileName;
@synthesize fullFileName;
@synthesize price;
@synthesize productTypeName;
@synthesize priceAfterDiscount;
@synthesize productId, index, buyCount, detail, orgId;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.price = [NSNumber numberWithDouble:0.0f];
        self.Id = 0;
        self.name = @"请输入产品名称";
        self.status = 0;
        self.type = 0;
        self.detail = @"请输入产品明细信息";
        self.priority = 0;
        self.orgId = [[LifeBarDataProvider shareInstance]getCurrentOrgInfo].orgId;
        self.amount = 0;
        self.buyCount = 0;
    }
    return self;
}
+ (ProductShowingDetail*)initByIndex:(NSInteger)index
{
    ProductShowingDetail* this = [[ProductShowingDetail alloc]init];
    DataAdapter *da = [DataAdapter shareInstance];
    this.productId = [da ProductIdAtIndex:index];
    this.productName = [da captionAtIndex:index];
    this.index = index;
    //this.productDetail = [da detailAtIndex:index];
    //[UIImage imageWithContentsOfFile:<#(NSString *)#>]
    //this.imgLink = [da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_THUMB];
    [this setImgDicWithDic:[da objectAtIndex:index].dicImages];
    [this setImgLinkDic:[da objectAtIndex:index].productPics];
    this.name = [da captionAtIndex:index];
    //this.uiImg = [UIImage imageWithContentsOfFile:[da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_THUMB]];
    this.fullFileName = [da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_FULL];
    this.price = [da priceAtIndex:index];
    this.key = this.productId;
    this.detail = [da detailAtIndex:index];
    /*
    ProductPricing* pricing = ([da pricingsAtIndex:index][0]);
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    if ([pricing.discountType isEqualToNumber:PRODUCT_DISCOUNT_TYPE_CUT])
    {
        this.priceAfterDiscount = [NSNumber numberWithDouble:([this.price doubleValue] - [[numberFormatter numberFromString:pricing.calcValue] doubleValue])];
        this.productDetail = [NSString stringWithFormat:@"%@\n原价:%@ %@:%@\n折后价:%@",[da detailAtIndex:index], this.price, pricing.discountName, pricing.calcValue, this.priceAfterDiscount ];
    }
    else if  ([pricing.discountType isEqualToNumber:PRODUCT_DISCOUNT_TYPE_PERCENT])
    {
        int calcValue = [[numberFormatter numberFromString:pricing.calcValue] integerValue];
        this.priceAfterDiscount = [NSNumber numberWithDouble:([this.price doubleValue] * calcValue / 100)];
        
        this.productDetail = [NSString stringWithFormat:@"%@\n原价:%@ %@:%d折\n折后价:%@",[da detailAtIndex:index], this.price, pricing.discountName, calcValue/10 , this.priceAfterDiscount ];
    }
     */
    this.productDetail = [NSString stringWithFormat:@"%@\n价格:%@",[da detailAtIndex:index], this.price];
    this.buyCount = 0;
    this.orgId = [da objectAtIndex:index].orgId;
;

    return this;
}

+ (ProductShowingDetail*)initByDic:(NSDictionary *)dic
{
    ProductShowingDetail* this = [[ProductShowingDetail alloc]init];
    this.Id = [[dic objectForKey:@"productId"]longValue];
    this.name = [dic objectForKey:@"name"];
    this.status = [[dic objectForKey:@"status"]shortValue];
    this.type = [[dic objectForKey:@"type"]integerValue];
    this.detail = [dic objectForKey:@"detail"];
    this.priority = [[dic objectForKey:@"priority"]integerValue];
    this.orgId = [[dic objectForKey:@"orgId"]integerValue];
    this.price = [NSNumber numberWithDouble:[[dic objectForKey:@"price"]doubleValue]];
    this.amount = [[dic objectForKey:@"amount"]integerValue];
    this.productDetail = [NSString stringWithFormat:@"%@\n价格:%@",this.detail, this.price];
    this.buyCount = 0;
    ;
    
    return this;
}

+ (ProductShowingDetail*)initByProductBase:(ProductBase *)productBase
{
    ProductShowingDetail* this = [[ProductShowingDetail alloc]init];
    this.productId = productBase.productId;
    this.key = this.productId;
    this.productName = productBase.productName;
    for (ProductPic *pic in productBase.productPics)
    {
//        if ([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_THUMB])
//        {
//            //this.uiImg = [UIImage imageNamed:pic.picLink];
//            [this setDefalutImgLink:pic.picLink];
//
//        }
        if([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_FULL])
        {
            this.fullFileName = pic.picLink;
        }
    }
    [this setImgDicWithDic:productBase.dicImages];
    [this setImgLinkDic:productBase.productPics];

    this.name = productBase.productName;
    this.price = productBase.productPrice;
    this.detail = productBase.productDetail;
    /*
    ProductPricing* pricing = (productBase.productPricings[0]);
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    if ([pricing.discountType isEqualToNumber:PRODUCT_DISCOUNT_TYPE_CUT])
    {
        this.priceAfterDiscount = [NSNumber numberWithDouble:([this.price doubleValue] - [[numberFormatter numberFromString:pricing.calcValue] doubleValue])];
        this.productDetail = [NSString stringWithFormat:@"%@\n原价:%@ %@:%@\n折后价:%@",productBase.productDetail, this.price, pricing.discountName, pricing.calcValue, this.priceAfterDiscount ];
    }
    else if  ([pricing.discountType isEqualToNumber:PRODUCT_DISCOUNT_TYPE_PERCENT])
    {
        int calcValue = [[numberFormatter numberFromString:pricing.calcValue] integerValue];
        this.priceAfterDiscount = [NSNumber numberWithDouble:([this.price doubleValue] * calcValue / 100)];
        
        this.productDetail = [NSString stringWithFormat:@"%@\n原价:%@ %@:%d折\n折后价:%@",productBase.productDetail, this.price, pricing.discountName, calcValue/10 , this.priceAfterDiscount ];
    }
     */
    this.productDetail = [NSString stringWithFormat:@"%@\n价格:%@",this.detail, this.price];
    this.buyCount = 0;
    this.orgId = productBase.orgId;
    return this;
}


- (BOOL)isShowCaption
{
    return YES;
}

- (NSInteger)imageCount
{
    int count = 0;
    if (nil != [self.imgDic objectForKey:PRODUCT_PIC_TYPE_BACK])
    {
        count ++;
    }
    if (nil != [self.imgDic objectForKey:PRODUCT_PIC_TYPE_LEFT])
    {
        count ++;
    }
    count ++;
    return count;
}

- (UIImage*)imageAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return [self.imgDic objectForKey:PRODUCT_PIC_TYPE_THUMB];
        case 1:
            return [self.imgDic objectForKey:PRODUCT_PIC_TYPE_LEFT];
        case 2:
            return [self.imgDic objectForKey:PRODUCT_PIC_TYPE_BACK];
        default:
            return [self.imgDic objectForKey:PRODUCT_PIC_TYPE_THUMB];
    }
    
}
@end
