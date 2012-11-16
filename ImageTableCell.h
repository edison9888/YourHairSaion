//
//  ImageTableCell.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-14.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableCell : UITableViewCell
@property (nonatomic, strong)UIImageView* imageView;
- (CGFloat)height;
- (void)setImage:(NSString*)imageLink;
@end
