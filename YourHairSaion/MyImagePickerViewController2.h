//
//  MyImagePickerViewController2ViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-4.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImagePickerViewController2 : UIViewController
@property (nonatomic, strong)UIImagePickerController* picker;
@property (nonatomic, strong)NSString* hairFilePath;
@property (nonatomic, strong)UIImageView* pickerOverLayoutImageView;


- (id)initWithContentsOfFile:(NSString*)filePath;
- (id)initWithImage:(UIImage*)image;

@end
