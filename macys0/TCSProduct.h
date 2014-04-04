//
//  TCSProduct.h
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCSProduct : NSObject

@property (nonatomic, retain)  NSString * webId;
@property (nonatomic, retain)  NSString * name;
@property (nonatomic, retain)  NSString * description;
@property (nonatomic, retain)  NSDecimalNumber * regularPrice;
@property (nonatomic, retain)  NSDecimalNumber * salePrice;
@property (nonatomic, retain)  UIImage * productPhoto;
@property (nonatomic, retain)  NSString * productPhotoName;
@property (nonatomic, retain)  NSArray * colors;
@property (nonatomic, retain)  NSDictionary * stores;


- (id)initWithWebId:(NSString *) webId
               name:(NSString *) name
        description:(NSString *) description
       regularPrice:(NSDecimalNumber *) regularPrice
          salePrice:(NSDecimalNumber *) salePrice
   productPhotoName:(NSString *) productPhotoName;

@end
