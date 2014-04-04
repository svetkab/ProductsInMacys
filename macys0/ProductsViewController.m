//
//  ProductsViewController.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/3/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "ProductsViewController.h"
#import "TCSProductTableViewCell.h"
#import "TCSSqlLiteManager.h"

@interface ProductsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray * productsList;

- (IBAction)backButtonPressed:(id)sender;

@end

@implementation ProductsViewController

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)productsList
{
    if (!_productsList) {
        _productsList = [NSMutableArray array];
        [_productsList addObjectsFromArray:[[TCSSqlLiteManager sharedInstance] allProducts]];
    }
    return _productsList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }

}

-(void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.productsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerClass:[TCSProductTableViewCell class] forCellReuseIdentifier:@"ProductCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"TCSProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    
    TCSProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    TCSProduct * product = [self.productsList objectAtIndex:indexPath.row];
    
    cell.presentViewControllerDelegate = self;
    
    [cell configureCellForProduct:product indexPath:indexPath];
    
    return cell;
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     
     TCSProduct * product = [self.productsList objectAtIndex:indexPath.row];
     
     [[TCSSqlLiteManager sharedInstance] deleteProductWithWebId:product.webId];
     
     [self.productsList removeObjectAtIndex:indexPath.row];
     
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     
     
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ProductInfoViewController *productInfoViewController = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    productInfoViewController.product = [self.productsList objectAtIndex:indexPath.row];
    
    productInfoViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:productInfoViewController animated:YES completion:nil];
}

#pragma mark - call from imageView

-(void) tapPhotoAction:(id)sender
{
    UIView *v = (UIView*)[sender view];
    
    [v removeFromSuperview];
}

@end
