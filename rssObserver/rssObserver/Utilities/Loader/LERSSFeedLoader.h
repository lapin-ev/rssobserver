//
//  LERSSFeedLoader.h
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LESuccessBlock)(NSXMLParser *response);
typedef void (^LEFailureBlock)(NSError *error);

@interface LERSSFeedLoader : NSObject

+ (void) requestData:(LESuccessBlock)block failure:(LEFailureBlock)failure;


@end
