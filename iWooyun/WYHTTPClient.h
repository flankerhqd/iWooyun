//
//  WYHTTPClient.h
//  iWooyun
//
//  Created by hqdvista on 2/18/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "AFHTTPClient.h"

@interface WYHTTPClient : AFHTTPClient

+ (WYHTTPClient *)sharedClient;

@end
