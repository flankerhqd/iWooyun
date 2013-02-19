//
//  WYBugDetailImpl.h
//  iWooyun
//
//  Created by hqdvista on 2/19/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYService.h"

@interface WYBugDetailImpl : NSObject

+ (void)bugDetailBy:(NSString *)url
               withBlock:(WYDetailCallbackBlock)block;

@end
