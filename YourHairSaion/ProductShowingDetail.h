//
//  ImageSource.h
//  UITest3
//
//  Created by chen loman on 12-11-11.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAdapter.h"

@interface ProductShowingDetail : NSObject
@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* productName;
@property (nonatomic, strong) NSString* productDetail;
@property (nonatomic, strong) UIImage* uiImg;
@property (nonatomic, strong) NSString* fileName;
@property (nonatomic, strong) NSString* fullFileName;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSString* productTypeName;
@property (nonatomic, strong) NSNumber* priceAfterDiscount;

+ (ProductShowingDetail*)initByIndex:(NSInteger)index;
+ (ProductShowingDetail*)initByProductBase:(ProductBase*)productBase;
@end
