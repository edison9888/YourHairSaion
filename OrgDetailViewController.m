    //
//  HotelDetailViewController.m
//  AnimatedCallout
//
//  Created by Gordon on 2/15/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import "OrgDetailViewController.h"
#import "OrganizationItem.h"
#import "ImageTableCell.h"
#import "MapPsViewController.h"
#import "TitleView.h"

typedef enum {
//	kDirections,
	kPhone,
	kURL,
	kAddress,
	NUMBER_OF_SECTIONS
} TableSections;

@interface OrgDetailViewController ()
@end

@implementation OrgDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		return nil;
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView* iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shop_title.png"]];
//    iv.contentMode = UIViewContentModeScaleAspectFit;
    //[self.viewTitle addSubview:iv];
    //iv.frame = CGRectMake(0, 0, 130, 16);
    TitleView* titleView = [[TitleView alloc]initWithTitleInCHS:@"分店简介" andTitleInENG:@""];
    [self.viewTitle addSubview:titleView];
    CGRect rect = titleView.frame;
    rect.origin.y = 4;
    titleView.frame = rect;

    
}


#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == kImage)
//    {
//        UITableViewCell* cell =  [self tableView:self.table cellForRowAtIndexPath:indexPath];
//        if ([cell isKindOfClass:[ImageTableCell class]])
//        {
//            return [((ImageTableCell*)cell) height];
//        }
//    }
    if (indexPath.section == kAddress)
        return 20;
	return 20;
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kDirectionCellIdentifier = @"DirectionCellIdentifier";
  //  static NSString* kImageCellIdentifier = @"ImageCellIdentifier";
	static NSString *kOtherCellIdentifier = @"OtherCellIdentifier";
	
	NSString *workingCellIdentifier =nil;
    switch (indexPath.section)
    {
//        case kImage:
//            workingCellIdentifier = kImageCellIdentifier;
//            break;
        default:
            workingCellIdentifier = kOtherCellIdentifier;
            break;
    }
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workingCellIdentifier];
	if (cell == nil) {
		if ([workingCellIdentifier isEqualToString:kDirectionCellIdentifier]) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workingCellIdentifier];
		}
//        else if ([workingCellIdentifier isEqualToString:kImageCellIdentifier])
//        {
//            cell = [[ImageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kImageCellIdentifier];
//        }
		else {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:workingCellIdentifier];
		}
	}
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.textAlignment = UITextAlignmentLeft;
    
	switch (indexPath.section) {
//        case kImage:
//            [((ImageTableCell*)cell) setImage:self.item.imgLink];
//            break;
            /*
		case kDirections:
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.textLabel.text = [self.directions objectAtIndex:indexPath.row];
			cell.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:102.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
			break;
             */
		case kPhone:
			cell.textLabel.text = @"电话";
			cell.detailTextLabel.text = ((OrganizationItem*)self.item).phone;
			break;
		case kURL:
			cell.textLabel.text = @"主页";
			cell.detailTextLabel.text = ((OrganizationItem*)self.item).url;
			break;
		case kAddress:
			cell.textLabel.text = @"地址";
			cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
			cell.detailTextLabel.numberOfLines = 0;
			cell.detailTextLabel.text = [((OrganizationItem*)self.item) address];
            break;
		default:
			break;
	}
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.item == nil ? 0 : NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = 0;
	switch (section) {
//        case kImage:
		case kPhone:
		case kURL:
		case kAddress:
			rows = 1;
			break;
		default:
			break;
	}
	return rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	if (indexPath.section == kURL) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:((OrganizationItem*)self.item).url]];
	}
}




@end
