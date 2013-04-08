//
//  UpdateHistory.h
//  YourHairSaion
//
//  Created by chen loman on 13-2-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UpdateHistory : NSManagedObject

@property (nonatomic, retain) NSString * serialNo;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * server;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * reverse;

@end
