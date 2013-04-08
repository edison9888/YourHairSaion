//
//  TextInputPopViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "TextInputPopViewController.h"
#import "SearchPagePolicy.h"
#import "RootViewController.h"
#import "L1Button.h"
#import "L2Button.h"
#import "L1RightButton.h"

@interface TextInputPopViewController ()

@end

@implementation TextInputPopViewController
@synthesize rvc, pc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    [pc dismissPopoverAnimated:YES];
    [self onDone:textField.text];
    textField.text = @"";
    return YES;
}

- (void)onDone:(NSString *)inputText
{
    if (rvc && ![@"" isEqualToString:inputText])
    {
        [rvc setPagePolicy:[[SearchPagePolicy alloc] initWithSubType:inputText]];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L1Button class]])
            {
                [((L1Button*)view) setOnTouch:NO];
            }
            if ([view isKindOfClass:[L2Button class]])
            {
                [((L2Button*)view) setHidden:YES];
            }
            if ([view isKindOfClass:[L1RightButton class]])
            {
                [self.rvc.view putSubview:view aboveSubview:self.rvc.ivRight];
            }
        }
    }
}
@end
