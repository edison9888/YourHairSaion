//
//  SearchPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "SearchPagePolicy.h"

@implementation SearchPagePolicy
- (NSString*)title
{
    return @"搜索结果";
}

- (void)setFilter
{
    [[DataAdapter shareInstance]setSearchKey:self.subType];
    [[DataAdapter shareInstance]setFilterByTypeId:STRING_FOR_SEARCH_FILTER];
}

@end
