//
//  MyUIButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyUIButton.h"
#import "RootViewController.h"

#define Label_Offset 5
@interface MyUIButton()
- (void)onTouchUp:(id)sender;

@property (nonatomic, assign) MyUIButtonStyle myUIButtonStyle;

- (void)setTitle:(NSString*)title;
- (NSString*)convertStringToVertical:(NSString*)string;
@end

@implementation MyUIButton
@synthesize subType, rvc, vcType, myUIButtonStyle;

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
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.titleLabel sizeToFit];
        [self addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (id)initAll:(CGRect)frame andVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType andTitle:(NSString *)title andStyle:(MyUIButtonStyle)style andImgName:(NSString *)imgName andRvc:(RootViewController *)rvc
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.rvc = rvc;
        self.vcType = enumVcType;
        self.subType = subType;
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

- (void)onTouchUp:(id)sender
{
    [self.rvc setVcType:vcType andSubType:self.subType];
    for (UIView* view in self.rvc.view.subviews)
    {
        if ([view isKindOfClass:[MyUIButton class]])
        {
            [self.rvc.view sendSubviewToBack:view];
            //self.titleLabel.textColor = [UIColor whiteColor];
            
        }
    }
    [self.rvc.view bringSubviewToFront:self];
    //self.titleLabel.textColor = [UIColor blackColor];
    //self.tintColor = [UIColor blackColor];

}


@end
