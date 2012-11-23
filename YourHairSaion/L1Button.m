//
//  L1Button.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L1Button.h"
#import "RootViewController.h"
#import "L2Button.h"

#define FRAME_L2LSide_Btn_W 30
#define FRAME_L2LSide_Btn_H 79
#define FRAME_L2LSide_Btn_First_X 250
#define FRAME_L2LSide_Btn_Frist_Y 18

#define FRAME_L2Btn_Margin 10

#define FRAME_L2RSide_Btn_W 60
#define FRAME_L2RSide_Btn_H 110
#define FRAME_L2RSide_Btn_First_X 1024 - 77
#define FRAME_L2RSide_Btn_Frist_Y 179

@interface L1Button()
@property (nonatomic, strong)NSMutableArray* L2Btns;
@end

@implementation L1Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    self = [super initAll:frame andVcType:enumVcType andSubType:subType andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    if (self)
    {
        if (ViewControllerProduct == enumVcType)
        {
            DataAdapter* da = [DataAdapter shareInstance];
            NSArray* rootProductType = [da productTypeForParent:subType];
            self.L2Btns = [[NSMutableArray alloc]init];
            int counter = 0;
            for (ProductType* type in rootProductType)
            {
                L2Button *btnL2 = [[L2Button alloc]initAll:CGRectMake((FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*counter++), FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andVcType:ViewControllerProduct andSubType:type.productType andTitle:type.typeName andStyle:nil andImgName:@"defaultL2Btn.png" andRvc:self.rvc];
                [btnL2 setHidden:YES];
                [self.L2Btns addObject:btnL2];
                [rvc.view addSubview:btnL2];
            }
        }
    }
    return self;
}


- (void)onTouchUp:(id)sender
{
    [self.rvc setVcType:self.vcType andSubType:self.subType];
    for (UIView* view in self.rvc.view.subviews)
    {
        if ([view isKindOfClass:[L1Button class]])
        {
            [self.rvc.view sendSubviewToBack:view];
            //self.titleLabel.textColor = [UIColor whiteColor];
            
        }
        if ([view isKindOfClass:[L2Button class]])
        {
            [view setHidden:YES];
            //self.titleLabel.textColor = [UIColor whiteColor];
            
        }
    }
    [self.rvc.view bringSubviewToFront:self];
    //self.titleLabel.textColor = [UIColor blackColor];
    //self.tintColor = [UIColor blackColor];
    for (L2Button* l2Btn in self.L2Btns)
    {
        [l2Btn setHidden:NO];
    }
}

@end
