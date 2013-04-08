//
//  LCFileManager.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-5.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "LCFileManager.h"

@implementation LCFileManager
@synthesize fileManager;


+ (LCFileManager*)shareInstance;
{
    static dispatch_once_t pred;
    static LCFileManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[LCFileManager alloc] init];
        
    });
    
    return shared;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.fileManager = [NSFileManager defaultManager];
        return self;
    }
    return nil;
}


- (BOOL)moveFile:(NSString*)localFilePath toDestPath:(NSString*)destFilePath overWrite:(BOOL)overWrite error:(NSError**)error;
{
    if (![self checkSourPath:localFilePath error:error] || ![self checkDestPath:destFilePath overWrite:overWrite error:error ])
    {
        NSLog(@"moveFile error:%@", [*error localizedDescription]);
        return NO;
    }
    else
    {
        //若文件存在，
        if ([fileManager fileExistsAtPath:destFilePath])
        {
            //且需要重写
            if (overWrite)
            {
                if (![fileManager removeItemAtPath:destFilePath error:error])
                {
                    return NO;
                }
            }
            else
            {
                return YES;
            }
        }
        
        if (![self.fileManager moveItemAtPath:localFilePath toPath:destFilePath error:error])
        {
            NSLog(@"moveFile error:%@", [*error localizedDescription]);
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)copyFile:(NSString*)localFilePath toDestPath:(NSString*)destFilePath overWrite:(BOOL)overWrite error:(NSError**)error;
{
    if (![self checkSourPath:localFilePath error:error] || ![self checkDestPath:destFilePath overWrite:overWrite error:error ])
    {
        NSLog(@"copy File error:%@", [*error localizedDescription]);
        return NO;
    }
    else
    {
        //若文件存在，
        if ([fileManager fileExistsAtPath:destFilePath])
        {
            //且需要重写
            if (overWrite)
            {
                if (![fileManager removeItemAtPath:destFilePath error:error])
                {
                    return NO;
                }
            }
            else
            {
                return YES;
            }
        }
        
        if (![self.fileManager copyItemAtPath:localFilePath toPath:destFilePath error:error])
        {
            NSLog(@"copyFile error:%@", [*error localizedDescription]);
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)checkSourPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    if (nil == path || [@"" isEqualToString:path])
    {
        if (NULL != error)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Parameter is nil or empty!"                                                                      forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc]initWithDomain:LCErrorDomain code:LCERROR_FILE_PARA_ERROR userInfo:userInfo];
        }
        return NO;
    }
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDirectory] || YES == isDirectory)
    {
        if (NULL != error)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"No such file or it's a directory with path:%@", path] forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc]initWithDomain:LCErrorDomain code:NSFileNoSuchFileError userInfo:userInfo];
        }
        return NO;
    }
    if (![fileManager isReadableFileAtPath:path])
    {
        if (NULL != error)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Unreadable file with path:%@", path]                                                                      forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code:NSFileReadNoPermissionError userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}
- (BOOL)checkDestPath:(NSString *)path overWrite:(BOOL)overWrite error:(NSError *__autoreleasing *)error
{
    if (nil == path || [@"" isEqualToString:path])
    {
        if (NULL != error)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Parameter is nil or empty!"                                                                      forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc]initWithDomain:LCErrorDomain code:LCERROR_FILE_PARA_ERROR userInfo:userInfo];
        }
        return NO;
    }
    BOOL isDirectory = NO;
    //若目标文件存在，则检查是否可写
    if ([fileManager fileExistsAtPath:path])
    {
        if (overWrite && ![fileManager isWritableFileAtPath:path])
        {
            if (NULL != error)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Unwritable file with path:%@", path]                                                                      forKey:NSLocalizedDescriptionKey];
                *error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code:NSFileWriteNoPermissionError userInfo:userInfo];
            }
            return NO;
        }
    }
    else //file not exist, check the dir if it's writable
    {
        NSString* dir = [path stringByDeletingLastPathComponent];
        if ([fileManager fileExistsAtPath:dir isDirectory:&isDirectory] && YES == isDirectory && [fileManager isWritableFileAtPath:dir])
        {
            
        }
        else
        {
            if (NULL != error)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Unwritable with path:%@ or directory not exist", path]                                                                      forKey:NSLocalizedDescriptionKey];
                *error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code:NSFileWriteNoPermissionError userInfo:userInfo];
            }
            return NO;
        }
    }
    
    return YES;
}
@end
