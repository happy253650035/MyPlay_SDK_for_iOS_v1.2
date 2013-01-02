//
//  PurchaseViewController.m
//  TicTacTao
//  Created by Henry Dai on 12/10/24.
//  Copyright (c) 2012年 Acer Inc. All rights reserved.
//

#import "PurchaseViewController.h"

@interface PurchaseViewController () {
    UIAlertView *alert;
    UIAlertView *alertProcess;
    MPPurchaseItem *item;
}

@property (copy) NSArray *productList;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) UIAlertView *alertProcess;
@property (nonatomic, retain) UIButton *selectedBtn;
@property (nonatomic, retain) NSMutableString *selectedTitle;
- (void) showAlert: (NSString*) title messsage: (NSString*) message okBtn:(NSString*) okString;
- (IBAction) buy: (id)sender;
@end

@implementation PurchaseViewController
@synthesize alert, productList, selectedBtn, selectedTitle, alertProcess;
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
    alertProcess  = [[UIAlertView alloc] initWithTitle:@"讀取中，請稍候..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    alert  = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alertProcess show];
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake(alertProcess.bounds.size.width/2.0f, alertProcess.bounds.size.height - 40.0f);
    [aiv startAnimating];
    aiv.hidesWhenStopped = YES;
    [alertProcess addSubview:aiv];
    
    item = [[MPPurchaseItem alloc] init];
    [item sendPurchaseRequestWithDelegate:self];
    [item setMPPurchaseResultGetter:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    productList = [[NSArray alloc] initWithArray:[item productRequest:request didReceiveResponse:response]];
    if (productList != nil) {
        for (int i=0; i < [productList count]; i++) {
            NSArray* content = [[NSArray alloc] initWithArray:[productList objectAtIndex:i]];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 80.0+100*i, 320.0, 20.0)];
            [titleLabel setText:[content objectAtIndex:MPItemTitle]];
            [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
            
            UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 100.0+100*i, 320.0, 20.0)];
            [desLabel setText:[content objectAtIndex:MPItemDescription]];
            [desLabel setFont:[UIFont systemFontOfSize:12]];
            
            UIButton* buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buyButton setFrame:CGRectMake(10.0, 120.0+100*i,100.0, 20.0)];
            [buyButton setTitle:[content objectAtIndex:MPItemPrice] forState:UIControlStateNormal];
            [buyButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
            [self.view addSubview:titleLabel];
            [self.view addSubview:desLabel];
            [self.view addSubview:buyButton];
            [buyButton setTag:i];
            [buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
            
            NSLog(@"Title: %@", [content objectAtIndex:MPItemTitle]);
            NSLog(@"Description: %@", [content objectAtIndex:MPItemDescription]);
            NSLog(@"Price: %@", [content objectAtIndex:MPItemPrice]);
            NSLog(@"ProductID: %@", [content objectAtIndex:MPItemProductID]);
        }
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
    } else {
        NSLog(@"Empty product list");
    }
}

- (IBAction) buy: (id)sender {
//    [self showAlert:@"正在處理您的購買 請稍候..." messsage:nil];
//    [alertProcess show];
    [item buyWithProductID:[[self.productList objectAtIndex:[sender tag]] objectAtIndex:MPItemProductID] withProductList:self.productList];
}

- (void) purchaseCompleted {
    [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
    
    [self showAlert:@"購買結果" messsage:@"購買成功！" okBtn: @"確定"];
    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) purchaseFailed:(NSString *)errorString {
    if ([errorString isEqualToString:@"UserCancel"]) {
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
        [self showAlert:@"購買結果" messsage:@"購買失敗: 使用者取消" okBtn: @"確定"];
        [alert show];
    } else {
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
        [self showAlert:@"購買結果" messsage: [NSString stringWithFormat:@"購買失敗: %@", errorString] okBtn: @"確定"];
        [alert show];
    }
}

- (void) getProductStatus:(NSString *)status withError:(NSString *)description {
    if ([status isEqualToString:MPProductStatusSuccess]) {
        
    } else if ([status isEqualToString:MPProductStatusTimeOut]) {
        NSLog(@"TimeOut");
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
        [self showAlert:@"連線逾時" messsage:@"連線Server出現問題，請檢查您的網路連線" okBtn: @"確定"];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([status isEqualToString:MPProductStatusEmpty]) {
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
        [self showAlert:@"空白清單" messsage:@"目前此遊戲無可購買商品" okBtn: @"確定"];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([status isEqualToString:MPProductStatusError]) {
        [alertProcess dismissWithClickedButtonIndex:[alertProcess cancelButtonIndex] animated:YES];
        [self showAlert:@"下載錯誤" messsage:[[NSString alloc] initWithFormat:@"錯誤碼: %@", description] okBtn: @"確定"];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) showAlert: (NSString*) title messsage: (NSString*) message {
    [alertProcess setTitle:title];
    [alertProcess setMessage:message];
}

- (void) showAlert: (NSString*) title messsage: (NSString*) message okBtn:(NSString*) okString {
    [alert setTitle:title];
    [alert setMessage:message];
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
