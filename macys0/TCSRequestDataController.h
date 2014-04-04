//
//  TCSRequestDataController.h
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCSRequestDataController : NSObject

@property (nonatomic,retain) NSArray * products;
-(void) loadMockData;

@end
