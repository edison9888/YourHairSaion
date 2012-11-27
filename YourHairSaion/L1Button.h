//
//  L1Button.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyUIButton.h"

#define FRAME_L2LSide_Btn_W 30
#define FRAME_L2LSide_Btn_H 79
#define FRAME_L2LSide_Btn_First_X 250
#define FRAME_L2LSide_Btn_Frist_Y 18

#define FRAME_L2Btn_Margin 10

#define FRAME_L2RSide_Btn_W 60
#define FRAME_L2RSide_Btn_H 110
#define FRAME_L2RSide_Btn_First_X 1024 - 77
#define FRAME_L2RSide_Btn_Frist_Y 179

@interface L1Button : MyUIButton
@property (nonatomic, strong)NSMutableArray* L2Btns;

@end
