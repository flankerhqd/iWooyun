//
//  WYLocalWebView.m
//  iWooyun
//
//  Created by hqdvista on 2/20/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYLocalWebView.h"
#import "UMNavigationController.h"
#import "UMTools.h"
@interface WYLocalWebView ()
<UIWebViewDelegate>

@end

@implementation WYLocalWebView

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString containsString:@"http://"]
        || [request.URL.absoluteString containsString:@"https://"]) {
        [self.navigator openURL:[[NSURL URLWithString:@"wy://webview"]
                                 addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                            request.URL.absoluteString, @"url",
                                            nil]]];
        return NO;
    }
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIScrollView *scrollView = object;
    self.height = scrollView.contentSize.height;
    if (WYContentCell == self.type) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WYNotificationContentLoaded object:nil];
    }
}

#pragma mark - super

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        self.multipleTouchEnabled = NO;
        self.autoresizesSubviews = YES;
        self.type = WYContentCell;
        [(UIScrollView*)[self.subviews objectAtIndex:0] setShowsHorizontalScrollIndicator:NO];
        [(UIScrollView*)[self.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
        [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
        self.delegate = self;
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end

