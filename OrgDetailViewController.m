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

typedef enum {
    kImage,
	kDirections,
	kPhone,
	kURL,
	kAddress,
	NUMBER_OF_SECTIONS
} TableSections;

@interface OrgDetailViewController ()
@property (nonatomic, readonly) NSArray *directions;
@end

@implementation OrgDetailViewController

@synthesize table, orgItem;
@synthesize directions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		return nil;
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"bgRight.png"]];
	self.table.backgroundColor = [UIColor clearColor];
	UIImage *backgroundImage = [[UIImage imageNamed:@"CalloutTableBackground.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:6];
	UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	backgroundImageView.frame = self.view.bounds;
	self.table.backgroundView = backgroundImageView;
    //self.orgItem = [[OrganizationItem alloc]initWithObject:[DataAdapter shareInstance].organizations[0]];
    //self.table.bounds = CGRectMake(20, 20, 200, 200);
    //self.table.center = self.view.center;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    self.table.bounds = CGRectMake(0, 0, 340, 600);
    self.table.center = self.view.center;
	[self.table reloadData];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.table = nil;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == kAddress) {
		return 80.0f;
	}
    if (indexPath.section == kImage)
    {
        UITableViewCell* cell =  [self tableView:self.table cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[ImageTableCell class]])
        {
            return [((ImageTableCell*)cell) height];
        }
    }
	return 44.0f;
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kDirectionCellIdentifier = @"DirectionCellIdentifier";
    static NSString* kImageCellIdentifier = @"ImageCellIdentifier";
	static NSString *kOtherCellIdentifier = @"OtherCellIdentifier";
	
	NSString *workingCellIdentifier =nil;
    switch (indexPath.section)
    {
        case kImage:
            workingCellIdentifier = kImageCellIdentifier;
            break;
        case kDirections:
            workingCellIdentifier = kDirectionCellIdentifier;
            break;
        default:
            workingCellIdentifier = kOtherCellIdentifier;
            break;
    }
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workingCellIdentifier];
	if (cell == nil) {
		if ([workingCellIdentifier isEqualToString:kDirectionCellIdentifier]) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workingCellIdentifier];
		}
        else if ([workingCellIdentifier isEqualToString:kImageCellIdentifier])
        {
            cell = [[ImageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kImageCellIdentifier];
        }
		else {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:workingCellIdentifier];
		}
	}
	
	switch (indexPath.section) {
        case kImage:
            [((ImageTableCell*)cell) setImage:self.orgItem.imgLink];
            break;
		case kDirections:
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.textLabel.text = [self.directions objectAtIndex:indexPath.row];
			cell.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:102.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
			break;
		case kPhone:
			cell.textLabel.text = @"phone";
			cell.detailTextLabel.text = self.orgItem.phone;
			break;
		case kURL:
			cell.textLabel.text = @"home page";
			cell.detailTextLabel.text = self.orgItem.url;
			break;
		case kAddress:
			cell.textLabel.text = @"address";
			
			cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
			cell.detailTextLabel.numberOfLines = 4;
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@ %@\n%@",
										 self.orgItem.street,
										 self.orgItem.city,
										 self.orgItem.state,
										 self.orgItem.zip];
			break;
		default:
			break;
	}
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.orgItem == nil ? 0 : NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = 0;
	switch (section) {
		case kDirections:
			rows = [self.directions count];
			break;
        case kImage:
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
	[self.table.superview performSelector:@selector(disableMapSelections)];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == kURL) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.orgItem.url]];
	}
}


#pragma mark -
#pragma mark Accessors

- (void)setOrgItem:(OrganizationItem *)newHotel {
	if (orgItem != newHotel) {
		orgItem = newHotel;
	}
	[self.table reloadData];
    //[self.view layoutSubviews];
    [self.table setNeedsDisplay];
}

- (NSArray *)directions {
	if (directions == nil) {
		directions = [[NSArray alloc] initWithObjects:@"Directions To Here", @"Directions From Here", nil];
	}
	return directions;
}


@end
