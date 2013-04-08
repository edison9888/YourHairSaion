//
//  StatementViewController2.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-19.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductViewController;
@class RootViewController;

@interface StatementViewController2 : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)IBOutlet UITableView* tableView;
@property (nonatomic, strong)IBOutlet UIButton* btnFinished;
@property (nonatomic, strong)IBOutlet UIButton* btnDelete;
@property (nonatomic, strong)IBOutlet UILabel* labelDateTime;
@property (nonatomic, strong)RootViewController* rootViewController;




- (void)setProductViewController:(ProductViewController*)productViewController andIndex:(NSInteger)index;


- (IBAction)onSendMail:(id)sender;
- (IBAction)onDelete:(id)sender;
- (IBAction)onBack:(id)sender;
- (IBAction)onFinished:(id)sender;

- (void)reflash;

@end
