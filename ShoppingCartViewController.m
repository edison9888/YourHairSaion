//
//  ShoppingCartViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "DataAdapter.h"
#import "ProductShowingDetail.h"
#import "PsDetailViewControllerBase.h"
#import "RootViewController.h"
#import "StatementViewController2.h"
@interface ShoppingCartViewController ()
- (IBAction)showStatement;
@property (nonatomic, retain) IBOutlet UILabel *labelPage;
@property (nonatomic, strong)UIImageView* ivBg;

@end

@implementation ShoppingCartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = nil;
    self.ivBg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.ivBg.image = [UIImage imageNamed:@"paper_left.png"];
    self.ivBg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:self.ivBg atIndex:0];
    [self reloadData];
    self.labelPage.text = [NSString stringWithFormat:@"- PAGE %d -", [self indexInPage]+1];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"shoppingCartTableCell";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"ShoppingCartTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    ShoppingCartTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShoppingCartTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.deleage = self;
    [cell fillData:self.items[indexPath.row]];
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (self.lastSelectedIndex != -1)
    {
        ShoppingCartTableCell* cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelectedIndex inSection:0]];
        [cell setStateNormal];
        
    }
    self.lastSelectedIndex = indexPath.row;
    ShoppingCartTableCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setStateSelected];
    [self.detailViewController setItem:self.items[indexPath.row]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.items count] > 0 && self.lastSelectedIndex < 0)
    {
        [self.detailViewController setItem:self.items[0]];
    }
}
- (void)reloadData
{
    self.lastSelectedIndex = -1;
    [self reloadCoreData];
    [self.tableView reloadData];
}

- (void)reloadCoreData
{
    self.items = [NSMutableArray array];
    DataAdapter* da = [DataAdapter shareInstance];
    [[DataAdapter shareInstance]setFilterByTypeId:STRING_FOR_SHOPPING_CART_FILTER];
    int count = [da count];
    for (int i = 0; i < count; i ++)
    {
        [self.items addObject:[ProductShowingDetail initByIndex:i]];
    }
}

- (NSUInteger)indexInPage
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = cell.frame;
    rect = cell.bounds;
    return cell.frame.size.height;
}

- (void)productReductTo0:(ProductShowingDetail *)psd
{
    [self reloadCoreData];
    NSIndexPath* path = [NSIndexPath indexPathForRow:self.lastSelectedIndex inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    path = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([self.tableView cellForRowAtIndexPath:path] != nil)
    {
        [self tableView:self.tableView didSelectRowAtIndexPath:path];
    }
    else
    {
        self.lastSelectedIndex = -1;
    }
}

- (void)showStatement
{
    NSLog(@"%s", __FUNCTION__);
    [self.rootViewController showStatement];
    
}
@end
