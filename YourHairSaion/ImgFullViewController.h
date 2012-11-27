//
//  ImgFullViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-21.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductShowingDetail;
@interface ImgFullViewController : UIViewController <UIScrollViewDelegate>


@property (nonatomic, strong)IBOutlet UIScrollView* mainScrollView;
@property (nonatomic, assign)NSInteger lastPage;

- (ImgFullViewController*)initWithObject:(ProductShowingDetail*)psd;
- (void)setData:(ProductShowingDetail*)psd;
@end
