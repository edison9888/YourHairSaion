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
#import "ListMapPagePolicy.h"
#import "MapPagePolicy.h"
#import "L1Button.h"
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

- (L1MapButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy *)pagePolicy andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    
    self = [super initAll:frame andPagePolicy:pagePolicy andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    [self setVerticalTitle:title];
    if (self)
    {
//        self.L2Btns = [[NSMutableArray alloc]init];
//        L2Button *btnL2One = [[L2Button alloc]initAll:CGRectMake(FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*2, FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andPagePolicy:[[MapPagePolicy alloc]initWithSubType:@""] andTitle:@"地图" andStyle:MyUIButtonStyleTop andImgName:@"ll2Btn1.png" andRvc:self.rvc];
//        [btnL2One setHidden:YES];
//        [self.L2Btns addObject:btnL2One];
//        [rvc.view addSubview:btnL2One];
//        
//        L2Button *btnL2Two = [[L2Button alloc]initAll:CGRectMake((FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*3), FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andPagePolicy:[[ListMapPagePolicy alloc]initWithSubType:@""] andTitle:@"列表" andStyle:MyUIButtonStyleTop andImgName:@"ll2Btn2.png" andRvc:self.rvc];
//        [btnL2Two setHidden:YES];
//        [self.L2Btns addObject:btnL2Two];
//        [rvc.view addSubview:btnL2Two];
        
        
    }
    return self;
}



- (void)onTouchUp:(id)sender
{
    [super onTouchUp:sender];
    if (![[self.rvc pagePolicy] isKindOfClass:[MapPagePolicy class]] && ![[self.rvc pagePolicy] isKindOfClass:[ListMapPagePolicy class]])
    {
        [self.rvc setPagePolicy:self.pagePolicy];
//        for (UIView* view in self.rvc.view.subviews)
//        {
//            if ([view isKindOfClass:[L1Button class]])
//            {
//                [self.rvc.view sendSubviewToBack:view];
//            }
//            if ([view isKindOfClass:[L2Button class]])
//            {
//                [view setHidden:YES];
//            }
//        }
        [self.rvc.view bringSubviewToFront:self];
    }
}


@end
