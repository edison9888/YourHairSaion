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
#import "ProductPagePolicy.h"
@interface L1Button()
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

- (L1Button*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy *)pagePolicy andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    self = [super initAll:frame andPagePolicy:pagePolicy andTitle:title andStyle:style andImgName:imgName andRvc:rvc];
    if (self)
    {
        if ([self.pagePolicy isProduct])
        {
            DataAdapter* da = [DataAdapter shareInstance];
            NSArray* rootProductType = [da productTypeForParent:[self.pagePolicy subType]];
            self.L2Btns = [[NSMutableArray alloc]init];
            int counter = 0;
            NSString* btnImgName = nil;
            for (ProductType* type in rootProductType)
            {
                L2Button *btnL2 = nil;
                if (counter < 4)
                {
                    btnImgName = [NSString stringWithFormat:@"ll2Btn%d.png", counter+1];
                    btnL2 = [[L2Button alloc]initAll:CGRectMake((FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*counter++), FRAME_L2LSide_Btn_Frist_Y,FRAME_L2LSide_Btn_W, FRAME_L2LSide_Btn_H) andPagePolicy:[[ProductPagePolicy alloc] initWithSubType:type.productType] andTitle:type.typeName andStyle:MyUIButtonStyleTop andImgName:btnImgName andRvc:self.rvc];

                }
                else
                {
                    btnImgName = [NSString stringWithFormat:@"rl2Btn%d.png", counter-3];
                    btnL2 = [[L2Button alloc]initAll:CGRectMake((FRAME_L2RSide_Btn_First_X+(-1*FRAME_L2RSide_Btn_W+FRAME_L2Btn_Margin)*counter++), FRAME_L2RSide_Btn_Frist_Y,FRAME_L2RSide_Btn_W, FRAME_L2RSide_Btn_H) andPagePolicy:[[ProductPagePolicy alloc] initWithSubType:type.productType] andTitle:type.typeName andStyle:MyUIButtonStyleTop andImgName:btnImgName andRvc:self.rvc];

                }
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
    [super onTouchUp:sender];
    if (![self.pagePolicy isEqual:[self.rvc pagePolicy]])
    {
        [self.rvc setPagePolicy:self.pagePolicy];
        for (UIView* view in self.rvc.view.subviews)
        {
            if ([view isKindOfClass:[L1Button class]])
            {
                [self.rvc.view sendSubviewToBack:view];
            }
            if ([view isKindOfClass:[L2Button class]])
            {
                [view setHidden:YES];
                [self.rvc.view sendSubviewToBack:view];
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
