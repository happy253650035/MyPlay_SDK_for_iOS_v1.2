//
//  MainViewController.m
//  TicTacTao
//
//  Created by Henry Dai on 12/10/24.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    BOOL player;
}

@property (assign) BOOL player;

@end

@implementation MainViewController
@synthesize player, statusLabel;

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [statusLabel setText:@"遊戲開始"];
    player = YES;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buyItem:(id)sender {
    
}

- (IBAction)btnAction:(id)sender {
    if (player == YES) {
        
        [sender setTitle:@"O" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        player = NO;
        [statusLabel setText:@"換X"];
    } else if (player == NO) {
        [sender setTitle:@"X" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        player = YES;
        [statusLabel setText:@"換O"];
    }
    [sender setEnabled:NO];
    
}
@end
