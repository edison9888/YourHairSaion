//
//  SyncProgressViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "PopUpSubViewController.h"
#include "SyncOperationManager.h"


@interface SyncProgressViewController : PopUpSubViewController<SyncOperationDeleage>
{
    IBOutlet UIActivityIndicatorView    *_activity;
    IBOutlet UIProgressView             *_progress;
    IBOutlet UILabel                    *_state;
    IBOutlet UIImageView                *_ivStateImage;
    IBOutlet UIImageView                *_ivStateNote;
    IBOutlet UIButton                   *_btnCancel;

    
}
@property (nonatomic, strong)SyncOperationManager* syncManager;

- (void)start;
- (void)finish;
- (void)fail;
- (void)setProgress:(CGFloat)progress;
- (CGFloat)progress;
- (IBAction)onCancelSync:(id)sender;

@end
