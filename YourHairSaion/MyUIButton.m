//
//  MyUIButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyUIButton.h"
#import "RootViewController.h"
#import "BasePagePolicy.h"
#import "OperationNode.h"

#define Label_Offset 5

static int idTag = 100;

@interface MyUIButton()
{

}
@property (nonatomic, assign) MyUIButtonStyle myUIButtonStyle;
- (void)setTitle:(NSString*)title;
- (NSString*)convertStringToVertical:(NSString*)string;
- (void)onTouchUpBase:(id)sender;
@end

@implementation MyUIButton
@synthesize rvc, myUIButtonStyle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myUIButtonStyle = MyUIButtonStyleLeft;
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.bounds = CGRectMake(0,0,20,self.titleLabel.bounds.size.height);
        self.titleLabel.textAlignment = UITextAlignmentRight;
        [self setTitle:@"男士发型"];
        self.titleLabel.center = self.center;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:28];
        [self.titleLabel sizeToFit];
        [self addTarget:self action:@selector(onTouchUpBase:) forControlEvents:UIControlEventTouchUpInside];
        [self setTag:idTag++];

        
    }
    return self;
}

- (UIButton*)initAll:(CGRect)frame andPagePolicy:(BasePagePolicy*)pagePolicy andTitle:(NSString*)title andStyle:(MyUIButtonStyle)style andImgName:(NSString*)imgName andRvc:(RootViewController*)rootViewController
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.rvc = rootViewController;
        self.pagePolicy = pagePolicy;
        self.myUIButtonStyle = style;
        [self setTitle:title];
        self.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:imgName]];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:[self convertStringToVertical:title] forState:UIControlStateNormal];
}

- (NSString*)convertStringToVertical:(NSString *)string
{
    int len = string.length;
    NSString* result = @"";
    for (int i = 0; i < len; i++)
    {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%@\n", [string substringWithRange:NSMakeRange(i, 1)]]];
    }
    return result;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"label.x[%f],y[%f],w[%f],h[%f]", self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    switch (self.myUIButtonStyle)
    {
        case MyUIButtonStyleLeft:
            self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x-Label_Offset, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            break;
        case MyUIButtonStyleRight:
            self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x+Label_Offset, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            break;
            /*
             case MyUIButtonStyleTop:
             self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x+Label_Offset, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
             break;
             case MyUIButtonStyleButtom:
             self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x+Label_Offset, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
             break;
             */
            
        default:
            break;
    }
}

- (void)onTouchUpBase:(id)sender
{
    [self.rvc opMark:[[OperationNode alloc]initWithPagePolicy:self.pagePolicy andPageIndex:self.tag]];
    [self onTouchUp:sender];
}

- (void)onTouchUp:(id)sender
{
}

@end
