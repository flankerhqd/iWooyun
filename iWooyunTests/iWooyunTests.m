//
//  iWooyunTests.m
//  iWooyunTests
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "iWooyunTests.h"
#include "AFNetworking.h"
#include "JSONKit.h"
#include "WYServiceImpl.h"
#include "WYService.h"
@implementation iWooyunTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testModel
{
    /*
    NSURL *url = [NSURL URLWithString:@"http://api.wooyun.org/bugs"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"in test");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);   
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON Stream: %@", JSON);
        NSDictionary *result = [JSON objectFromJSONString];
        NSLog(@"%@",[result description]);
        dispatch_semaphore_signal(semaphore);     
    } failure:nil];
    
    [operation start];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
     */
    WYServiceImpl *service = [[WYServiceImpl alloc] init];
    [service getNewestBugs:^(NSArray *bugs, NSError *error) {
        NSLog(@"response array: %@",[bugs description]);
    }];
}

@end
