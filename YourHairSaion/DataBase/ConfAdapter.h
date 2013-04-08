//
//  ConfAdapter.h
//  YourHairSaion
//
//  Created by chen loman on 13-2-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>


//for system configure
#define CONF_KEY_SHOW_DISCOUNT_CARD @"showDiscountCard"
#define CONF_VALUE_YES @"1"
#define CONF_VALUE_NO @"0"
#define CONF_KEY_SHOW_SUBBRANCH @"showSubbranch"


@interface ConfAdapter : NSObject

@property (nonatomic, strong)NSMutableDictionary *confData;
+ (ConfAdapter*)shareInstance;
- (BOOL)initData;


- (NSString*)getConf:(NSString*)key;
- (BOOL)isShowDiscountCard;
- (BOOL)isShowSubbranch;

- (void)setConfForKey:(NSString*)key withValue:(NSString*)value;
- (void)setShowDiscountCard:(BOOL)value;
- (void)setShowSubBranch:(BOOL)value;
@end
