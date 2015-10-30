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
    if (self.itemsArray.count>0){
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDataFileContentDidChange object:self.itemsArray];
    }
}

@end

