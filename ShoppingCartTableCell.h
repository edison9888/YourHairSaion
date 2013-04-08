//
//  ShoppingCartTableCell.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"

@protocol ShoppingCartTableCellDeleage <NSObject>

- (void)productAdd:(ProductShowingDetail*)psd;
- (void)productReduct:(ProductShowingDetail*)psd;
- (void)productReductTo0:(ProductShowingDetail*)psd;


@end

@interface ShoppingCartTableCell : UITableViewCell
@property (nonatomic, assign)id<ShoppingCartTableCellDeleage> deleage;
@property (nonatomic, strong)IBOutlet UIImageView* mainImageView;
@property (nonatomic, strong)IBOutlet UIImageView* ivBackground;
@property (nonatomic, strong)IBOutlet UIImageView* ivSelected;

@property (nonatomic, strong)IBOutlet UILabel* labelDetail;
@property (nonatomic, strong)IBOutlet UIView* detailView;
@property (nonatomic, strong)IBOutlet UILabel* labelPrice;
@property (nonatomic, strong)IBOutlet UILabel* labelNum;
@property (nonatomic, strong)IBOutlet UILabel* labelNumHide;
@property (nonatomic, strong)IBOutlet UILabel* labelJian;
@property (nonatomic, strong)IBOutlet UITextField* textFieldNum;
@property (nonatomic, strong)IBOutlet UIButton* btnAdd;
@property (nonatomic, strong)IBOutlet UIButton* btnAdd1;
@property (nonatomic, strong)IBOutlet UIButton* btnReduce;
@property (nonatomic, strong)IBOutlet UIButton* btnReduce1;
@property (nonatomic, strong)IBOutlet UIButton* btnDelete;
@property (nonatomic, strong)ProductShowingDetail* psd;


- (IBAction)onAdd:(id)sender;
- (IBAction)onReduce:(id)sender;
- (IBAction)onDelete:(id)sender;


- (void)fillData:(ProductShowingDetail*) psd;
- (void)setStateNormal;
- (void)setStateSelected;

@end
