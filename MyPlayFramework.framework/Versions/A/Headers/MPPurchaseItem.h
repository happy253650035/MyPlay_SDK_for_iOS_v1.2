//
//  MyGamePurchaseItem.h
//  MyGameFramework
//
//  Created by Henry Dai on 12/10/15.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MPPurchaseResult.h"

@interface MPPurchaseItem : NSObject 

- (BOOL) sendPurchaseRequestWithDelegate: (id<SKProductsRequestDelegate>) delegate inSituation: (NSString*) situation;
- (BOOL) sendPurchaseRequestWithDelegate: (id<SKProductsRequestDelegate>) delegate;

- (NSArray*) productRequest: (SKProductsRequest*) request didReceiveResponse: (SKProductsResponse *) response;
- (void) buyWithProductID: (NSString*) productIdentifier withProductList: (NSArray*) productList;
- (void) setMPPurchaseResultGetter: (id<MPPurchaseResult>) getter;

@end
