//
//  L1MapButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-23.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L1MapButton.h"
#import "RootViewController.h"
#import "L2Button.h"

@implementation L1MapButton

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

- (L1MapButton*)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    
    self = [super initAll:frame andVcType:enumVcType andSubType:subType andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    if (self)
    {
        if (nil == subType || [@"" isEqualToString:subType])
        {
            self.subType = MAP_SUBTYPE_LIST;
        }
        if (ViewControllerMap == enumVcType)
        {
            self.L2Btns = [[NSMutableArray alloc]init];
            L2Button *btnL2One = [[L2Button alloc]initAll:CGRectMake(FRAME_L2LSide_Btn_First_X, FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andVcType:ViewControllerMap andSubType:MAP_SUBTYPE_MAP andTitle:@"地图" andStyle:nil andImgName:@"defaultL2Btn.png" andRvc:self.rvc];
                [btnL2One setHidden:YES];
                [self.L2Btns addObject:btnL2One];
                [rvc.view addSubview:btnL2One];
            
            L2Button *btnL2Two = [[L2Button alloc]initAll:CGRectMake((FRAME_L2LSide_Btn_First_X+FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin), FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andVcType:ViewControllerMap andSubType:MAP_SUBTYPE_LIST andTitle:@"列表" andStyle:nil andImgName:@"defaultL2Btn.png" andRvc:self.rvc];
            [btnL2Two setHidden:YES];
            [self.L2Btns addObject:btnL2Two];
            [rvc.view addSubview:btnL2Two];

            
        }
    }
    return self;
}



- (void)onTouchUp:(id)sender
{
    if (self.vcType != [self.rvc currentVCType])
    {
        [self.rvc setVcType:self.vcType andSubType:self.subType];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L1Button class]])
            {
                [self.rvc.view sendSubviewToBack:view];
            }
            if ([view isKindOfClass:[L2Button class]])
            {
                [view setHidden:YES];
            }
        }
        [self.rvc.view bringSubviewToFront:self];
        for (L2Button* l2Btn in self.L2Btns)
        {
            [l2Btn setHidden:NO];
        }
    }
}


@end
