//
//  WYWebViewController.m
//  iWooyun
//
//  Created by hqdvista on 2/19/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYWebViewController.h"

@interface WYWebViewController ()

- (void)back;
- (void)dismissKeyboard;

@end

@implementation WYWebViewController

#pragma mark - private

- (void)back
{
    [self.navigator popViewControllerAnimated:YES];
}

- (void)dismissKeyboard
{
    [self.webView endEditing:YES];
}

#pragma mark - parent

- (void)loadRequest {
    if (! [@"http" isEqualToString:[self.url protocol]]) {
        self.url = [NSURL URLWithString:[self.params objectForKey:@"url"]];
    }
    self.url = [NSURL URLWithString:@"http://www.wooyun.org/bugs/wooyun-2013-018907"];
    //NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:self.url];
    //[self.webView loadRequest:requestObj];
    NSLog(@"load reqeust");
    NSError *error;
    NSString *googlePage = [NSString stringWithContentsOfURL:self.url
                                                    encoding:NSUTF8StringEncoding
                                                       error:&error];
    [self.webView loadHTMLString:googlePage baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]];

}

- (void)openedFromViewControllerWithURL:(NSURL *)aUrl
{
    UIButton *navBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [navBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navBtn setBackgroundImage:[UIImage imageNamed:@"back_button_background.png"] forState:UIControlStateNormal];
    [navBtn setBackgroundImage:[UIImage imageNamed:@"back_button_pressed_background.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:navBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
}

#pragma mark - WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    NSLog(@"view finished loading");
    //[webView stringByEvaluatingJavaScriptFromString:
    // @"document.body.removeChild(document.getElementById('header'));document.body.removeChild(document.getElementById('footer'));"];
    
    if (! [[self.params allKeys] containsObject:@"title"] || 0 >= [[self.params objectForKey:@"title"] length]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGBCOLOR(92.0f, 92.0f, 92.0f);
        label.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        [label sizeToFit];
        self.navigationItem.titleView = label;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    /*
    // 如果是退出请求 http://segmentfault.com/user/logout ，拦截
    if ([@"segmentfault.com" isEqualToString:[request.URL host]]
        && [@"/user/logout" isEqualToString:[request.URL path]]) {
        return NO;
    }
     */
    return YES;
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"wywebview loaded");
    /*
    if (! [@"login" isEqualToString:[self.url host]]
        && 1 == [[self.params objectForKey:@"login"] intValue]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SFNotificationLogout object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadRequest) name:SFNotificationLogout object:nil];
    }
     */
    
    /*
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UMNotificationWillShow object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard) name:UMNotificationWillShow object:nil];
    */
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBCOLOR(92.0f, 92.0f, 92.0f);
    
    if ([[self.params allKeys] containsObject:@"title"] && 0 < [[self.params objectForKey:@"title"] length]) {
        label.text = [self.params objectForKey:@"title"];
    }
    else {
        label.text = @"Loading...";
    }
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

@end
