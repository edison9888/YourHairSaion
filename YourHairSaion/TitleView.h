//
//  TitleView.h
//  YourHairSaion
//
//  Created by chen loman on 13-2-15.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView
- (id)initWithTitleInCHS:(NSString*)titleCHS andTitleInENG:(NSString*)titleENG;
- (id)initWithTitleInCHS:(NSString*)titleCHS andTitleInENG:(NSString*)titleENG andSubTitleCHS:(NSString*)subTitleCHS andSubTitleInENG:(NSString*)subTitleENG;
- (void)setTitleInCHS:(NSString*)titleCHS andTitleInENG:(NSString*)titleENG;
- (void)setTitleInCHS:(NSString*)titleCHS andTitleInENG:(NSString*)titleENG andSubTitleCHS:(NSString*)subTitleCHS andSubTitleInENG:(NSString*)subTitleENG;
@end
