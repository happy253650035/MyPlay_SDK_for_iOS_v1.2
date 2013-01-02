//
//  MainViewController.h
//  TicTacTao
//
//  Created by Henry Dai on 12/10/24.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)buyItem:(id)sender;

- (IBAction)btnAction:(id)sender;

@end
