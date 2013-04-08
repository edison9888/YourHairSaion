//
//  MyImagePickerViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-31.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyImagePickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface MyImagePickerViewController ()
- (void)onSwitch;
@end

@implementation MyImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    NSString *requiredMediaType = (__bridge NSString *)kUTTypeImage;
    self.mediaTypes = [[NSArray alloc]
                             initWithObjects:requiredMediaType, nil];
    self.allowsEditing = NO;
    self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    UIImage* img = [UIImage imageNamed:@"1_noface.png"];
    UIImageView* iv = [[UIImageView alloc]initWithImage:img];
    CGFloat objectWidth = CGImageGetWidth(img.CGImage);
    CGFloat objectHeight = CGImageGetHeight(img.CGImage);
    CGRect cameraOverlayFrame = CGRectMake(0, 0, SCREEN_H, SCREEN_W);//controller.cameraOverlayView.frame;
    CGFloat frameWidth = cameraOverlayFrame.size.width;
    CGFloat frameHeight = cameraOverlayFrame.size.height;
    CGFloat ivWidth = 0;
    CGFloat ivHeight = 0;
    //长形
    if (objectWidth/SCREEN_W > objectHeight/SCREEN_H)
    {
        ivWidth = frameWidth;
        ivHeight = objectHeight/(objectWidth/frameWidth);
    }
    //竖型
    else
    {
        ivHeight = frameHeight;
        ivWidth = objectWidth/(objectHeight/frameHeight);
    }
    
    iv.frame = CGRectMake((cameraOverlayFrame.size.width-ivWidth)/2, (cameraOverlayFrame.size.height-ivHeight)/2, ivWidth, ivHeight);
    iv.contentMode = UIViewContentModeScaleAspectFill;

    [self.cameraOverlayView addSubview:iv];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [btn addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.alpha = 0.5;
    [self.cameraOverlayView addSubview:btn];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationIsPortrait(toInterfaceOrientation);
}

- (void)setCameraDevice:(UIImagePickerControllerCameraDevice)cameraDevice
{
    [super setCameraDevice:cameraDevice];
    if (cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        self.cameraViewTransform=CGAffineTransformScale(CGAffineTransformIdentity, -1,1);
    }
    else
    {
        self.cameraViewTransform=CGAffineTransformScale(CGAffineTransformIdentity, 1,1);
    }

}


- (void)onSwitch
{
    if (self.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        [self setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    }
    else
    {
        [self setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    }
}


@end
