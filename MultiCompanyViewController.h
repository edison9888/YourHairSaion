//
//  MultiCompanyViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-3-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpViewController.h"
#import "iCarousel.h"
#import "SyncOperationManager.h"

@interface MultiCompanyViewController : UIViewController<PopUpViewControllerDeleage, iCarouselDataSource, iCarouselDelegate, SyncResultDeleage>

@property (nonatomic, retain) IBOutlet iCarousel *carousel;


@end
