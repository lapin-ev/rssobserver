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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeDataReadble:)
                                                     name:NotificationDataFileContentDidChange object:nil];
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

- (void)requestData{
    [LERSSFeedLoader requestData:^(NSXMLParser *response) {
        NSXMLParser *parser = response;
        RSSXMLParcer *parserDelegate = [[RSSXMLParcer alloc] init];
        [parser setDelegate:parserDelegate];
        [parser parse];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)makeDataReadble:(NSNotification *)notification{
    NSMutableArray *arrOfNotificationObject = notification.object;
    NSMutableArray *arrOfModels = [NSMutableArray array];
    for (int i = 0; i < arrOfNotificationObject.count; i++){
        NSDictionary *dict = (NSDictionary *)[arrOfNotificationObject objectAtIndex:i];
        LERSSModel *model = [[LERSSModel alloc] init];
        NSCharacterSet *titleCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n            "];
        NSCharacterSet *autorCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n      \t\t\t\t\t\t\t\t\t\t      "];
        NSCharacterSet *linkCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n      "];
        NSCharacterSet *pubDateCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n                        "];
        NSDateFormatter* df = [NSDateFormatter new];
        [df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss vvv"];
        
        NSString *title = [[dict objectForKey:kRSSModelTitle] stringByTrimmingCharactersInSet:titleCharactersSet];
        NSString *author = [[dict objectForKey:kRSSModelAuthor] stringByTrimmingCharactersInSet:autorCharactersSet];
        NSString *link = [[dict objectForKey:kRssModelURL] stringByTrimmingCharactersInSet:linkCharactersSet];
        NSString *pubDate = [[dict objectForKey:kRSSModelPubDate] stringByTrimmingCharactersInSet:pubDateCharactersSet];
        
        NSString *imgUrlString = [dict objectForKey:@"description"];
        imgUrlString = [imgUrlString substringFromIndex:[imgUrlString rangeOfString:@"src='"].location + [@"src='" length]];
        imgUrlString = [imgUrlString substringToIndex:[imgUrlString rangeOfString:@"' />   "].location];
        [model createRSSModelwithTitle:title pubDate:pubDate author:author image:imgUrlString url:link];
        [arrOfModels addObject:model];
    }
    if (arrOfModels.count > 0) {
        self.rssModelsArray = arrOfModels;
        if ([self.delegate respondsToSelector:@selector(dataWasChanged:)]) {
            [self.delegate dataWasChanged:self];
        }
    }
}

@end
