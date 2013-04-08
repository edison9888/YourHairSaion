//
//  OperationNode.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-3.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "OperationNode.h"

@implementation OperationNode

- (OperationNode*)initWithPagePolicy:(BasePagePolicy *)pagePolicy andPageIndex:(int)index
{
    self = [super init];
    if (self)
    {
        self.idTag = index;
        self.pagePolicy = pagePolicy;
    }
    return self;
}
@end
