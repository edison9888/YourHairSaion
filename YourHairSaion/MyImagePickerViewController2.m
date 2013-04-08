//
//  MyImagePickerViewController2ViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-4.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "MyImagePickerViewController2.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+fixOrientation.h"

@interface MyImagePickerViewController2 ()

@property (nonatomic, strong)UIButton* btnSwitch;

- (void)onSwitch;

@end

@implementation MyImagePickerViewController2
@synthesize picker, hairFilePath, pickerOverLayoutImageView, btnSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        picker.cameraViewTransform=CGAffineTransformScale(CGAffineTransformIdentity, -1,1);
        NSString *requiredMediaType = (__bridge NSString *)kUTTypeImage;
        picker.mediaTypes = [[NSArray alloc]
                             initWithObjects:requiredMediaType, nil];
        picker.allowsEditing = NO;

    }
    return self;
}

- (id)initWithContentsOfFile:(NSString*)filePath
{
    self = [self init];
    if (self)
    {
        
        [self setHair:[UIImage imageWithContentsOfFile:filePath]];
    }
    return self;
}

- (id)initWithImage:(UIImage*)image
{
    self = [self init];
    if (self)
    {
        [self setHair:image];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];    
        
    btnSwitch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSwitch setTitle:@"后置摄像头" forState:UIControlStateNormal];
    [btnSwitch addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventTouchUpInside];
    btnSwitch.frame = CGRectMake(20, 20, 100, 50);
    btnSwitch.alpha = 0.5;
    [picker.cameraOverlayView addSubview:pickerOverLayoutImageView];
    [picker.cameraOverlayView addSubview:btnSwitch];

    [self.view addSubview:picker.view];
    

	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


- (void)onSwitch
{
    if (picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        [picker setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        picker.cameraViewTransform=CGAffineTransformScale(CGAffineTransformIdentity, 1,1);
        [btnSwitch setTitle:@"前置摄像头" forState:UIControlStateNormal];

    }
    else
    {
        [picker setCameraDevice:UIImagePickerControllerCameraDeviceFront];
        picker.cameraViewTransform=CGAffineTransformScale(CGAffineTransformIdentity, -1,1);
        [btnSwitch setTitle:@"后置摄像头" forState:UIControlStateNormal];

    }
}

- (void)setHair:(UIImage*)image
{
    UIImage* img = image;
    pickerOverLayoutImageView = [[UIImageView alloc]initWithImage:img];
    CGFloat objectWidth = CGImageGetWidth(img.CGImage);
    CGFloat objectHeight = CGImageGetHeight(img.CGImage);
    CGRect cameraOverlayFrame = CGRectMake(0, 0, CAMERA_SCREEN_H, CAMERA_SCREEN_W);//controller.cameraOverlayView.frame;
    CGFloat frameWidth = cameraOverlayFrame.size.width;
    CGFloat frameHeight = cameraOverlayFrame.size.height;
    CGFloat ivWidth = 0;
    CGFloat ivHeight = 0;
    //长形
    if (objectWidth/CAMERA_SCREEN_W > objectHeight/CAMERA_SCREEN_H)
    {
        ivWidth = frameWidth;
        ivHeight = objectHeight/(objectWidth/frameWidth);
        //填充黑边
        UIView* fillUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ivWidth, (frameHeight-ivHeight)/2)];
        fillUp.backgroundColor = [UIColor blackColor];
        [picker.cameraOverlayView addSubview:fillUp];
        
        UIView* fillDown = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (frameHeight-ivHeight)/2 + ivHeight, (frameHeight-ivHeight)/2)];
        fillDown.backgroundColor = [UIColor blackColor];
        [picker.cameraOverlayView addSubview:fillDown];

                                                                  
    }
    //竖型
    else
    {
        ivHeight = frameHeight;
        ivWidth = objectWidth/(objectHeight/frameHeight);
        //填充黑边
        UIView* fillLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (frameWidth-ivWidth)/2, ivHeight)];
        fillLeft.backgroundColor = [UIColor blackColor];
        [picker.cameraOverlayView addSubview:fillLeft];
        
        UIView* fillRight = [[UIView alloc]initWithFrame:CGRectMake((frameWidth-ivWidth)/2 + ivWidth, 0, (frameWidth-ivWidth)/2, ivHeight)];
        fillRight.backgroundColor = [UIColor blackColor];
        [picker.cameraOverlayView addSubview:fillRight];
    }
    
    pickerOverLayoutImageView.frame = CGRectMake((cameraOverlayFrame.size.width-ivWidth)/2, (cameraOverlayFrame.size.height-ivHeight)/2, ivWidth, ivHeight);
    
    //pickerOverLayoutImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

@end
