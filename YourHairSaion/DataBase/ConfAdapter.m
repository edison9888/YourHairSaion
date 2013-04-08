//
//  ConfAdapter.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//



#import "ConfAdapter.h"
#import "DBManager.h"

@implementation ConfAdapter
+ (ConfAdapter*)shareInstance;
{
    static dispatch_once_t pred;
    static ConfAdapter *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ConfAdapter alloc] init];
        
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

- (BOOL)initData
{
    NSArray* array = [[DBManager shareInstance]getAll:@"SysConf"];
    _confData = [NSMutableDictionary dictionaryWithCapacity:[array count]];
    for (SysConf* conf in array)
    {
        [_confData setObject:conf.value forKey:conf.key];
    }
    return YES;
}


- (NSString*)getConf:(NSString *)key
{
    return [_confData objectForKey:key];
}

- (BOOL)boolValue:(NSString*)value
{
    return [value isEqualToString:CONF_VALUE_YES];
}

- (BOOL)isShowDiscountCard
{
    return [self boolValue:[self getConf:CONF_KEY_SHOW_DISCOUNT_CARD]];
}

- (BOOL)isShowSubbranch
{
    return [self boolValue:[self getConf:CONF_KEY_SHOW_SUBBRANCH]];
}


- (void)setConfForKey:(NSString *)key withValue:(NSString *)value
{
    [[DBManager shareInstance] updateNewConfForKey:key andValue:value];
    [_confData setObject:value forKey:key];
}
- (NSString*)valueWithBool:(BOOL)value
{
    if (value)
    {
        return CONF_VALUE_YES;
    }
    return CONF_VALUE_NO;
}

- (void)setShowDiscountCard:(BOOL)value
{
    [self setConfForKey:CONF_KEY_SHOW_DISCOUNT_CARD withValue:[self valueWithBool:value]];
}

- (void)setShowSubBranch:(BOOL)value
{
    [self setConfForKey:CONF_KEY_SHOW_SUBBRANCH withValue:[self valueWithBool:value]];
}
@end
