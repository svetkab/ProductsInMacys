//
//  ProductInfoViewController.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/3/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "TCSSqlLiteManager.h"

@interface ProductInfoViewController ()

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutletCollection(id) NSArray *editableTextFields;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation ProductInfoViewController

#pragma mark - View lifecycle
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    _webIdTextField.text = _product.webId;
    
    _priceTextField.text = [NSString stringWithFormat:@"%@", _product.regularPrice];
    _saleTextField.text = [NSString stringWithFormat:@"%@", _product.salePrice];
    
    _nameTextField.text = _product.name;
    _descriptionTextField.text = _product.description;
    
    for (UIView * t in _editableTextFields) {
        [self isVisibleForEdit:t];
    }
    
    switch (_editTag) {
        case 1:
            _navItem.title = @"Edit Product WebId";
            break;
        case 2:
            _navItem.title = @"Edit Regular price";
            break;
        case 3:
            _navItem.title = @"Edit Sale price";
            break;
        case 4:
            _navItem.title = @"Edit Product name";
            break;
        case 5:
            _navItem.title = @"Edit Decription";
            break;
            
        default:
            break;
    }
    // Do any additional setup after loading the view from its nib.
}

-(void) isVisibleForEdit:(UIView *) field
{
    if (field.tag == _editTag) {
        [field setHidden:NO];
        [field becomeFirstResponder];
    } else {
        [field setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    _product.name = _nameTextField.text;
    _product.description = _descriptionTextField.text;
    _product.salePrice = [NSDecimalNumber decimalNumberWithString:_saleTextField.text];
    _product.regularPrice = [NSDecimalNumber decimalNumberWithString:_priceTextField.text];
    
    
    [[TCSSqlLiteManager sharedInstance] updateProductWithWebId:_product.webId WithProduct:_product];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
