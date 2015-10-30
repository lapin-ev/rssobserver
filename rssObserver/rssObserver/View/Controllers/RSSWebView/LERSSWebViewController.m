//
//  LERSSWebViewController.m
//  rssObserver
//
//  Created by Jack Lapin on 29.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LERSSWebViewController.h"
#import "LERSSWebView.h"

@interface LERSSWebViewController ()

@property (weak, nonatomic) IBOutlet LERSSWebView *webView;


@end

@implementation LERSSWebViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailItem.url]];
        [self.webView loadRequest:request];
      //  self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

@end
