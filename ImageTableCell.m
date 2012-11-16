//
//  ImageTableCell.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-14.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#define CELL_MARGIN 20
#import "ImageTableCell.h"

@implementation ImageTableCell
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectZero;
        [self.contentView addSubview:self.imageView];
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        // Initialization code
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
    NSLog(@"width=%f", self.frame.size.width);
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat imageWidth = self.imageView.image.size.width;
    
    CGFloat width = self.frame.size.width - CELL_MARGIN;
    CGFloat height = floorf(imageHeight / (imageWidth / width));
    
    self.imageView.frame = (CGRectMake(0, 0, width, height));

}


- (CGFloat)height
{
    return self.imageView.frame.size.height;
}

- (void)setImage:(NSString*)imageLink
{
    self.imageView.image = [UIImage imageNamed:imageLink];
    [self layoutSubviews];
}
@end
