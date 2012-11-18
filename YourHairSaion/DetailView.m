//
//  DetailViewCell.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#define MARGIN 8.0
#define IMG_X 123
#define IMG_Y 40
#define IMG_W 180
#define IMG_H 240
#import "DetailView.h"
@interface DetailView()
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *captionLabel;
- (void)formatLabel:(ProductShowingDetail*)psd;
@end
@implementation DetailView
@synthesize
imageView = _imageView,
captionLabel = _captionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        self.captionLabel.text = @"TEST";
        [self addSubview:self.captionLabel];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgRight.png"]];
        self.alwaysBounceVertical = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = IMG_W;
    CGFloat totalHeigh = IMG_Y;
    CGFloat top = IMG_Y;
    CGFloat left = IMG_X;
    
    // Image
    CGFloat objectWidth = self.imageView.image.size.width;
    CGFloat objectHeight = self.imageView.image.size.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    //CGFloat scaledHeight = 0.0f;
    if (objectHeight < 0.01 || objectWidth < 0.01)
    {
        scaledHeight = 0.0f;
    }
    
    //    NSLog(@"left=%f, top=%f, width=%f, heigh=%f, owidth=%f, oheight=%f", left, top, width, scaledHeight, objectWidth, objectHeight);
    self.imageView.frame = CGRectMake(left, top, width, scaledHeight);
    
    // Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    
    self.captionLabel.frame = CGRectMake(left, top, self.imageView.frame.size.width, labelSize.height);
    
    totalHeigh += scaledHeight + MARGIN + labelSize.height;
    self.contentSize = CGSizeMake(width, totalHeigh);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)fillData:(ProductShowingDetail *)psd
{
    [self formatLabel:psd];
    self.imageView.image = [UIImage imageNamed:psd.fullFileName];
    [self layoutSubviews];
}

- (void)formatLabel:(ProductShowingDetail*)psd
{
    self.captionLabel.text = psd.productDetail;
}

@end
