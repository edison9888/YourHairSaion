//
//  DetailViewCell.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"

@interface DetailView : UIScrollView
- (void)fillData:(ProductShowingDetail*)psd;
@end
