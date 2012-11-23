//
//  OrgMapViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-18.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "OrgMapViewController.h"

@interface OrgMapViewController ()

@end

@implementation OrgMapViewController

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
    MapViewController* mvc = [[MapViewController alloc]init];
    self.view.frame = CGRectMake(0, 0, 20, 20);
    [self.view sizeToFit];
    [self.view addSubview:mvc.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
