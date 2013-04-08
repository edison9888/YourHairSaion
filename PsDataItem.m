//
//  PsDataItem.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDataItem.h"
#import "LifeBarDataProvider.h"

@implementation PsDataItem
@synthesize name, imgDic, key, imgLinkDic;

- (BOOL)isShowCaption
{
    return YES;
}

//- (void)setImgDic:(NSArray *)productPics
//{
//    if (nil != productPics && [productPics count] > 0)
//    {
//        DataAdapter* da = [DataAdapter shareInstance];
//        imgDic = [NSMutableDictionary dictionaryWithCapacity:[productPics count]];
//        for (ProductPic* pic in productPics)
//        {
//            [imgDic setObject:[da getLocalPath:pic.picLink] forKey:pic.picType];
//        }
//        NSString* imglink = [imgDic objectForKey:PRODUCT_PIC_TYPE_DEFAULT];
////        [imgDic setObject:[da getLocalPath:@"34.JPG"] forKey:PRODUCT_PIC_TYPE_LEFT];
////        [imgDic setObject:[da getLocalPath:@"45.JPG"] forKey:PRODUCT_PIC_TYPE_RIGHT];
////        [imgDic setObject:[da getLocalPath:@"41.JPG"] forKey:PRODUCT_PIC_TYPE_BACK];
//
//
//    }
//    else
//    {
//        imgDic = [NSMutableDictionary dictionary];
//    }
//}

- (void)setImgDicWithDic:(NSMutableDictionary*)dic
{
    self.imgDic = dic;
}

- (UIImage*)defaultImgLink
{
    return [self.imgLinkDic objectForKey:[NSNumber numberWithInteger:LB_PRODUCT_PIC_TYPE_DEFAULT]];
}

- (void)setDefalutImgLink:(NSString *)imgLink
{
//    if (nil == imgDic)
//    {
//        imgDic = [NSMutableDictionary dictionaryWithObject:imgLink forKey:[NSNumber numberWithInteger:LB_PRODUCT_PIC_TYPE_DEFAULT]];
//    }
//    else
//    {
//        //self.imgDic = [NSMutableDictionary dictionaryWithDictionary:self.imgDic];
//        [imgDic setObject:imgLink forKey:[NSNumber numberWithInteger:LB_PRODUCT_PIC_TYPE_DEFAULT]];
//    }
    if (nil == imgLinkDic)
    {
        imgLinkDic = [NSMutableDictionary dictionaryWithObject:imgLink forKey:[NSNumber numberWithInteger:LB_PRODUCT_PIC_TYPE_DEFAULT]];

    }
    else
    {
        [imgLinkDic setObject:imgLink forKey:[NSNumber numberWithInteger:LB_PRODUCT_PIC_TYPE_DEFAULT]];
    }
}

- (void)setImgLink:(NSString *)imgLink withType:(NSInteger)typeId
{
    if (nil == imgLinkDic)
    {
        imgLinkDic = [NSMutableDictionary dictionaryWithObject:imgLink forKey:[NSNumber numberWithInteger:typeId]];
        
    }
    else
    {
        [imgLinkDic setObject:imgLink forKey:[NSNumber numberWithInteger:typeId]];
    }
}

- (NSInteger)imageCount
{
    return [imgLinkDic count];
}

- (UIImage*)imageAtIndex:(NSInteger)index
{
    return [imgDic allValues][index];
}

- (NSString*)imageLinkAtIndex:(NSInteger)index
{
    return [imgLinkDic allValues][index];
}

- (void)setImgLinkDic:(NSArray *)productPics
{
    if (nil != productPics && [productPics count] > 0)
    {
        imgLinkDic = [NSMutableDictionary dictionaryWithCapacity:[productPics count]];
        for (ProductPic* pic in productPics)
        {
            [imgLinkDic setObject:pic.picLink forKey:pic.picType];
        }
        //        [imgDic setObject:[da getLocalPath:@"34.JPG"] forKey:PRODUCT_PIC_TYPE_LEFT];
        //        [imgDic setObject:[da getLocalPath:@"45.JPG"] forKey:PRODUCT_PIC_TYPE_RIGHT];
        //        [imgDic setObject:[da getLocalPath:@"41.JPG"] forKey:PRODUCT_PIC_TYPE_BACK];
        
        
    }
    else
    {
        imgLinkDic = [NSMutableDictionary dictionary];
    }

}

@end
