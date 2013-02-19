//
//  WYBug.m
//  iWooyun
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYBug.h"
@interface WYBug()
@property (strong,nonatomic) NSDictionary *statusDict;
@end

@implementation WYBug

- (NSString*)translateCorpStatus
{
    if (_statusDict == nil) {
        _statusDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:WAIT_FOR_CONFIRM],@"待厂商确认处理",[NSNumber numberWithUnsignedInteger:CONFIRMED],@"厂商已经确认", [NSNumber numberWithUnsignedInteger:IGNORED],@"漏洞通知厂商但厂商忽略",[NSNumber numberWithUnsignedInteger:UNABLE_TO_CONTACT],@"未联系到厂商或厂商忽略",[NSNumber numberWithUnsignedInteger:WAIT_FOR_CLAIM],@"正在联系厂商并等待认领",nil];
    }

    return [_statusDict objectForKey:[NSNumber numberWithUnsignedInteger:_status]];
}

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _title = [dict objectForKey:@"title"];
        //NSLog(@"%@", [[dict objectForKey:@"status"] class]);
        
        _status = [(NSString*)[dict objectForKey:@"status"] intValue] ;
        
        _user_harmlevel = [[dict objectForKey:@"user_harmlevel"] intValue];
        _corp_harmlevel = [[dict objectForKey:@"corp_harmlevel"] intValue];
        _corp_rank = [[dict objectForKey:@"corp_rank"] intValue];
        _comment_n = [[dict objectForKey:@"comment"] intValue];
        _link = [dict objectForKey:@"link"];
    }
    return self;
}
@end
