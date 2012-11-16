//
//  ImageSource.m
//  UITest3
//
//  Created by chen loman on 12-11-11.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductShowingDetail.h"

@implementation ProductShowingDetail
@synthesize productName;
@synthesize productDetail;
@synthesize uiImg;
@synthesize fileName;
@synthesize fullFileName;
@synthesize price;
@synthesize productTypeName;
@synthesize priceAfterDiscount;
@synthesize productId;

+ (ProductShowingDetail*)initByIndex:(NSInteger)index
{
    ProductShowingDetail* this = [[ProductShowingDetail alloc]init];
    DataAdapter *da = [DataAdapter shareInstance];
    this.productId = [da ProductIdAtIndex:index];
    this.productName = [da captionAtIndex:index];
    //this.productDetail = [da detailAtIndex:index];
    this.uiImg = [UIImage imageNamed:[da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_THUMB]];
    this.fullFileName = [da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_FULL];
    this.price = [da priceAtIndex:index];
    
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
    
    return this;
}

+ (ProductShowingDetail*)initByProductBase:(ProductBase *)productBase
{
    ProductShowingDetail* this = [[ProductShowingDetail alloc]init];
    this.productId = productBase.productId;
    this.productName = productBase.productName;
    for (ProductPic *pic in productBase.productPics)
    {
        if ([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_THUMB])
        {
            this.uiImg = [UIImage imageNamed:pic.picLink];
        }
        else if([pic.picType isEqualToNumber:PRODUCT_PIC_TYPE_FULL])
        {
            this.fullFileName = pic.picLink;
        }
    }
    this.price = productBase.productPrice;
    
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
    
    return this;
}

@end
