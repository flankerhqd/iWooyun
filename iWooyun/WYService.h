//
//  WYService.h
//  iWooyun
//
//  Created by hqdvista on 2/18/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WYCallbackBlock) (NSArray *bugs, NSError *error);
typedef void (^WYDetailCallbackBlock) (NSDictionary *detail, NSError *error);
typedef void (^WYUpdateCallbackBlock) (NSDictionary *detail, NSError *error);
@protocol WYService <NSObject>

@required
+(void) getNewestSubmittedBugs: (WYCallbackBlock)block;
+(void) getNewestPublicBugs:(WYCallbackBlock)block;
+(void) getNewestConfirmedBugs:(WYCallbackBlock)block;
+(void) getNewestUnclaimBugs:(WYCallbackBlock)block;
+(void) getNewestBugs:(WYCallbackBlock)block;
+(void) getNewestBugsByType:(NSString *)type :(WYCallbackBlock)block;
+(void) checkClientUpdate:(WYUpdateCallbackBlock)block;
+(void) getBugDetailByUrl:(NSString *)url :(WYDetailCallbackBlock)block;
@end
