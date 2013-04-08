//
//  PsItemView.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#define FRAME_BUTTON_W 10
#define FRAME_BUTTON_H FRAME_BUTTON_W


#import "PSCollectionViewCell.h"
@protocol ProductBuyingDelegate <NSObject>

@required
- (BOOL)canBuy:(PSCollectionViewCell *)cell;
- (void)prepareToBuy:(PSCollectionViewCell *)cell;
- (void)productAdd:(PSCollectionViewCell *)cell;
- (void)productReduct:(PSCollectionViewCell *)cell;
- (void)finishToBuy:(PSCollectionViewCell *)cell;
@end

@interface PsItemView : PSCollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *captionLabel;
@property (nonatomic, strong) UIView* content;
@property (nonatomic, strong) UIImageView *selectedImg;

@property (nonatomic, strong) id<ProductBuyingDelegate> productBuyingDelegate;


- (void)prepareToBuy;
- (void)finishToBuy;
- (void)productAdd;
- (void)productReduct;
- (void)reflash;

- (CGPoint)realImgViewCenter;
- (UIImageView*)imageViewCopy;
- (void)setContentBackGroundColor:(UIColor *)backgroundColor;
- (void)setSelected:(BOOL)selected;
@end
