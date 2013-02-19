//
//  WYBugsListViewController.m
//  iWooyun
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYBugsListViewController.h"
#import "SRRefreshView.h"
#import "WYBug.h"
#import "WYServiceImpl.h"

@interface WYBugsListViewController ()

<UITableViewDataSource, UITableViewDelegate, SRRefreshDelegate>

- (void)appendBugs:(NSArray *)bugs;
- (void)didLogout;

@property (assign, nonatomic)   BOOL                  hasMore;
@property (assign, nonatomic)   BOOL                  loading;
@property (strong, nonatomic)   NSString              *list;
@property (assign, nonatomic)   NSInteger             page;
@property (strong, nonatomic)   UITableView           *tableView;
@property (strong, nonatomic)   SRRefreshView         *slimeView;

@end

@implementation WYBugsListViewController


#pragma mark - private

// 把问题接在后边
- (void)appendBugs:(NSArray *)bugs
{
    self.hasMore = YES;
    if (nil != bugs) {
        if (30 > [bugs count]) {
            self.hasMore = NO;
        }
        if (nil == self.bugslist) {
            self.bugslist = [[NSMutableArray alloc] initWithArray:bugs];
        }
        else {
            [self.bugslist addObjectsFromArray:bugs];
        }
    }
    self.loading = NO;
    [self.tableView reloadData];
}

- (void)didLogout
{
    [self.bugslist removeAllObjects];
    [self.tableView reloadData];
    [self.navigator popToRootViewControllerAnimated:NO];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    if (indexPath.row < [self.bugslist count]) {
        CellIdentifier = @"WooyunBugListCell";
    }else {
        CellIdentifier = @"WooyunBugLoadingCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.row < [self.bugslist count]) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qlist_cell_selected_background.png"]];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            
            UILabel *answersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 4.0f, 30.0f, 14.0f)];
            answersLabel.tag = 1000001;
            answersLabel.backgroundColor = [UIColor clearColor];
            answersLabel.textAlignment = NSTextAlignmentCenter;
            answersLabel.textColor = [UIColor whiteColor];
            answersLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            [cell.imageView addSubview:answersLabel];
        }
        
        if (0 == [[self.bugslist objectAtIndex:indexPath.row] comment_n]) {
            cell.imageView.image = [UIImage imageNamed:@"qlist_cell_pop_unanswered.png"];
        }
        else {
            cell.imageView.image = [UIImage imageNamed:@"qlist_cell_pop.png"];
        }
        __weak UILabel *answersLabel = (UILabel *)[cell.imageView viewWithTag:1000001];
        answersLabel.text = [NSString stringWithFormat:@"%d", [[self.bugslist objectAtIndex:indexPath.row] comment_n]];
        cell.textLabel.text = [[self.bugslist objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [[self.bugslist objectAtIndex:indexPath.row] datestr];
    }
    else {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"Loading ...";
            cell.textLabel.numberOfLines = 1;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            [cell.imageView removeAllSubviews];
            cell.imageView.image = nil;
            cell.detailTextLabel.text = @"";
        }
        
        /*
        if (! self.loading && self.hasMore) {
            self.page ++;
            [SFQuestionService getQuestionList:self.list onPage:self.page withBlock:^(NSArray *questions, NSError *error) {
                if (5 == error.code) {
                    ;;
                } else if (0 == error.code) {
                    [self appendQuestions:questions];
                }
            }];
            self.loading = YES;
        }
        */
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigator openURL:[[NSURL URLWithString:@"wy://bugdetail"] addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                     [[self.bugslist objectAtIndex:indexPath.row] link], @"url",
                                                                                     @"漏洞详情", @"title",
                                                                                     nil]]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hasMore && 0 < [self.bugslist count] ? [self.bugslist count] + 1 : [self.bugslist count];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    self.page = 1;
    if (! self.loading) {
        [WYServiceImpl getNewestBugsByType: [self.params objectForKey:@"type"] :^(NSArray *bugs, NSError *error) {
            if (bugs != nil) {
                [self.bugslist removeAllObjects];
                [self appendBugs:bugs];
            }
            else
            {
                if (error != nil) {
                    
                }
            }
            [self.slimeView endRefresh];
        }];
    }
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (nil == self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height - 44.0f)
                                                      style:UITableViewStylePlain];
        
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.slimeView = [[SRRefreshView alloc] init];
        self.slimeView.delegate = self;
        self.slimeView.slimeMissWhenGoingBack = YES;
        self.slimeView.slime.bodyColor = RGBCOLOR(0, 154, 103); // 换成SF绿
        self.slimeView.slime.skinColor = RGBCOLOR(0, 154, 103); // 换成SF绿
        [self.tableView addSubview:_slimeView];
        
        [self.view addSubview:self.tableView];
    }
    
    self.page = 1;
    [self.slimeView setLoadingWithexpansion];
    [WYServiceImpl getNewestBugsByType: [self.params objectForKey:@"type"] :^(NSArray *bugs, NSError *error) {
        if (bugs != nil) {
            [self.bugslist removeAllObjects];
            [self appendBugs:bugs];
        }
        else
        {
            if (error != nil) {
                
            }
        }
        [self.slimeView endRefresh];
    }];
    self.loading = YES;
    self.hasMore = YES;
}

@end
