//
//  Taking_Photos_with_the_CameraViewController.h
//  Taking Photos with the Camera
//
//  Created by Vandad Nahavandipoor on 22/07/2011.
//  Copyright 2011 Pixolity Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PopUpSubViewController.h"

@interface FacePickerViewController
           : PopUpSubViewController <UIImagePickerControllerDelegate>
@property (nonatomic, strong)UIImagePickerController *picker;
@end
