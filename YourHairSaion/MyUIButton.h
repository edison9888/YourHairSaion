//
//  MyUIButton.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "BasePagePolicy.h"
#import "UIView+CornerAddition.h"


#define MAX_L1_BUTTON_NUM 16
#define MAX_L2_BUTTON_NUM 16

@class RootViewController;



@interface MyUIButton : UIButton
typedef enum
{
    MyUIButtonStyleLeft = 0,
    MyUIButtonStyleRight,
    MyUIButtonStyleTop,
    MyUIButtonStyleButtom
} MyUIButtonStyle;

@property (nonatomic, strong) RootViewController* rvc;
@property (nonatomic, strong) BasePagePolicy* pagePolicy;
@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) NSString* navImageName;
@property (nonatomic, strong) NSString* strTitle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong)UIImageView* imageShadow;
- (void)setStateOnTouch:(BOOL)touched;






- (UIButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy*)pagePolicy andTitle:(NSString*)title andStyle:(MyUIButtonStyle)style andImgName:(NSString*)imgName andRvc:(RootViewController*)rootViewController;
- (UIButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy*)pagePolicy andTitle:(NSString*)title andStyle:(MyUIButtonStyle)style andImgNameIndex:(NSInteger)index andRvc:(RootViewController*)rootViewController;

- (void)onTouchUp:(id)sender;
- (void)setVerticalTitle:(NSString*)title;


@end
