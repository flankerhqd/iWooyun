//
//  WYLocalWebView.h
//  iWooyun
//
//  Created by hqdvista on 2/20/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UMNavigationController;
@interface WYLocalWebView : UIWebView

@property (assign, nonatomic)               WYCellType      type;
@property (unsafe_unretained, nonatomic)    UMNavigationController  *navigator;

@end
