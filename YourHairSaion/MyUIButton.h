//
//  MyUIButton.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"

@class RootViewController;



@interface MyUIButton : UIButton
typedef enum
{
    MyUIButtonStyleLeft = 0,
    MyUIButtonStyleRight,
    MyUIButtonStyleTop,
    MyUIButtonStyleButtom
} MyUIButtonStyle;

@property (nonatomic, assign) enumViewControllerType vcType;
@property (nonatomic, strong) NSString* subType;
@property (nonatomic, strong) RootViewController* rvc;


- (id)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType andTitle:(NSString*)title andStyle:(MyUIButtonStyle)style andImgName:(NSString*)imgName andRvc:(RootViewController*)rvc;
@end
