//
//  MyTabBarController.m
//  UITest3
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

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
    self.contentSizeForViewInPopover = CGSizeMake(400, 1004);
	// Do any additional setup after loading the view.
    UIImage *bg = [UIImage imageNamed:@"background.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    for (UIViewController* sub in self.viewControllers)
    {
        sub.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideExistingTabBar
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self hideExistingTabBar];
    [self addCustomElements];
    self.hidesBottomBarWhenPushed = YES;
    [self.view setFrame:CGRectMake(0, 0, 512, 808)];
}

- (void)addCustomElements
{
    UIImage *btnImg = [UIImage imageNamed:@"back.png"];
    UIImage *btnImgSel = [UIImage imageNamed:@"close.png"];
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 50, 100);
    [btn1 setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn1 setBackgroundImage:btnImgSel forState:UIControlStateSelected];
    [btn1 setTag:0];
    [btn1 setSelected:YES];
    
    btnImg = [UIImage imageNamed:@"download.png"];
    btnImgSel = [UIImage imageNamed:@"forward.png"];
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 80, 50, 100);
    [btn2 setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn2 setBackgroundImage:btnImgSel forState:UIControlStateSelected];
    [btn2 setTag:1];
    
    btnImg = [UIImage imageNamed:@"info.png"];
    btnImgSel = [UIImage imageNamed:@"messages.png"];
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 160, 50, 100);
    [btn3 setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn3 setBackgroundImage:btnImgSel forState:UIControlStateSelected];
    [btn3 setTag:2];

    
    btnImg = [UIImage imageNamed:@"ok.png"];
    btnImgSel = [UIImage imageNamed:@"search.png"];
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, 240, 50, 100);
    [btn4 setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn4 setBackgroundImage:btnImgSel forState:UIControlStateSelected];
    [btn4 setTag:3];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
    [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selectTab:(int)tab
{
    switch (tab) {
        case 0:
            [btn1 setSelected:YES];
            [btn2 setSelected:NO];
            [btn3 setSelected:NO];
            [btn4 setSelected:NO];
            
            break;
        case 1:
            [btn1 setSelected:NO];
            [btn2 setSelected:YES];
            [btn3 setSelected:NO];
            [btn4 setSelected:NO];
            break;
        case 2:
            [btn1 setSelected:NO];
            [btn2 setSelected:NO];
            [btn3 setSelected:YES];
            [btn4 setSelected:NO];
            break;
        case 3:
            [btn1 setSelected:NO];
            [btn2 setSelected:NO];
            [btn3 setSelected:NO];
            [btn4 setSelected:YES];
            break;
        default:
            break;
    }

    self.selectedIndex = tab;
}

- (void)buttonClicked:(id)sender
{
    int tab = [sender tag];
    [self selectTab:tab];
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(400, 1004);
}
@end
