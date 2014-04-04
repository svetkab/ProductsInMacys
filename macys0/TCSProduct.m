//
//  TCSProduct.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "TCSProduct.h"

@implementation TCSProduct

- (id)initWithWebId:(NSString *) webId
               name:(NSString *) name
        description:(NSString *) description
       regularPrice:(NSDecimalNumber *) regularPrice
          salePrice:(NSDecimalNumber *) salePrice
   productPhotoName:(NSString *) productPhotoName
{
    if ((self = [super init])) {
        _webId = webId;
        _name = name;
        _description = description;
        _regularPrice = regularPrice;
        _salePrice = salePrice;
        _productPhotoName = productPhotoName;
        _productPhoto = [UIImage imageNamed: productPhotoName];
    }
    return self;
}

@end
