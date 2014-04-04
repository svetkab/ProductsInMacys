//
//  ProductInfoViewController.h
//  macys0
//
//  Created by Svetlana Brodskaya on 4/3/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCSProduct.h"

@interface ProductInfoViewController : UIViewController

@property (nonatomic, retain) TCSProduct * product;

@property (nonatomic, assign) NSInteger editTag;

@property (weak, nonatomic) IBOutlet UITextField *webIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *saleTextField;
@property (weak, nonatomic) IBOutlet UITextView *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;

@end
