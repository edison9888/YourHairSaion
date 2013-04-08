//
//  SyncPopUpViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "SyncPopUpViewController.h"
#import "PopUpSubViewController.h"
#import "SyncProgressViewController.h"

@interface SyncPopUpViewController ()

@end

@implementation SyncPopUpViewController

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
    SyncProgressViewController* subVc = self.subViewController;
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
