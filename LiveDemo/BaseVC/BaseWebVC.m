//
//  BaseWebVC.m
//  HaiTao
//
//  Created by Damon on 15/12/10.
//  Copyright © 2015年 HaiShang. All rights reserved.
//

#import "BaseWebVC.h"

@implementation BaseWebVC

- (void)viewDidLoad{
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    _webView.delegate = (id)self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    [_webView loadRequest:urlRequest];
    [self.view addSubview:_webView];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // NSLayoutConstraint
    
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    
    
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
    [self.view addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
    
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    heightConstraint.active = YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.navTitleStr.length > 0) {
        [self.navigationItem setTitle:self.navTitleStr];
    }else if(theTitle&&theTitle.length>0){
        [self.navigationItem setTitle:theTitle];
    }else{
        [self.navigationItem setTitle:@"海印优选"];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    if (![error.localizedDescription isEqualToString:@"Plug-in handled load"]){
    }
    if ( [error code] == 204 ) {
        
    }
}
@end
