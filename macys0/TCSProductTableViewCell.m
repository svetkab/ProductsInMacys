//
//  TCSProductTableViewCell.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/3/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "TCSProductTableViewCell.h"

@implementation TCSProductTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCellForProduct:(TCSProduct*) product
                      indexPath:(NSIndexPath*) indexPath
{
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapDec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapPrice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapSale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapWebId = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    
    UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhotoAction:)];
    
    [_photoView addGestureRecognizer:tapPhoto];
    [_nameLabel addGestureRecognizer:tapName];
    [_webIdLabel addGestureRecognizer:tapWebId];
    [_priceLabel addGestureRecognizer:tapPrice];
    [_discountPriceLabel  addGestureRecognizer:tapSale];    
    [_descriptionLabel addGestureRecognizer:tapDec];
   
    
    _nameLabel.text = product.name;
    _descriptionLabel.text = product.description;
    _webIdLabel.text = [NSString stringWithFormat:@"WebId %@", product.webId ];
    _priceLabel.text = [NSString stringWithFormat:@"Price $%@", product.regularPrice   ];
    _discountPriceLabel.text = [NSString stringWithFormat:@"Sale $%@", product.salePrice];
    
    _photoView.image = product.productPhoto;
    
    _product = product;
}
- (void)tapAction:(id)sender {
    
    NSLog(@"sender = %@", sender);
    
    ProductInfoViewController *productInfoViewController = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    UILabel *label = (UILabel*)[sender view];
    
    productInfoViewController.editTag = label.tag;
    
    productInfoViewController.product = _product;
    
    productInfoViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.presentViewControllerDelegate presentViewController:productInfoViewController animated:YES completion:nil];
}

-(void) tapPhotoAction:(id)sender
{
    
    UIImageView * iview = [[UIImageView alloc] initWithImage:_product.productPhoto];
    
    iview.center = self.presentViewControllerDelegate.view.center;
    
    UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self.presentViewControllerDelegate action:@selector(tapPhotoAction:)];
    
    [iview addGestureRecognizer:tapPhoto];
    [iview setUserInteractionEnabled:YES];
    
    [self.presentViewControllerDelegate.view addSubview:iview];
    
}
@end
