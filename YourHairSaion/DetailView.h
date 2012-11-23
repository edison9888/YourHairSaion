//
//  DetailViewCell.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"
@class DetailViewController;
@interface DetailView : UIScrollView
@property (nonatomic, strong)DetailViewController* detailViewController;
- (void)fillData:(ProductShowingDetail*)psd;

@end
