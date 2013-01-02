//
//  MGPurchaseResponser.h
//  MyGameFramework
//
//  Created by Henry Dai on 12/10/18.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MPPurchaseResult <NSObject>

@required
- (void) purchaseCompleted;
- (void) purchaseFailed:(NSString*) errorString;
- (void) getProductStatus: (NSString*) status withError: (NSString*) description;

@optional
- (void) purchaseRestore;

@end
