//
//  LERSSModel.h
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LERSSModel : NSObject

@property(nonatomic, strong, readonly) NSString *title;
@property(nonatomic, strong, readonly) NSString *pubDate;
@property(nonatomic, strong, readonly) NSString *author;
@property(nonatomic, strong, readonly) NSString *image;
@property(nonatomic, strong, readonly) NSString *url;

-(LERSSModel *)createRSSModelwithTitle:(NSString *)title
                               pubDate:(NSString *)pubDate
                                author:(NSString *)author
                                 image:(NSString *)imageURLString
                                   url:(NSString *)url;



@end
