//
//  LERSSModel.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LERSSModel.h"

@interface LERSSModel()

@property(nonatomic, strong, readwrite) NSString *title;
@property(nonatomic, strong, readwrite) NSString *pubDate;
@property(nonatomic, strong, readwrite) NSString *author;
@property(nonatomic, strong, readwrite) NSString *image;

@end

@implementation LERSSModel

-(LERSSModel *)createRSSModelwithTitle:(NSString *)title pubDate:(NSString *)pubDate author:(NSString *)author image:(NSString *)imageURLString url:(NSString *)url{
    LERSSModel * model = [[LERSSModel alloc] init];
    if (model){
        _title = title;
        _pubDate = pubDate;
        _author = author;
        _image = imageURLString;
        _url = url;
    }
    return model;
}


@end
