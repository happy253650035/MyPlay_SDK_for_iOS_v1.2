//
//  HomeViewController.m
//  TicTacTao
//
//  Created by SHAO-HUAN DAI on 12/11/22.
//  Copyright (c) 2012年 TWM. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLogin:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:sender];
}

- (IBAction)userSignup:(id)sender {
    [self performSegueWithIdentifier:@"signup" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"login"]) {
        LoginViewController *login = [segue destinationViewController];
        [login setState:@"login"];
    } else if ([[segue identifier] isEqualToString:@"signup"]) {
        LoginViewController *signup = [segue destinationViewController];
        [signup setState:@"signup"];
    }
}
@end
