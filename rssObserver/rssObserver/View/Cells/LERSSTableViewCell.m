//
//  LERSSTableViewCell.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LERSSTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+AppColors.h"

@interface LERSSTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *modelTitle;
@property (nonatomic, weak) IBOutlet UILabel *modelPubDate;
@property (nonatomic, weak) IBOutlet UILabel *modelAuthor;
@property (nonatomic, weak) IBOutlet UIImageView *modelImage;

@end

@implementation LERSSTableViewCell

-(void)configWithModel:(LERSSModel *)model{
    self.modelTitle.text = [model valueForKey:kRSSModelTitle];
    self.modelPubDate.text = [model valueForKey:kRSSModelPubDate];
    self.modelAuthor.text = [model valueForKey:kRSSModelAuthor];
    NSURL *imageURL = [model valueForKey:kRssModelImage];
    [self.modelImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"NoImage"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor randomColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
