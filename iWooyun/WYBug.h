//
//  WYBug.h
//  iWooyun
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum CorpStatus : NSUInteger{
    WAIT_FOR_CONFIRM=0,
    CONFIRMED,
    IGNORED,
    UNABLE_TO_CONTACT,
    WAIT_FOR_CLAIM,
}CoprStatus;

typedef enum HarmLevel : NSUInteger{
    LOW,
    MEDIUM,
    HIGH
}HarmLevel;
@interface WYBug : NSObject

@property (strong,nonatomic) NSString *title;
@property (nonatomic) enum CorpStatus status;
@property (nonatomic) NSInteger user_harmlevel;
@property (nonatomic) NSInteger corp_harmlevel;
@property (nonatomic) NSInteger corp_rank;
@property (nonatomic) NSInteger comment_n;
@property (strong,nonatomic) NSString *datestr;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic) NSString *link;

- (NSString*)translateCorpStatus;
- (id) initWithDict: (NSDictionary*)dict;
@end
