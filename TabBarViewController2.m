//
//  TabBarViewController2.m
//  UITest3
//
//  Created by chen loman on 12-11-10.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "TabBarViewController2.h"

@interface TabBarViewController2 ()

@end

@implementation TabBarViewController2

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
    self.view.frame = self.parentViewController.view.frame;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
