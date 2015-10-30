//
//  LERSSTableViewController.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LERSSTableViewController.h"
#import "LERSSModel.h"
#import "LEDataSource.h"
#import "LERSSTableViewCell.h"

@interface LERSSTableViewController () <rssDataSourceDelegate>

@property (nonatomic, strong) LEDataSource *dataSource;

@end

@implementation LERSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[LEDataSource alloc] initWithDelegate:self];
    [self.dataSource requestData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource countModels];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([LERSSTableViewCell class]);
    LERSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSInteger index=indexPath.row;
    [cell configWithModel:[self.dataSource modelForIndex:index]];
    return cell;
}

#pragma mark - rssDataSourceDelegate

- (void)dataWasChanged:(LEDataSource *)dataSource {
    [self.tableView reloadData];
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
