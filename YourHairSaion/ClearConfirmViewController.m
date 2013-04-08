//
//  ClearConfirmViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-17.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "ClearConfirmViewController.h"
#import "DataAdapter.h"
#import "L1Button.h"
#import "RootViewController.h"
@interface ClearConfirmViewController ()
@property (nonatomic, strong)UIImage* imageFailIcon;
@property (nonatomic, strong)UIImage* imageSuccIcon;
@property (nonatomic, strong)UIImage* imageFailNote;
@property (nonatomic, strong)UIImage* imageSuccNote;
@property (nonatomic, strong)UIImage* imageOngoing;

@end

@implementation ClearConfirmViewController
@synthesize rootViewController;

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
    self.imageFailIcon = [UIImage imageNamed:@"fail_icon.png"];
    self.imageFailNote = [UIImage imageNamed:@"clear_fail.png"];
    self.imageSuccIcon = [UIImage imageNamed:@"success_icon.png"];
    self.imageSuccNote = [UIImage imageNamed:@"clear_success.png"];
    self.imageOngoing = [UIImage imageNamed:@"clear_text.png"];
    _progress.progressTintColor = COLOR_ORANGE;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)start
{
    [_activity setHidden:NO];
    [_activity startAnimating];
    _progress.progress = 0.5f;
    [_state setHidden:YES];
    _state.text = @"正在清除顾客信息...";
    _state.textColor = [UIColor blackColor];
    [_ivStateImage setHidden:YES];
    [_ivStateNote setHidden:NO];
    _ivStateNote.image = self.imageOngoing;
    //[self performSelectorInBackground:@selector(simulate) withObject:nil];
    [self performSelector:@selector(finish) withObject:nil afterDelay:0.5];
    
        
}

- (void)finish
{
    
    [_activity stopAnimating];
    _progress.progress = 1.0f;
    _state.text = @"同步数据成功！";
    _state.textColor = [UIColor greenColor];
    [_state setHidden:YES];
    [_activity setHidden:YES];
    [_ivStateImage setHidden:NO];
    _ivStateImage.image = self.imageSuccIcon;
    _ivStateNote.image = self.imageSuccNote;
    
    
}

- (void)fail
{
    [_activity stopAnimating];
    _progress.progress = 1.0f;
    [_state setHidden:YES];
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


- (void)onCancelClear:(id)sender
{
    [self onCancel:sender];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self start];
    
}

@end
