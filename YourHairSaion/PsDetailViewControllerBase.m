//
//  PsDetailViewControllerBase.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-30.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDetailViewControllerBase.h"

@interface PsDetailViewControllerBase ()

@end

@implementation PsDetailViewControllerBase

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

- (void)setItem:(PsDataItem *)dataItem {
    _item = dataItem;
}


- (NSUInteger)indexInPage
{
    return [self.psViewController indexInPage] + 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end
