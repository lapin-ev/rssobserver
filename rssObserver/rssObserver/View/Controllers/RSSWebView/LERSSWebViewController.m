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

@property (nonatomic, weak) IBOutlet LERSSWebView *webView;
@property (nonatomic, weak) IBOutlet UINavigationController *navigationController;

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;

@end

@implementation LERSSWebViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailItem.url]];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 2) {
        [self.navigationController setNavigationBarHidden:NO];
        self.toolbar.hidden = FALSE;
        [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self   selector:@selector(hidebar) userInfo:nil repeats:NO];
    }
}

- (void)hidebar
{
    [self.navigationController setNavigationBarHidden:YES];
    self.toolbar.hidden = TRUE;
}

@end
