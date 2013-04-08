//
//  SyncMainViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "SyncMainViewController.h"

@interface SyncMainViewController ()

@end

@implementation SyncMainViewController
@synthesize progressViewController, syncManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //nav.navigationBarHidden = YES;
        syncManager = [SyncOperationManager shareInstance];
        syncManager.processerDelege = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.syncManager isAuthoried]) {
        NSLog(@"已经登录。。。。");
        //[self performSelectorInBackground:@selector(doSync) withObject:nil];
        [self.syncManager doSync:self];
    }
    else {
        NSLog(@"还没有登录。。。。");
        [self.syncManager doAuthorizeInViewController:self];
    }
}


- (void)syncBegin:(SyncOperationManager*)manager
{
    self.progressViewController = [[SyncProgressViewController alloc]initWithNibName:@"SyncProgressViewController" bundle:nil];
    
    PopUpViewController* pvc = [[PopUpViewController alloc]initWithContentViewController:self.progressViewController];
    [pvc show:self.view andAnimated:YES];
    //[self presentModalViewController:pvc animated:YES];
    [self.progressViewController start];
    
}
- (void)syncSuccess:(SyncOperationManager*)manager
{
    [self.progressViewController finish];
}
- (void)syncFail:(SyncOperationManager*)manager
{
    [self.progressViewController fail];
}
- (void)syncProgressUpdate:(SyncOperationManager*)manager andProgress:(CGFloat)progress
{
    [self.progressViewController setProgress:progress];
}

@end
