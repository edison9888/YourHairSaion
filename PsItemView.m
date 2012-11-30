//
//  PsItemView.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//
#import "PsItemView.h"
#import "PsDataItem.h"

#define MARGIN 4.0

@interface PsItemView ()

@end

@implementation PsItemView

@synthesize
imageView = _imageView,
captionLabel = _captionLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    self.captionLabel.text = nil;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
    
    // Image
    CGFloat objectWidth = [UIImage imageNamed:((PsDataItem*)self.object).imgLink].size.width;
    CGFloat objectHeight = objectWidth + 20;//is.uiImg.size.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    self.imageView.frame = CGRectMake(left, top, width, scaledHeight);
    self.captionLabel.text = ((PsDataItem*)self.object).name;
    // Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    
    self.captionLabel.frame = CGRectMake(left, top, width, labelSize.height);
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    
    self.imageView.image = [UIImage imageNamed:((PsDataItem*)object).imgLink];
    
    self.captionLabel.text = ((PsDataItem*)object).name;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN;
    
    // Image
    CGFloat objectWidth = [UIImage imageNamed:((PsDataItem*)object).imgLink].size.width;
    CGFloat objectHeight = objectWidth + 20;//is.uiImg.size.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
    
    // Label
    NSString *caption = ((PsDataItem*)object).name;
    CGSize labelSize = CGSizeZero;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
    labelSize = [caption sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    height += labelSize.height;
    
    height += MARGIN*2;
    
    return height;
}
@end
