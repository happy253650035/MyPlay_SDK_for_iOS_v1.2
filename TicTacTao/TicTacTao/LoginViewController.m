//
//  ViewController.m
//  TicTacTao
//
//  Created by Henry Dai on 12/10/24.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController () {
    MPLogin *page;
}

@property (nonatomic, retain) UIWebView *web;
@property (nonatomic, retain) UIActivityIndicatorView *webAiv;


@end

@implementation LoginViewController
@synthesize web, webAiv, state;

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect webFrame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    self.web = [[UIWebView alloc] initWithFrame:webFrame];
    if ([state isEqualToString:@"login"]) {
        page = [[MPLogin alloc] initWithWebView:self.web forState:MPUserLogin];
    } else if ([state isEqualToString:@"signup"]) {
        page = [[MPLogin alloc] initWithWebView:self.web forState:MPUserSignUp];
    }
    
    self.web.delegate = self;
    [self.view addSubview:self.web];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [page webViewDidStartLoad];
    webAiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    webAiv.center = CGPointMake(webView.frame.size.width/2.0f, webView.frame.size.height/2.0f);
    webAiv.hidesWhenStopped = YES;
    [webAiv startAnimating];
    [webView addSubview:webAiv];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [page webViewDidFinishLoad];
    [webAiv stopAnimating];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL result =  [page shouldStartLoadWithRequest:request navigationType:navigationType];
    if ([page getLoginResult]) {
        [page setGamePropertyWithServerID:@"Server1" Role:@"role1"];
        NSLog(@"GID: %@", [page getGID]);
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    return result;
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [page didFailLoadWithError:error];
}

- (void) dealloc {
    web.delegate = nil;
}


@end