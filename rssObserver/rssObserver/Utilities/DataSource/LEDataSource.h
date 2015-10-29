//
//  LEDataSource.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ApplcationPathes.h"

@class LECMFactory;

@protocol rssDataSourceDelegate;

@interface LEDataSource : NSObject

@property (weak, nonatomic) id<rssDataSourceDelegate>delegate;

- (instancetype)initWithDelegate:(id<rssDataSourceDelegate>)delegate;

- (NSUInteger)countModels;
- (LERSSModel *)modelForIndex:(NSInteger)index;

@end

@protocol rssDataSourceDelegate <NSObject>

@required

- (void)dataWasChanged:(LEDataSource *)dataSource;

@end
