//
//  UIColor+AppColors.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "UIColor+AppColors.h"

@implementation UIColor (AppColors)

#pragma mark - Random color

+ (UIColor *)randomColor {
    CGFloat redLevel = rand() / (float) RAND_MAX;
    CGFloat greenLevel = rand() / (float) RAND_MAX;
    CGFloat blueLevel = rand() / (float) RAND_MAX;
    return [UIColor colorWithRed:redLevel green:greenLevel blue:blueLevel alpha:0.1f];
}

@end