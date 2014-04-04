//
//  TCSSqlLiteManager.h
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TCSProduct.h"

@interface TCSSqlLiteManager : NSObject
{
    NSString *dbPath;
}

+(TCSSqlLiteManager*)sharedInstance;

-(BOOL)saveProduct:(TCSProduct*) product;
-(BOOL)updateProductWithWebId:(NSString *)webId WithProduct:(TCSProduct*) product;
-(BOOL)deleteProductWithWebId:(NSString *)webId;

-(NSArray *) allProducts;

@end
