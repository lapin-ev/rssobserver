//
//  RSSXMLParcer.m
//  rssObserver
//
//  Created by Jack Lapin on 30.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "RSSXMLParcer.h"
#import <Foundation/Foundation.h>

static NSString* kItemElementName = @"item";

@interface RSSXMLParcer()

@property (nonatomic, strong) NSMutableArray * itemsArray;
@property (nonatomic, strong) NSMutableString * currentElementString;
@property (nonatomic, strong) NSMutableDictionary * currentItemDictionary;

@end

@implementation RSSXMLParcer


- (void) parserDidStartDocument:(NSXMLParser *)parser {
    self.itemsArray = [NSMutableArray array];
    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kItemElementName]) {
        self.currentItemDictionary = [NSMutableDictionary dictionary];
    }
    self.currentElementString = [NSMutableString string];
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.currentElementString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kItemElementName]) {
        [self.itemsArray addObject:self.currentItemDictionary];
    }
    else {
        [self.currentItemDictionary setObject:self.currentElementString forKey:elementName];
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"parserDidEndDocument");
    [self makeDataReadble:(self.itemsArray)];
}

-(NSArray *)makeDataReadble:(NSMutableArray *)arr{
    NSMutableArray *arrOfModels = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++){
        NSDictionary *dict = (NSDictionary *)[arr objectAtIndex:i];
        LERSSModel *model = [[LERSSModel alloc] init];
        NSCharacterSet *titleCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n            "];
        NSCharacterSet *autorCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n      \t\t\t\t\t\t\t\t\t\t      "];
        NSCharacterSet *linkCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n      "];
        NSCharacterSet *pubDateCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n                        "];
        NSDateFormatter* df = [NSDateFormatter new];
        [df setDateFormat:@"Eee, dd MMM yyyy HH:mm:ss ZZZ"];

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
    return arrOfModels;
}



@end

