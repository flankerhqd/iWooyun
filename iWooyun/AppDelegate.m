//
//  AppDelegate.m
//  iWooyun
//
//  Created by hqdvista on 2/17/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "AppDelegate.h"
#include "WYSlideController.h"
#include "UMNavigationController.h"
#include "WYRootViewController.h"
#include "WYServiceImpl.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UMNavigationController config] setValuesForKeysWithDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                                     @"WYRootViewController", @"wy://test",
                                                                     @"WYBugsListViewController", @"wy://newestbugs",
                                                                     @"WYBugDetailViewController", @"wy://bugdetail",
                                                                     @"WYWebViewController",@"wy://webview",
                                                                     @"CheckUpdateViewController",@"wy://update-about",
                                                                     nil]];
    self.navigator = [[WYSlideController alloc] initWithItems:@[@[
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://newestbugs"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"最新漏洞", @"title", nil]]],
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://newestbugs?type=public"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"最新公开漏洞", @"title", nil]]],
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://newestbugs?type=submit"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"最新提交漏洞", @"title", nil]]],
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://newestbugs?type=confirm"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"最新确认漏洞", @"title", nil]]],
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://newestbugs?type=unclaim"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"等待认领漏洞", @"title", nil]]],
                      
                      [[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://update-about"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"更新 & 关于", @"title", nil]]]],
                      @[[[UMNavigationController alloc] initWithRootViewControllerURL:[[NSURL URLWithString:@"wy://test"]
                                                                                     addParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                @"登陆",@"title", nil]]],
                      ]]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self.navigator.view];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
