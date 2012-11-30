//
//  PsDetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDetailViewController.h"
#import "PsDetailViewController.h"
#import "PsDataItem.h"
#import "PsViewController.h"

typedef enum {
    kImage,
	NUMBER_OF_SECTIONS
} TableSections;



@interface PsDetailViewController ()

@end

@implementation PsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"PsDetailViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
//    self.table.bounds = CGRectMake(0, 0, 340, 600);
//    self.table.center = self.view.center;
	//[self.table reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.table.bounds = CGRectMake(0, 0, 340, 600);
//    self.table.center = self.view.center;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
	if (cell == nil) {
		if ([workingCellIdentifier isEqualToString:kImageCellIdentifier])
        {
            cell = [[ImageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kImageCellIdentifier];
        }
		else {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:workingCellIdentifier];
		}
	}
	
	switch (indexPath.section) {
        case kImage:
            [((ImageTableCell*)cell) setImage:self.item.imgLink];
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
			rows = 1;
			break;
		default:
			break;
	}
	return rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Accessors

- (void)setItem:(PsDataItem *)dataItem {
    [super setItem:dataItem];
	[self.table reloadData];
    [self.table setNeedsDisplay];
}

@end

