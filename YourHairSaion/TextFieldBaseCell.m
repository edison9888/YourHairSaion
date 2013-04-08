//
//  DiscountCardTableCell.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-31.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "TextFieldBaseCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TextFieldBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.contentView.layer.cornerRadius = 0;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 10;
    self.contentView.layer.cornerRadius = 10;
}

@end
