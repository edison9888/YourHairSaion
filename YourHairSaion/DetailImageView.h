//
//  DetailImageView.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-7.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageView : UIImageView

- (void)setImage:(NSString *)imgLink withType:(NSNumber*)type;
@property (nonatomic, assign)CGFloat rotation;
- (void)setRotation:(CGFloat)rota;
@end
