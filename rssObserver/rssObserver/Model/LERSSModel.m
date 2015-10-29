//
//  LERSSModel.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LERSSModel.h"
#import <objc/runtime.h>

@interface LERSSModel()

@property(nonatomic, strong, readwrite) NSString *title;
@property(nonatomic, strong, readwrite) NSString *pubDate;
@property(nonatomic, strong, readwrite) NSString *author;
@property(nonatomic, strong, readwrite) NSString *image;

@end

@implementation LERSSModel

-(LERSSModel *)createRSSModelwithTitle:(NSString *)title
                               pubDate:(NSString *)pubDate
                                author:(NSString *)author
                                 image:(NSString *)imageURLString
                                   url:(NSString *)url{
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

-(NSString *)description{
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        char const *propertyName = property_getName(properties[i]);
        const char *attr = property_getAttributes(properties[i]);
        if (attr[1] == '@') {
            NSString *selector = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            SEL sel = sel_registerName([selector UTF8String]);
            id gSelf = self;
            NSObject * propertyValue = objc_msgSend(gSelf, sel);
            if (propertyValue.description) {
                propertyValues[selector] = propertyValue.description;
            }
        }
    }
    free(properties);
    return [NSString stringWithFormat:@"%@: %@", self.class, propertyValues];
}


@end
