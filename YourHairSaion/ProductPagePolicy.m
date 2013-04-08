//
//  ProductPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductPagePolicy.h"
#import "PsViewController.h"
#import "PsDetailViewController.h"

@implementation ProductPagePolicy

- (void)loadData:(PsViewController *)pvc
{
    [pvc setPageCount:[self calcPageCount]];
}

//- (UIViewController*)createRightVC
//{
//    return [[PsDetailViewController alloc]init];
//}

@end
