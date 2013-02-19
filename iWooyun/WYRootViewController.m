//
//  WooyunViewController.m
//  iWooyun
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYRootViewController.h"

@interface WYRootViewController ()

// 用来记录将要打开的URL
@property (nonatomic, strong)   NSURL *toOpen;

- (void)back;

@end

@implementation WYRootViewController


#define NAVIGATION_BAR_BTN_RECT         CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)

#pragma mark subclass from UMRootViewController
- (id)initWithURL:(NSURL *)aUrl
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.url = aUrl;
        self.params = [aUrl params];
        self.title = [self.params objectForKey:@"title"];
    }
    return self;
}
#pragma mark - private

- (void)back
{
    [self.navigator popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = [self.params objectForKey:@"title"];
    
    /*
    UIButton *btnA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnA.frame = CGRectMake(10.0f, 10.0f, 300.0f, 44.0f);
    [btnA setTitle:@"wy://bugs" forState:UIControlStateNormal];
    [btnA addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnA];
    
    UIButton *btnB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnB.frame = CGRectMake(10.0f, 60.0f, 300.0f, 44.0f);
    [btnB setTitle:@"bad://donotopen/wrong/path/?notopen=1" forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnB];
    
    NSLog(@"self url:%@", self.url.absoluteString);
    NSLog(@"Params:%@", self.params);
     
     */
    
    UIButton *hNavBtn = [[UIButton alloc] initWithFrame:NAVIGATION_BAR_BTN_RECT];
    [hNavBtn setBackgroundImage:[UIImage imageNamed:@"slide_navigator_button.png"] forState:UIControlStateNormal];
    [hNavBtn setBackgroundImage:[UIImage imageNamed:@"slide_navigator_button_pressed.png"] forState:UIControlStateHighlighted];
    [hNavBtn addTarget:nil action:@selector(slideButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hBtnItem = [[UIBarButtonItem alloc] initWithCustomView:hNavBtn];
    self.navigationItem.leftBarButtonItem = hBtnItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)open:(UIButton *)btn
{
    [self.navigator openURL:[NSURL URLWithString:btn.titleLabel.text]];
}

- (void)openedFromViewControllerWithURL:(NSURL *)aUrl
{
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    NSLog(@"Opend From:%@", aUrl.absoluteString);
}

- (BOOL)shouldOpenViewControllerWithURL:(NSURL *)aUrl
{
    /*
    // if it will open bad://donotopen/wrong/path/?notopen=1
    if ([@"bad" isEqualToString:[aUrl scheme]]
        || [@"donotopen" isEqualToString:[aUrl host]]
        || [@"1" isEqualToString:[[aUrl params] objectForKey:@"notopen"]]
        || [[aUrl path] containsString:@"/wrong/"]
        ) {
        NSLog(@"do not open.");
        return NO;
    }
     */
    return YES;
}
@end
