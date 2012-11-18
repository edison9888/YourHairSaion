//
//  MyToolBar.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyToolBar.h"

@interface MyToolBar()
{
    enumViewControllerType vcType;
}
@property (nonatomic, strong) NSString* subType;
@property (nonatomic, strong) UIBarButtonItem* defaultBtn;
@property (nonatomic, strong) RootViewController* rvc;

- (void)onToolBar:(id)sender;
@end
@implementation MyToolBar
@synthesize subType, defaultBtn, rvc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
            self.opaque = NO;
            self.backgroundColor = [UIColor clearColor];
            self.clearsContextBeforeDrawing = YES;
        vcType = ViewControllerProduct;
        self.subType = nil;
    }
    return self;
}

- (id)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    self = [self initWithFrame:frame];
    if (self)
    {
        vcType = enumVcType;
        self.subType = subType;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imgName]];
        //self.defaultBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imgName] style:UIBarButtonItemStylePlain target:self action:@selector(onToolBar:)];
        self.defaultBtn = [[UIBarButtonItem alloc]initWithTitle:@"男士发行" style:UIBarButtonItemStylePlain target:self action:@selector(onToolBar:)];
        [self.defaultBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIFont fontWithName:@"AmericanTypewriter" size:20.0f], UITextAttributeFont,
                                                 [UIColor blackColor], UITextAttributeTextColor,
                                                 [UIColor grayColor], UITextAttributeTextShadowColor,
                                                 [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                                 nil] forState:UIControlStateNormal];
        self.items = @[self.defaultBtn];
        self.rvc = rvc;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
}

- (void)onToolBar:(id)sender
{
    [rvc setVcType:vcType andSubType:self.subType];
}


@end
