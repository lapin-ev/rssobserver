//
//  LEDataSource.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEDataSource.h"

@interface LEDataSource ()

@property (strong, nonatomic) NSArray *rssModelsArray;

@end


@implementation LEDataSource

#pragma mark - Lifecycle

- (instancetype)initWithDelegate:(id<rssDataSourceDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadArrayWithPlist)
                                                     name:NotificationDataFileContentDidChange object:nil];
        [self loadArrayWithPlist];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - DataSource methods

- (void)loadArrayWithPlist {
    _rssModelsArray = [NSArray arrayWithContentsOfFile:[NSString documentsFolderPath]];

    if ([self.delegate respondsToSelector:@selector(dataWasChanged:)]) {
        [self.delegate dataWasChanged:self];
    }
    
}


- (NSUInteger)countModels {
    return [self.rssModelsArray count];
}

- (LECMFactory *)modelForIndex:(NSInteger)index {
    LERSSModel * model = [LERSSModel new];
    NSMutableDictionary * dict = (NSMutableDictionary*)[self.rssModelsArray objectAtIndex:index];
//    NSString * 
//    model.name =[dict objectForKey:@"name"];
//    model.imageName =[dict objectForKey:@"imageName"];
    return model;
}

- (void)reloadArrayWithPlist {
    [self loadArrayWithPlist];
}

+ (void)copyPlistToAppDocumentsFolder {
    NSString *documentsPath = [NSString documentsFolderPath];
    NSString *resourcesPath = [NSString resourcesFolderPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    if ([fileManager fileExistsAtPath:documentsPath] == NO) {
        [fileManager copyItemAtPath:resourcesPath toPath:documentsPath error:&error];
    }
}

#pragma mark - DataManage methods

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
