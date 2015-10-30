//
//  LEDataSource.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEDataSource.h"
#import "LERSSFeedLoader.h"
#import "RSSXMLParcer.h"

@interface LEDataSource ()

@property (strong, nonatomic) NSMutableArray *rssModelsArray;

@end


@implementation LEDataSource

#pragma mark - Lifecycle

- (instancetype)initWithDelegate:(id<rssDataSourceDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadArrayWithPlist)
        //                                                     name:NotificationDataFileContentDidChange object:nil];
        self.rssModelsArray = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - DataSource methods

- (NSUInteger)countModels {
    return [self.rssModelsArray count];
}

- (LERSSModel *)modelForIndex:(NSInteger)index {
    LERSSModel * model = [LERSSModel new];
    model = (LERSSModel*)[self.rssModelsArray objectAtIndex:index];
    return model;
}

#pragma mark - DataManage methods

- (LERSSModel *)addNewModelWithDictData:(NSDictionary *)dict {
    LERSSModel *model = [[LERSSModel alloc] init];
    return model;
}

- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [LERSSFeedLoader requestData:^(NSXMLParser *response) {
        NSXMLParser *parser = response;
        RSSXMLParcer *parserDelegate = [[RSSXMLParcer alloc] init];
        [parser setDelegate:parserDelegate];
        
        [parser parse];

    
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)parseDataDictionary:(NSDictionary *)dict{
    
}

//+ (void)addCM:(LECMFactory *)cmObject {
//    NSDictionary *newModel = [cmObject dictionaryFromModelRepresentation:cmObject];
//    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:[NSString documentsFolderPath]];
//    [tempModelsArray addObject:newModel];
//
//    if ([tempModelsArray writeToFile:[NSString documentsFolderPath] atomically:YES]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDataFileContentDidChange object:nil];
//    } else {
//        NSLog(@"New object not added");
//    }
//}

@end
