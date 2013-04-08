//
//  SyncMainViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyncOperationManager.h"
#import "PopUpViewController.h"
#import "SyncProgressViewController.h"
@interface SyncMainViewController : PopUpSubViewController<SyncOperationDeleage>

@property (nonatomic, strong)SyncOperationManager* syncManager;
@property (nonatomic, strong)SyncProgressViewController* progressViewController;
@end
