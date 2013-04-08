//
//  TextViewBaseCell.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-31.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewBaseCell : UITableViewCell
@property (nonatomic, strong)IBOutlet UIImageView* imageView;
@property (nonatomic, strong)IBOutlet UILabel* labelTitle;
@property (nonatomic, strong)IBOutlet UITextView* textViewDetail;

@end
