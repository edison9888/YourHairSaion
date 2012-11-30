//
//  StatementViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-28.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "StatementViewController.h"
#import "DataAdapter.h"
#import "ProductViewController.h"
#import "RootViewController.h"
#import "ModelController.h"
typedef enum
{
    kProduct,
    kTotal,
    NUMBER_OF_SECTION
}TableSections;
@interface StatementViewController ()
@property (nonatomic, strong)NSArray* productTypes;
@property (nonatomic, strong)ProductViewController* productViewController;
@property (nonatomic, assign)NSInteger pageIndex;
@end

@implementation StatementViewController
@synthesize productTypes;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setProductViewController:(ProductViewController*)productViewController andIndex:(NSInteger)index;
{
        self.productViewController = productViewController;
        self.pageIndex = index;
}
/*
- (id)init
{
    return [super initWithNibName:@"StatementViewController" bundle:nil];
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return NUMBER_OF_SECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case kProduct:
            return [[DataAdapter shareInstance] totalNumInShoppingCart];
        case kTotal:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = nil;
    DataAdapter *da = [DataAdapter shareInstance];
    NSInteger index = [self convertRow2ProductIndex:indexPath.row];
    switch (indexPath.section)
    {
        case kProduct:
            CellIdentifier = [da ProductIdAtIndex:index];
            break;
        case kTotal:
            CellIdentifier = @"Total" ;
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        switch (indexPath.section)
        {
            case kProduct:
                if (nil == cell.imageView.image)
                {
                    cell.imageView.image = [UIImage imageWithContentsOfFile:[da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_THUMB]];
                }
                cell.textLabel.text = [da captionAtIndex:index];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", [[da priceAtIndex:index] floatValue]];
                break;
            case kTotal:
                CellIdentifier = @"Total" ;
                cell.textLabel.text = @"总价";
                cell.detailTextLabel.text = cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", [da totalPriceInShoppingCart]];
        }
    }
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == kProduct)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSInteger index = [self convertRow2ProductIndex:indexPath.row];
        DataAdapter* da = [DataAdapter shareInstance];
        [da reduceProductToBuy:[da ProductIdAtIndex:index]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSRange rang = NSMakeRange(kTotal, 1);
        NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:rang];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    /*
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
     */
}


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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == kProduct)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.text = @"购买产品如下：";
        [label sizeToFit];
        return label;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case kProduct:
            return 40.0f;
        case kTotal:
            return 10.0f;
        default:
            return 0;
    }
}

- (NSInteger)convertRow2ProductIndex:(NSInteger)rowIndex
{
    DataAdapter *da = [DataAdapter shareInstance];
    int totalIndex = [da.productBasesInShoppingCart count];
    for (int i = 0; i < totalIndex; i ++)
    {
        rowIndex -= [da numInShoppingCart:[da ProductIdAtIndex:i]];
        if (rowIndex < 0)
        {
            return i;
        }
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == kTotal)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.text = @"本价格为产品原价，具体优惠信息请到收银台最终确认。";
        [label sizeToFit];
        return label;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case kTotal:
            return 40.0f;
        default:
            return 0;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    int recodeCount = [[DataAdapter shareInstance] count];
    int itemPerPage = ITEMS_PER_PAGE;
    int pageCount = [ModelController calcPageCount:recodeCount];
    int fromIndex = self.pageIndex / 2 * itemPerPage;
    int toIndex = fromIndex + itemPerPage - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    [self.productViewController setRangWithFromIndex:fromIndex toIndex:toIndex];
    //重新设置页码
    [self.productViewController setPageCount:pageCount];

    //处理原本shoppingcart有n页，现在变n-1页的情况
    if (self.pageIndex/2 > 0 && toIndex < fromIndex)
    {
        [self.productViewController.rootViewController setPage:self.pageIndex - 2 animated:NO];
        [((ProductViewController*)[self.productViewController.rootViewController page:self.pageIndex -2]) setPageCount:pageCount];
    }
}

@end
