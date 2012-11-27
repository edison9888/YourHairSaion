//
//  DiscountCardDetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DiscountCardDetailViewController.h"
#import "DiscountCardItem.h"

@interface DiscountCardDetailViewController ()

@end

typedef enum {
    kImage,
    //	kDirections,
	kName,
    kDetail,
	kType,
    kOverlay,
	NUMBER_OF_SECTIONS
} TableSections;


@implementation DiscountCardDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		return nil;
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == kImage)
    {
        UITableViewCell* cell =  [self tableView:self.table cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[ImageTableCell class]])
        {
            return [((ImageTableCell*)cell) height];
        }
    }
    else if (indexPath.section == kDetail)
    {        
        UITableViewCell* cell =  [self tableView:self.table cellForRowAtIndexPath:indexPath];
        CGSize labelSize = [((DiscountCardItem*)self.item).detail sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(cell.bounds.size.width, INT_MAX) lineBreakMode:cell.detailTextLabel.lineBreakMode];
        return labelSize.height - 18.0 + 44.0f;
    }
	return 44.0f;
    
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* kImageCellIdentifier = @"ImageCellIdentifier";
	static NSString *kOtherCellIdentifier = @"OtherCellIdentifier";
	
	NSString *workingCellIdentifier =nil;
    switch (indexPath.section)
    {
        case kImage:
            workingCellIdentifier = kImageCellIdentifier;
            break;
        default:
            workingCellIdentifier = kOtherCellIdentifier;
            break;
    }
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workingCellIdentifier];
    if ([workingCellIdentifier isEqualToString:kImageCellIdentifier])
    {
        cell = [[ImageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kImageCellIdentifier];
    }
    else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:workingCellIdentifier];
    }
	DiscountCardItem* tmp = (DiscountCardItem*)self.item;
	switch (indexPath.section) {
        case kImage:
            [((ImageTableCell*)cell) setImage:self.item.imgLink];
            break;
		case kName:
			cell.textLabel.text = @"名字:";
			cell.detailTextLabel.text = tmp.name;
			break;
		case kType:
			cell.textLabel.text = @"优惠:";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", tmp.discountName, tmp.calcValue];
			break;
		case kDetail:
			cell.textLabel.text = @"介绍:";
			cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
			cell.detailTextLabel.numberOfLines = 0;
			cell.detailTextLabel.text = tmp.detail;
			break;
        case kOverlay:
			cell.textLabel.text = @"叠加使用:";
			cell.detailTextLabel.text = [tmp.overlay isEqualToNumber:DISCOUNT_CARD_NO_OVERLAY] ? @"是": @"否";
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
            case kImage:
        case kName:
		case kDetail:
		case kType:
		case kOverlay:
			rows = 1;
			break;
		default:
			break;
	}
	return rows;
}




@end
