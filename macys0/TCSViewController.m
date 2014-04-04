//
//  TCSViewController.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "ProductsViewController.h"
#import "TCSProduct.h"
#import "TCSViewController.h"
#import "TCSSqlLiteManager.h"
#import "TCSRequestDataController.h"

@interface TCSViewController ()

- (IBAction)showProductsList:(id)sender;
- (IBAction)loadDataToDB:(id)sender;

@end

@implementation TCSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showProductsList:(id)sender {
    ProductsViewController * controller = [[ProductsViewController alloc]initWithNibName:@"ProductsViewController" bundle:nil];
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)loadDataToDB:(id)sender {
    
     TCSRequestDataController *requestDataController = [[TCSRequestDataController alloc]init];
    
     [requestDataController loadMockData];
     
     TCSSqlLiteManager * sqlLiteManager = [TCSSqlLiteManager sharedInstance];
     
     for (TCSProduct * product in requestDataController.products) {
         [sqlLiteManager saveProduct:product];
     }
     
}
@end
