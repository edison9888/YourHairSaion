//
//  L1Button.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyUIButton.h"

#define FRAME_LSide_ToolBar_W 71
#define FRAME_LSide_ToolBar_H 27
#define FRAME_L1LSide_Btn_X 32
#define FRAME_LSide_ToolBar_First_X 20
#define FRAME_LSide_ToolBar_Frist_Y 100
#define FRAME_LSide_ToolBar_Margin 10
#define FRAME_RSide_ToolBar_W 34
#define FRAME_RSide_ToolBar_H 170
#define FRAME_RSide_ToolBar_First_X (SCREEN_W - FRAME_RSide_ToolBar_W -8)
#define FRAME_RSide_ToolBar_Frist_Y FRAME_LSide_ToolBar_Frist_Y
#define FRAME_RSide_ToolBar_Margin (-60)




#define FRAME_L2LSide_Btn_W 27
#define FRAME_L2LSide_Btn_H 71
#define FRAME_L2LSide_Btn_First_X 250
#define FRAME_L2LSide_Btn_Frist_Y 20

#define FRAME_L2Btn_Margin 5

#define FRAME_L2RSide_Btn_W FRAME_L2LSide_Btn_W
#define FRAME_L2RSide_Btn_H FRAME_L2LSide_Btn_H
#define FRAME_L2RSide_Btn_First_X (1024 - FRAME_L2LSide_Btn_First_X - FRAME_L2LSide_Btn_W)
#define FRAME_L2RSide_Btn_Frist_Y FRAME_L2LSide_Btn_Frist_Y

@interface L1Button : MyUIButton
@property (nonatomic, strong)NSMutableArray* L2Btns;
- (void)setOnTouch:(BOOL)normal;


+ (CGFloat)l1BtnX4Index:(NSInteger)index;
+ (CGFloat)l1BtnW4Index:(NSInteger)index;
@end
