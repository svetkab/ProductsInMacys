//
//  TCSProductTableViewCell.h
//  macys0
//
//  Created by Svetlana Brodskaya on 4/3/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TCSProduct.h"

@interface TCSProductTableViewCell : UITableViewCell

@property (retain, nonatomic)  TCSProduct * product;

- (void)tapAction:(id)sender;

@property (nonatomic, retain) UIViewController * presentViewControllerDelegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *webIdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountPriceLabel;


-(void) configureCellForProduct:(TCSProduct*) product
                   indexPath:(NSIndexPath*) indexPath;
@end
