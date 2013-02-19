//
//  WYHTTPClient.m
//  iWooyun
//
//  Created by hqdvista on 2/18/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYHTTPClient.h"
#import "AFJSONRequestOperation.h"
@implementation WYHTTPClient

+ (WYHTTPClient *)sharedClient
{
    static WYHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WYHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.wooyun.org/"]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
	//[self setDefaultHeader:@"Accept" value:@"text/html"];
    
    return self;
}

@end