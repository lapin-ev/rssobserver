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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"webContentShow"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LERSSModel *object = [self.dataSource modelForIndex:indexPath.row];
        LERSSWebViewController *controller = (LERSSWebViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

@end
