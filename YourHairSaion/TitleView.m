//
//  TitleView.m
//  YourHairSaion
//
//  Created by chen loman on 13-2-15.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "TitleView.h"
#define FRAME_H 16
#define FONT_CHS [UIFont systemFontOfSize:18]
#define FONT_ENG [UIFont systemFontOfSize:10]
#define TEXT_COLOR [UIColor darkGrayColor]
@interface TitleView()

@end
@implementation TitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (id)initWithTitleInCHS:(NSString *)titleCHS andTitleInENG:(NSString *)titleENG
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        [self _init];
        [self setTitleInCHS:titleCHS andTitleInENG:titleENG];
        
    }
    return self;
}

- (void)setTitleInCHS:(NSString *)titleCHS andTitleInENG:(NSString *)titleENG
{
    CGSize size1 = [titleCHS sizeWithFont:FONT_CHS constrainedToSize:CGSizeMake(INT_MAX, FRAME_H) lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize size2 = [titleENG sizeWithFont:FONT_ENG constrainedToSize:CGSizeMake(INT_MAX, FRAME_H) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGFloat width = size1.width + size2.width;
    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:label1];
    [self addSubview:label2];
    label1.frame = CGRectMake(0, 0, size1.width, FRAME_H);
    label2.frame = CGRectMake(size1.width, 0, size2.width, FRAME_H);
    label1.text = titleCHS;
    label1.font = FONT_CHS;
    label1.textColor = TEXT_COLOR;
    label1.backgroundColor = [UIColor clearColor];
    
    label2.text = titleENG;
    label2.font = FONT_ENG;
    label2.textColor = TEXT_COLOR;
    label2.backgroundColor = [UIColor clearColor];

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, FRAME_H);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)_init
{
    CGRect rect = self.frame;
    rect.size.height = FRAME_H;
    self.frame = rect;
    self.backgroundColor = [UIColor clearColor];
}

@end
