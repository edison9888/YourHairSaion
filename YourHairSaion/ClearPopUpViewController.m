//
//  ClearPopUpViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-17.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "ClearPopUpViewController.h"
#import "ClearConfirmViewController.h"
#import "L1Button.h"
#import "RootViewController.h"


@interface ClearPopUpViewController ()

@end

@implementation ClearPopUpViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)hide:(BOOL)animated
{
    ClearConfirmViewController* subVc = self.subViewController;
    if ([subVc progress] >= 1.0f)
    {
        [super hide:animated];
    }
    else
    {
        //do nothing
    }
    
}


@end
