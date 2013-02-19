//
//  WYServiceImpl.m
//  iWooyun
//
//  Created by hqdvista on 2/18/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYServiceImpl.h"
#import "WYService.h"
#import "WYHTTPClient.h"
#import "JSONKit.h"
#import "WYBugDetailImpl.h"
#import "WYBug.h"
@interface WYServiceImpl ()

@end

@implementation WYServiceImpl 

+(void) getBugDetailByUrl:(NSString *)url :(WYDetailCallbackBlock)block
{
    [WYBugDetailImpl bugDetailBy:url withBlock:block];
}
+(void) getNewestBugsByType:(NSString *)type :(WYCallbackBlock)block;
{
    NSString *realpath;
    if (type == nil) {
        realpath = @"bugs";
    }
    else
    {
        realpath = [NSString stringWithFormat:@"bugs/%@", type];
    }
    NSLog(@"requesting path:%@",realpath);
    [[WYHTTPClient sharedClient] getPath:realpath parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSMutableArray *array = [[NSMutableArray alloc] init];
                                             NSArray *pros = [JSON objectFromJSONData];
                                             for (NSDictionary *dict in pros) {
                                                 [array addObject:[[WYBug alloc] initWithDict:dict]];
                                             }
                                             
                                             if (block) {
                                                 block(array,nil);
                                                 ;
                                             }
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"error %@",[error description]);
                                             if (block) {
                                                 block(nil, error);
                                             }
                                         }];
}
+(void) getNewestSubmittedBugs:(WYCallbackBlock)block
{
    
}

+(void) getNewestBugs:(WYCallbackBlock)block
{
}
+(void) getNewestPublicBugs:(WYCallbackBlock)block
{
    
}

+(void) getNewestConfirmedBugs:(WYCallbackBlock)block
{
    
}


+(void) getNewestUnclaimBugs:(WYCallbackBlock)block
{
    
}
@end
