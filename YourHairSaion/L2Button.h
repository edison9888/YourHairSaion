//
//  L2Button.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-22.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyUIButton.h"
#import "L1Button.h"
@class L1Button;
@interface L2Button : MyUIButton
@property (nonatomic, strong)L1Button* l1Btn;
@end
