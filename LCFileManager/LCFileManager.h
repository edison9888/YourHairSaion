//
//  LCFileManager.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-5.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LCErrorDomain @"com.loman.app"

typedef enum
{
    LCERROR_FILE_PARA_ERROR
}enumLCError;



@interface LCFileManager : NSObject
@property (nonatomic, strong)NSFileManager* fileManager;



+ (LCFileManager*)shareInstance;

- (BOOL)moveFile:(NSString*)localFilePath toDestPath:(NSString*)destFilePath overWrite:(BOOL)overWrite error:(NSError**)error;
- (BOOL)copyFile:(NSString*)localFilePath toDestPath:(NSString*)destFilePath overWrite:(BOOL)overWrite error:(NSError**)error;
- (BOOL)checkSourPath:(NSString *)path error:(NSError *__autoreleasing *)error;
- (BOOL)checkDestPath:(NSString *)path overWrite:(BOOL)overWrite error:(NSError *__autoreleasing *)error;
@end
