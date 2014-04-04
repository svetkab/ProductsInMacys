//
//  TCSRequestDataController.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "TCSRequestDataController.h"
#import "TCSProduct.h"

@implementation TCSRequestDataController

-(void) loadMockData
{
    NSString *dataPath=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSData* data = [NSData dataWithContentsOfFile:dataPath];
    _products = [self extactDataFromJson:data];
}

- (NSArray *)extactDataFromJson:(NSData *)data
{
    NSMutableArray * products = [NSMutableArray array];

    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:kNilOptions
                     error:&error];
    
    for (NSDictionary * productDic in json) {
        TCSProduct * product = [[TCSProduct alloc] initWithWebId:[productDic objectForKey:@"id"]
                                                            name:[productDic objectForKey:@"name"]
                                                     description:[productDic objectForKey:@"description"]
                                                    regularPrice:[productDic objectForKey:@"regularprice"]
                                                       salePrice:[productDic objectForKey:@"saleprice"]
                                                productPhotoName:[productDic objectForKey:@"productphoto"]];
        
        [products addObject:product];
        
    }
    
    return products;
}

@end
