//
//  WYTool.m
//  iWooyun
//
//  Created by hqdvista on 2/19/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYTool.h"

@implementation WYTool


+ (NSString *)contentForFile:(NSString *)file ofType:(NSString *)type
{
    NSString*filePath=[[NSBundle mainBundle] pathForResource:file ofType:type];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return content;
}

@end
