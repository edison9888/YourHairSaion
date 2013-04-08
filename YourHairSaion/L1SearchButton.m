//
//  L1SearchButton.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-3.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "L1SearchButton.h"
#import "RootViewController.h"
#import "SearchPagePolicy.h"
#import "TextInputPopViewController.h"


@interface L1SearchButton()
@property (strong, nonatomic)TextInputPopViewController* inputPvc;
@end

@implementation L1SearchButton
@synthesize pc, inputPvc;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        inputPvc = [[TextInputPopViewController alloc]initWithNibName:@"TextInputPopViewController" bundle:nil];
        [inputPvc setContentSizeForViewInPopover:self.bounds.size];
        inputPvc.rvc = self.rvc;
        if (!pc)
        {
            pc = [[UIPopoverController alloc]initWithContentViewController:inputPvc];
        }
    }
    return self;
}
- (void)onTouchUp:(id)sender
{
//    if (self.rvc.searchTextField.isHidden == YES)
//    {
//        [self.rvc.searchTextField setHidden:NO];
//        [self.rvc.view bringSubviewToFront:self.rvc.searchTextField];
//        [self.rvc.searchTextField becomeFirstResponder];
//    }
//    else
//    {
//        if (![@"" isEqualToString:self.rvc.searchTextField.text])
//        {
//            [self.rvc textFieldShouldReturn:self.rvc.searchTextField];
//            [super onTouchUp:sender];
//        }
//    }
//    UIViewController* vc = [[UIViewController alloc]init];
//    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text = @"sldkfjsldfkjsdlf";
//    [vc.view addSubview:label];
//    vc.view.frame = label.frame;
//    vc.contentSizeForViewInPopover = CGSizeMake(200, 200);
    //[vc.view sizeToFit];
    
    pc.popoverContentSize = inputPvc.view.bounds.size;//CGSizeMake(400, 400);
    
    [pc presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


/* Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the dismissal of the view.
 */
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    
}

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
}

@end
