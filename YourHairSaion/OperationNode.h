//
//  OperationNode.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-3.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePagePolicy.h"

@interface OperationNode : NSObject
@property (nonatomic, strong)BasePagePolicy* pagePolicy;
@property (nonatomic, assign)int pageIndex;
@property (nonatomic, assign)int idTag;


- (OperationNode*)initWithPagePolicy:(BasePagePolicy*)pagePolicy andPageIndex:(int)index;
@end
