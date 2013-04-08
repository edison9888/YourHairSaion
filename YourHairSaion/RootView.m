//
//  RootView.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-16.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "RootView.h"
#import "L1Button.h"
#import "L2Button.h"


@implementation RootView

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

//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if(point.x > FRAME_L2LSide_Btn_First_X && point.x < (FRAME_L2LSide_Btn_First_X+(FRAME_L2LSide_Btn_W+FRAME_L2Btn_Margin)*MAX_L2Button_NUM))
//    {
//        return self;
//    }
//    else
//    {
//        return [super hitTest:point withEvent:event];
//    }
    
//    L2Button* btn;
//    for (UIView* biew in self.subviews)
//    {
//        if ([biew isKindOfClass:[L2Button class]])
//        {
//            UIView* view =  [biew hitTest:point withEvent:event];
//            if (view == nil)
//            {
//                return [super hitTest:point withEvent:event];
//            }
//            return view;
//        }
//    }
//    return btn;
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if (hitView == self)
//    {
//        return nil;
//    }
//    else
//    {
//        return hitView;
//    }
//}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    for (UIView * view in [self subviews]) {
//        if (view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
//            return YES;
//        }
//    }
//    return NO;
//}

@end
