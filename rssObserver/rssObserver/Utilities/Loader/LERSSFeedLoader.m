//
//  LERSSFeedLoader.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

static NSString *const kRSSBaseURL = @"http://www.cbc.ca/cmlink/rss-topstories";

#import "LERSSFeedLoader.h"
#import <AFNetworking.h>

@implementation LERSSFeedLoader

+ (void) requestData:(LESuccessBlock)block failure:(LEFailureBlock)failure {
    NSString *urlString = kRSSBaseURL;
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    [manager GET:urlString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             block(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             failure(error);
         }];
}


@end
