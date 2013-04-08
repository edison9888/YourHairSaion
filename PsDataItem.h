//
//  PsDataItem.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PsDataItem : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableDictionary* imgDic;
@property (nonatomic, copy) NSMutableDictionary* imgLinkDic;

@property (nonatomic, strong) NSString* key;


- (BOOL)isShowCaption;
- (void)setImgDic:(NSArray*) productPics;
- (UIImage*)defaultImgLink;
- (void)setDefalutImgLink:(NSString*)imgLink;
- (NSInteger)imageCount;
- (UIImage*)imageAtIndex:(NSInteger)index;
- (void)setImgDicWithDic:(NSMutableDictionary*)dic;
- (NSString*)imageLinkAtIndex:(NSInteger)index;
- (void)setImgLinkDic:(NSArray*) productPics;
- (void)setImgLink:(NSString *)imgLink withType:(NSInteger)typeId;

@end
