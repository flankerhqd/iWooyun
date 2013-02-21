//
//  WYBugDetailViewController.m
//  iWooyun
//
//  Created by hqdvista on 2/20/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYBugDetailViewController.h"
#import "WYLocalWebView.h"
#import "WYServiceImpl.h"
#define SECTION_HEADER_HEIGHT   31.0f

@interface WYBugDetailViewController ()
<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

//@property (strong, nonatomic)   WYLocalWebView              *answerView;
@property (strong, nonatomic)   UIActivityIndicatorView     *indicator;
@property (strong, nonatomic)   NSString                    *questionId;
@property (strong, nonatomic)   WYLocalWebView              *questionView;
@property (strong, nonatomic)   UITableView                 *tableView;

- (void)reloadData;

@end

@implementation WYBugDetailViewController

#pragma mark - private

- (void)reloadData
{
    if (nil == self.questionView) {
        self.questionView = [[WYLocalWebView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 44.0f)];
        self.questionView.navigator = self.navigator;
        NSString*filePath=[[NSBundle mainBundle] pathForResource:@"BugDetail.html" ofType:@"txt"];
        NSString *detailHTML = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]; 
        [self.questionView loadHTMLString:[NSString stringWithFormat:detailHTML, [self.bugInfo objectForKey:@"content"]] baseURL:[NSURL URLWithString:@"http://www.wooyun.org/"]];
        //notice we may need to change the baseURL in future
    }
    /*
    if (nil == self.answerView) {
        self.answerView = [[WYLocalWebView alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 300.0f, 44.0f)];
        self.answerView.navigator = self.navigator;
        NSString*filePath=[[NSBundle mainBundle] pathForResource:@"AnswerDetail.html" ofType:@"txt"];
        NSString *detailHTML = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [self.answerView loadHTMLString:[NSString stringWithFormat:detailHTML, [self.bugInfo objectForKey:@"answers"]] baseURL:nil];
    }
     */
    
    self.questionView.top = SECTION_HEADER_HEIGHT;
    [self.tableView addSubview:self.questionView];
    /*
    self.answerView.top = self.questionView.bottom + SECTION_HEADER_HEIGHT;
    [self.tableView addSubview:self.answerView];
     */
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *cellIndentifier = @"WYBugDetailCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"question_detail_section_header_background.png"]];
    bg.frame = CGRectMake(0.0f, 0.0f, 320.0f, SECTION_HEADER_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, SECTION_HEADER_HEIGHT)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(202.0f, 190.0f, 172.0f);
    if (0 == section) {
        label.font = [UIFont boldSystemFontOfSize:12.0f];
        label.numberOfLines = 0;
        label.text = ([[self.params allKeys] containsObject:@"qtitle"] && 0 < [[self.params objectForKey:@"qtitle"] length])
        ? [self.params objectForKey:@"qtitle"]
        : @"详情";
    }/*
    else if (1 == section) {
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.text = [NSString stringWithFormat:@"答案（%@）", [self.params objectForKey:@"answers"]];
    }
      */
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0.0f, -1.0f);
    [bg addSubview:label];
    return (UIView *)bg;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section && 0 == indexPath.row) {
        if (self.questionView && 0.0f < self.questionView.height) {
            return self.questionView.height + 10.0f;
        }
    }
    /*
    else if (1 == indexPath.section && 0 == indexPath.row) {
        if (self.answerView && 0.0f < self.answerView.height) {
            return self.answerView.height + 10.0f;
        }
    }
    */
    return 54.0f;
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (nil == self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.height -= 44.0f;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }
    
    if (nil == self.indicator) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.frame = CGRectMake(self.tableView.width / 2 - 20.0f, self.tableView.height / 2 - 60.0f, 40.0f, 40.0f);
        [self.view addSubview:self.indicator];
        [self.indicator startAnimating];
    }
    [WYServiceImpl getBugDetailByUrl:[self.params objectForKey:@"url"] :^(NSDictionary *detail, NSError *error) {
        self.bugInfo = detail;
        [self reloadData];
        [self.indicator removeFromSuperview];
        self.indicator = nil;
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WYNotificationContentLoaded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:WYNotificationContentLoaded object:nil];
    /*
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SFNotificationQuestionLoaded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:SFNotificationQuestionLoaded object:nil];
     */
}

@end
