//
//  CheckUpdateViewController.m
//  iWooyun
//
//  Created by hqdvista on 2/20/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "CheckUpdateViewController.h"
#import "WYServiceImpl.h"
@interface CheckUpdateViewController ()

- (UILabel*)makeLabelWithText: (NSString*)text :(int)count;

@property (strong, nonatomic)   UIActivityIndicatorView     *indicator;
@property (strong, nonatomic)   UILabel    *updatingLabel;


@end

@implementation CheckUpdateViewController

- (UILabel*) makeLabelWithText:(NSString *)text :(int)count
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f + 50.0f*count, 300.0f, 44.0f)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
    [label setNumberOfLines:0];
    return label;
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
      
    [self.view addSubview:[self makeLabelWithText:[NSString stringWithFormat:@"iWooyun version %@", VERSIONSTR]:0]];
    [self.view addSubview:[self makeLabelWithText:@"Author hqdvista, thanks to SegmentFault devs.":1]];
    if (self.updatingLabel == nil) {
         self.updatingLabel = [self makeLabelWithText:@"checking for update...":2];
        [self.view addSubview:self.updatingLabel];
    }
    if (self.indicator == nil) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.frame = CGRectMake(self.view.width / 2 - 20.0f, self.view.height / 2 - 60.0f, 40.0f, 40.0f);
        [self.view addSubview:self.indicator];
        [self.indicator startAnimating];
    }
    
    
    [WYServiceImpl checkClientUpdate:^(NSDictionary *detail, NSError *error){
        if (detail != nil) {
            [self.indicator stopAnimating];
            [self.indicator removeFromSuperview];
            int newversion = [[detail objectForKey:@"versionNum"] intValue];
            if (newversion > VERSIONNUM) {
                self.updatingLabel.text = [NSString stringWithFormat:@"Newest version: %@, please check %@", [detail objectForKey:@"versionName"],[detail objectForKey:@"sourceurl"]   ];
                [self.updatingLabel setTextColor:[UIColor greenColor]];
                /*
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New version avaliable"
                                                                message:[detail objectForKey:@"update"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                 */
            }
            else
            {
                self.updatingLabel.text = @"Already newest version";
            }
        }
        else
        {
            self.updatingLabel.text = @"Cannot get update information";
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
