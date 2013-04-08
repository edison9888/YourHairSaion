//
//  PsDetailViewControllerBase.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-30.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDetailViewControllerBase.h"

#import "DataAdapter.h"
#import "SyncOperationManager.h"
#import "TextInputPopViewController.h"
#import "SyncProgressViewController.h"
#import "SyncMainViewController.h"
#import "SyncPopUpViewController.h"
#import "RootViewController.h"
#import "L1Button.h"

@interface PsDetailViewControllerBase ()
@property (nonatomic, strong)UIImageView* ivBg;
//sync
@property (nonatomic, strong)SyncProgressViewController* syncProgressViewController;
@property (nonatomic, assign)BOOL isSyncing;
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
    self.view.backgroundColor = nil;
    if (self.ivBg == nil)
    {
        self.ivBg = [[UIImageView alloc]initWithFrame:self.view.bounds];
        self.ivBg.image = [UIImage imageNamed:@"paper_right.png"];
        self.ivBg.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self.view insertSubview:self.ivBg atIndex:0];
    self.ivBg.frame = self.view.bounds;
    self.isSyncing = NO;

    
    


	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isSyncing && [self.psViewController.rootViewController.syncManager isAuthoried])
    {
        [self onSync:self];
    }

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
    NSLog(@"%s", __FUNCTION__);

    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog(@"DetailFrame!!!x=%f, y=%f, w=%f, h=%f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
//}
//

- (void)onSync:(id)sender
{
    SyncOperationManager* syncManager = self.psViewController.rootViewController.syncManager;
    
    //    SyncMainViewController* vc = [[SyncMainViewController alloc]initWithNibName:@"SyncMainViewController" bundle:nil];
    SyncProgressViewController* vc = [[SyncProgressViewController alloc]initWithNibName:@"SyncProgressViewController" bundle:nil];
    syncManager.processerDelege = vc;
    syncManager.resultDelege = self;
    //UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //nav.view.frame = CGRectMake(0, 0, 800, 600);
    //nav.navigationBarHidden = YES;
    //PopUpViewController* pop = [[PopUpViewController alloc]initWithNavContentViewController:nav];
    SyncPopUpViewController* pop = [[SyncPopUpViewController alloc]initWithContentViewController:vc];
    pop.popUpDeleage = self;
    //[pop show:self.psViewController.rootViewController.view andAnimated:YES];
    //    [self.psViewController.rootViewController.view addSubview:vc.view];
    //    vc.view.frame =  CGRectMake(0, 0, 800, 600);
    self.isSyncing = NO;
    if ([syncManager isAuthoried])
    {
        [syncManager doUpdate:sender];
        [pop show:self.psViewController.rootViewController.view andAnimated:YES];
    }
    else
    {
        [syncManager doAuthorizeInViewController:self];
        self.isSyncing = YES;
    }
    
}

- (void)viewDidHide:(id)vc
{
    [self.psViewController.rootViewController goHome];
    
}

- (void)onSwitchEmp:(id)sender
{
    [self.psViewController.rootViewController.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)syncSuccess:(SyncOperationManager *)manager
{
    [self.psViewController.rootViewController resetDataAfterSync];
}


@end
