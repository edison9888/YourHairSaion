//
//  SysConf.h
//  YourHairSaion
//
//  Created by chen loman on 13-2-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SysConf : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;

@end
