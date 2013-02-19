//
//  WYBugDetailImpl.m
//  iWooyun
//
//  Created by hqdvista on 2/19/13.
//  Copyright (c) 2013 hqdvista. All rights reserved.
//

#import "WYBugDetailImpl.h"
#import "WYTool.h"
@interface WYBugDetailImpl ()

<UIWebViewDelegate>

@property (copy,nonatomic) WYDetailCallbackBlock detailBlock;
@property (strong, nonatomic)   NSString                        *bugUrl;
@property (strong, nonatomic)   UIWebView                       *webView;

@end
@implementation WYBugDetailImpl

- (void)load
{
    [self.webView stopLoading];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.bugUrl]];
    [self.webView loadRequest:requestObj];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"view finished loading");
    NSString *clearpageJS = [WYTool contentForFile:@"ClearPage.js" ofType:@"txt"];
    NSString *commentBoxJS = [WYTool contentForFile:@"GetCommentBox.js" ofType:@"txt"];

    NSString *commentBox = [webView stringByEvaluatingJavaScriptFromString:commentBoxJS];
    NSString *content = [webView stringByEvaluatingJavaScriptFromString:clearpageJS];
    
    NSDictionary *bugInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  commentBox, @"commentBox",
                                  content, @"content",
                                  nil];
    if (self.detailBlock) {
        self.detailBlock(bugInfo,nil);
    }
    /*
    NSString *questionJS = [NSString stringWithFormat:[WYTool contentForFile:@"GetQuestionDetail.js" ofType:@"txt"], self.questionId];
    NSString *question = [webView stringByEvaluatingJavaScriptFromString:questionJS];
    [webView stringByEvaluatingJavaScriptFromString:[SFTools contentForFile:@"AnswerDetail.js" ofType:@"txt"]];
    NSString *answerJS = [SFTools contentForFile:@"GetQuestionAnswer.js" ofType:@"txt"];
    NSString *answer = [webView stringByEvaluatingJavaScriptFromString:answerJS];
    
    NSDictionary *questionInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  question, @"question",
                                  answer, @"answers",
                                  nil];
    
    if (self.detailLoadedBlock) {
        self.detailLoadedBlock(questionInfo, 0, [NSError errorWithDomain:@".segmentfault.com" code:200 userInfo:nil]);
    }
     */
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.detailBlock) {
        self.detailBlock(nil,error);
    }
}

#pragma mark - parent

- (id)init
{
    self = [super init];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        
        return self;
    }
    return nil;
}

#pragma mark - static

+ (void)bugDetailBy:(NSString *)url
               withBlock:(WYDetailCallbackBlock)block
{
    static WYBugDetailImpl *obj = nil;
    if (nil == obj) {
        obj = [[WYBugDetailImpl alloc] init];
    }
    obj.bugUrl = url;
    obj.detailBlock = block;
    [obj load];
}
@end
