//
//  SyncProgressViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-10.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "SyncProgressViewController.h"
#import "DataAdapter.h"

@interface SyncProgressViewController ()
@property (nonatomic, strong)UIImage* imageFailIcon;
@property (nonatomic, strong)UIImage* imageSuccIcon;
@property (nonatomic, strong)UIImage* imageFailNote;
@property (nonatomic, strong)UIImage* imageSuccNote;
@property (nonatomic, strong)UIImage* imageOngoing;



@end

@implementation SyncProgressViewController
@synthesize syncManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        syncManager = [SyncOperationManager shareInstance];
        syncManager.processerDelege = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageFailIcon = [UIImage imageNamed:@"fail_icon.png"];
    self.imageFailNote = [UIImage imageNamed:@"upload_fail.png"];
    self.imageSuccIcon = [UIImage imageNamed:@"success_icon.png"];
    self.imageSuccNote = [UIImage imageNamed:@"upload_success.png"];
    self.imageOngoing = [UIImage imageNamed:@"upload_text_.png"];
    _progress.progressTintColor = COLOR_ORANGE;
    
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
        [self.syncManager doUpdate:self];
    }
    else {
        NSLog(@"还没有登录。。。。");
        [self.syncManager doAuthorizeInViewController:self];
    }
}

- (void)start
{
    [_activity setHidden:NO];
    [_activity startAnimating];
    _progress.progress = 0.0f;
    _state.text = @"正在同步数据，请耐心等待...";
    _state.textColor = [UIColor blackColor];
    [_ivStateImage setHidden:YES];
    _ivStateNote.image = self.imageOngoing;
    
}

- (void)finish
{
    [_activity stopAnimating];
    _progress.progress = 1.0f;
    _state.text = @"同步数据成功！";
    _state.textColor = [UIColor greenColor];
    [_activity setHidden:YES];
    [_ivStateImage setHidden:NO];
    _ivStateImage.image = self.imageSuccIcon;
    _ivStateNote.image = self.imageSuccNote;
}

- (void)fail
{
    [_activity stopAnimating];
    _progress.progress = 1.0f;
    _state.text = @"同步数据失败！";
    _state.textColor = [UIColor redColor];
    [_activity setHidden:YES];
    [_ivStateImage setHidden:NO];
    _ivStateImage.image = self.imageFailIcon;
    _ivStateNote.image = self.imageFailNote;
}


- (void)setProgress:(CGFloat)progress
{
    _progress.progress = progress;
}

- (CGFloat)progress
{
    return _progress.progress;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)syncBegin:(SyncOperationManager*)manager
{
    [self start];
    
}
- (void)syncSuccess:(SyncOperationManager*)manager
{
    [self finish];
}
- (void)syncFail:(SyncOperationManager*)manager
{
    [self fail];
}
- (void)syncProgressUpdate:(SyncOperationManager*)manager andProgress:(CGFloat)progress
{
    [self setProgress:progress];
}


- (void)onCancelSync:(id)sender
{
    [self.syncManager cancel];
    [self onCancel:sender];
}
@end
