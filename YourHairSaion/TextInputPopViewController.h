//
//  TextInputPopViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;
@interface TextInputPopViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong)IBOutlet UITextField* textField;
@property (strong, nonatomic)RootViewController* rvc;
@property (nonatomic, strong)UIPopoverController* pc;

- (void)onDone:(NSString*)inputText;

@end
