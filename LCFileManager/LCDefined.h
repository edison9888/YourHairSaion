//
//  LCDefined.h
//  YourHairSaion
//
//  Created by chen loman on 13-3-12.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#ifndef YourHairSaion_LCDefined_h
#define YourHairSaion_LCDefined_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



#define SCREEN_W 1024
#define SCREEN_H 748
#define FRAME_PAGE_EDGE_X 23  //512-479
#define FRAME_PAGE_EDGE_Y 25  //(748-697)/2
#define FRAME_PAGE_EDGE_W 11
#define FRAME_PAGE_EDGE_H (SCREEN_H-2*(FRAME_PAGE_EDGE_Y))
#define RECT_INSET_W (FRAME_PAGE_EDGE_X + FRAME_PAGE_EDGE_W)
#define RECT_INSET_H FRAME_PAGE_EDGE_Y


#define FRAME_W (SCREEN_W/2 - RECT_INSET_W)
#define FRAME_H (SCREEN_H - RECT_INSET_H*2)


// color define
#define COLOR_BLUE [UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0]
#define COLOR_GRAY [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]
#define COLOR_ORANGE [UIColor colorWithRed:221.0/255.0 green:167.0/255.0 blue:49.0/255.0 alpha:1.0]
#define COLOR_LIGHTBLUE [UIColor colorWithRed:70.0/255.0 green:137/255.0 blue:183/255.0 alpha:1.0]

#define COLOR_SELECT [UIColor colorWithRed:0.65098041296005249 green:0.90196084976196289 blue:0.92549026012420654 alpha:1]



#endif
