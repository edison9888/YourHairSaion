//
//  MyToolBar.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "RootViewController.h"

@interface MyToolBar : UIToolbar
- (id)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString*)subType andImgName:(NSString*)imgName andRvc:(RootViewController*)rvc;
@end
