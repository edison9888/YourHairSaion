//
//  ClearConfirmViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-2-17.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "PopUpSubViewController.h"
@class RootViewController;

@interface ClearConfirmViewController : PopUpSubViewController
{
    IBOutlet UIActivityIndicatorView    *_activity;
    IBOutlet UIProgressView             *_progress;
    IBOutlet UILabel                    *_state;
    IBOutlet UIImageView                *_ivStateImage;
    IBOutlet UIImageView                *_ivStateNote;
    IBOutlet UIButton                   *_btnCancel;
    
    
}
@property (nonatomic, strong)RootViewController* rootViewController;

- (void)start;
- (void)finish;
- (void)fail;
- (void)setProgress:(CGFloat)progress;
- (CGFloat)progress;
- (IBAction)onCancelClear:(id)sender;
@end
