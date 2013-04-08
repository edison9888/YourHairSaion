//
//  TextViewBaseCell.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-31.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "TextViewBaseCell.h"

@implementation TextViewBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
