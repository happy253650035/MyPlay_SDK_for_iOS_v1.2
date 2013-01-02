//
//  MyGameLoginViewController.h
//  WebFramework
//
//  Created by Henry Dai on 12/10/5.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>


@interface MPLogin : NSObject <NSURLConnectionDelegate>


-(id) initWithWebView: (UIWebView*) web forState: (NSString*) state;
- (void) webViewDidStartLoad;
- (void) webViewDidFinishLoad;
- (BOOL)shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;
- (NSString*) getGID;
- (BOOL) getLoginResult;
- (void) setGamePropertyWithServerID:(NSString *)serverID Role:(NSString*) roleID;
- (void) didFailLoadWithError:(NSError *)error;

@end
