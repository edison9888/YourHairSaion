//
//  ShoppingCartTableCell.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "ShoppingCartTableCell.h"
#import "DataAdapter.h"
#import <QuartzCore/QuartzCore.h>

@interface ShoppingCartTableCell()

@property (nonatomic, strong)UIImage* imgSelected;
@property (nonatomic, strong)UIImage* imgNormal;


@end

@implementation ShoppingCartTableCell

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
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    //[self setStateSelected];
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [self _init];
    [super layoutSubviews];
    NSLog(@"cell frame w=%f, h=%f", self.bounds.size.width, self.bounds.size.height);
    
}

- (void)onAdd:(id)sender
{
    NSNumberFormatter* formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    NSInteger count = [[formater numberFromString:self.textFieldNum.text] integerValue];
    [[DataAdapter shareInstance]addProductToBuy:self.psd.productId];
    count ++;
    self.textFieldNum.text = [NSString stringWithFormat:@"%d", count];
    self.labelNum.text = self.textFieldNum.text;
    if (self.deleage && [self.deleage respondsToSelector:@selector(productAdd:)])
    {
        [self.deleage productAdd:self.psd];
    }
}

- (void)onReduce:(id)sender
{
    NSNumberFormatter* formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    NSInteger count = [[formater numberFromString:self.textFieldNum.text] integerValue];
    if (count > 0)
    {
        [[DataAdapter shareInstance]reduceProductToBuy:self.psd.productId];
        count --;
        self.textFieldNum.text = [NSString stringWithFormat:@"%d", count];
        if (self.deleage && [self.deleage respondsToSelector:@selector(productReduct:)])
        {
            [self.deleage productReduct:self.psd];
        }
    }
    self.labelNum.text = self.textFieldNum.text;

}

- (void)onDelete:(id)sender
{
    [[DataAdapter shareInstance]deleteProductToBuy:self.psd.productId];
    if (self.deleage && [self.deleage respondsToSelector:@selector(productReductTo0:)])
    {
        [self.deleage productReductTo0:self.psd];
    }

}

- (void)_init
{
    //self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.mainImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mainImageView.layer.borderWidth = 3.0;
    self.imgNormal = [UIImage imageNamed:@"cart_pic.png"];
    self.imgSelected = [UIImage imageNamed:@"cart_pic_hit.png"];
    self.labelPrice.textColor = COLOR_ORANGE;
    [self setStateNormal];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGRect bounds = self.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat radius = 1 * CGRectGetHeight(bounds);
    
    
    // Create the "visible" path, which will be the shape that gets the inner shadow
    // In this case it's just a rounded rect, but could be as complex as your want
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    CGRect innerRect = CGRectInset(bounds, radius, radius);
    CGPathMoveToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x + innerRect.size.width, bounds.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.origin.x + bounds.size.width, innerRect.origin.y, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, innerRect.origin.y + innerRect.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height, innerRect.origin.x + innerRect.size.width, bounds.origin.y + bounds.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y + bounds.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y + bounds.size.height, bounds.origin.x, innerRect.origin.y + innerRect.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x, innerRect.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y, innerRect.origin.x, bounds.origin.y, radius);
    CGPathCloseSubpath(visiblePath);
    
    // Fill this path
    UIColor *aColor = [UIColor redColor];
    [aColor setFill];
    CGContextAddPath(context, visiblePath);
    CGContextFillPath(context);
    
    
    // Now create a larger rectangle, which we're going to subtract the visible path from
    // and apply a shadow
    CGMutablePathRef path = CGPathCreateMutable();
    //(when drawing the shadow for a path whichs bounding box is not known pass "CGPathGetPathBoundingBox(visiblePath)" instead of "bounds" in the following line:)
    //-42 cuould just be any offset > 0
    CGPathAddRect(path, NULL, CGRectInset(bounds, -42, -42));
    
    // Add the visible path (so that it gets subtracted for the shadow)
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    // Add the visible paths as the clipping path to the context
    CGContextAddPath(context, visiblePath);
    CGContextClip(context);
    
    
    // Now setup the shadow properties on the context
    aColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 3.0f, [aColor CGColor]);
    
    // Now fill the rectangle, so the shadow gets drawn
    [aColor setFill];   
    CGContextSaveGState(context);   
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
    
    // Release the paths
    CGPathRelease(path);    
    CGPathRelease(visiblePath);
}
- (void)setStateSelected
{
    [self.btnAdd setHidden:NO];
    [self.btnAdd1 setHidden:NO];
    [self.btnReduce setHidden:NO];
    [self.btnReduce1 setHidden:NO];
    [self.labelNumHide setHidden:NO];
    [self.labelJian setHidden:NO];
    [self.textFieldNum setHidden:NO];
    self.ivBackground.image = self.imgSelected;
    [self.btnDelete setHidden:NO];
    [self.ivSelected setHidden:NO];
    CALayer *layer = self.detailView.layer;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowOpacity = 1.0;
    //layer.shadowPath
}
- (void)setStateNormal
{
    [self.btnAdd setHidden:YES];
    [self.btnAdd1 setHidden:YES];
    [self.btnReduce setHidden:YES];
    [self.btnReduce1 setHidden:YES];
    [self.labelNumHide setHidden:YES];
    [self.labelJian setHidden:YES];
    [self.textFieldNum setHidden:YES];
    self.ivBackground.image = self.imgNormal;
    [self.btnDelete setHidden:YES];
    [self.ivSelected setHidden:YES];

    CALayer *layer = self.detailView.layer;
    layer.shadowColor = [UIColor clearColor].CGColor;
    layer.shadowOffset = CGSizeZero;
    //layer.shadowPath
}


- (void)fillData:(ProductShowingDetail *)psd
{
    self.psd = psd;
    DataAdapter * da = [DataAdapter shareInstance];
    self.mainImageView.image = [psd.imgDic objectForKey:PRODUCT_PIC_TYPE_DEFAULT];
    self.labelDetail.text = psd.detail;
    self.labelPrice.text = [NSString stringWithFormat:@"￥%@", psd.price];
    self.labelNum.text = [NSString stringWithFormat:@"%d",[da numInShoppingCart:psd.productId]];
    self.textFieldNum.text = self.labelNum.text;
}


@end
