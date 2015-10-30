//
//  DetailViewController.h
//  TestMasterDetail
//
//  Created by Jack Lapin on 30.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

