//
//  PurchaseViewController.h
//  TicTacTao
//
//  Created by Henry Dai on 12/10/24.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyPlayFramework/MPFramework.h>

@interface PurchaseViewController : UIViewController <MPPurchaseResult, SKProductsRequestDelegate, UIAlertViewDelegate>
- (IBAction)cancelBtn:(id)sender;

@end
