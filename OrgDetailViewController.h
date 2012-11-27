//
//  HotelDetailViewController.h
//  AnimatedCallout
//
//  Created by Gordon on 2/15/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PsDetailViewController.h"

@class OrganizationItem;
@class MapPsViewController;
@interface OrgDetailViewController : PsDetailViewController/*UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate> {
	UITableView *table;
	OrganizationItem *orgItem;

@private
	NSArray *directions;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) OrganizationItem *orgItem;
@property (nonatomic, strong) MapPsViewController* mapPsViewController;

- (NSUInteger)indexInPage;
*/
@end
