//
//  TCSSqlLiteManager.m
//  macys0
//
//  Created by Svetlana Brodskaya on 4/2/14.
//  Copyright (c) 2014 Svetlana Brodskaya. All rights reserved.
//

#import "TCSSqlLiteManager.h"

static TCSSqlLiteManager *instance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;


@implementation TCSSqlLiteManager

#pragma mark - Initialization

+(TCSSqlLiteManager*)sharedInstance{
    if (!instance) {
        instance = [[super allocWithZone:NULL]init];
        [instance createDB];
    }
    return instance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    dbPath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"productsMacys2.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: dbPath ] == NO)
    {
        const char *dbpath = [dbPath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "create table if not exists products (webid text, name text, description text, regularprice text, saleprice text, productphoto text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(BOOL)saveProduct:(TCSProduct*) product
{
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into products (webid, name, description, regularprice, saleprice, productphoto) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", product.webId, product.name, product.description, [NSString stringWithFormat:@"%@", product.regularPrice], [NSString stringWithFormat:@"%@", product.salePrice], product.productPhotoName];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
                return YES;
        }
        else {
                return NO;
        }
        sqlite3_reset(statement);
         
        
    }
    return NO;
}

-(BOOL)updateProductWithWebId:(NSString *)webId WithProduct:(TCSProduct*) product
{
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *updateSQL = [NSString stringWithFormat:@"update products set name=\"%@\", description =\"%@\", regularprice=\"%@\" , saleprice=\"%@\" where webid= \"%@\"", product.name, product.description, [NSString stringWithFormat:@"%@", product.regularPrice], [NSString stringWithFormat:@"%@", product.salePrice], product.webId];
        
        
        
        const char *update_stmt = [updateSQL UTF8String];
        
        sqlite3_prepare_v2(database, update_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
        
        
    }
    return NO;
}

-(BOOL)deleteProductWithWebId:(NSString *)webId
{
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:@"delete from products where webid= \"%@\"", webId];

        const char *delete_stmt = [deleteSQL UTF8String];
        
        sqlite3_prepare_v2(database, delete_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
        
        
    }
    return NO;
}

-(NSArray *) allProducts
{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select webid, name, description, regularprice, saleprice, productphoto  from products"];
        
       

        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [querySQL UTF8String], -1, &statement, nil)
            == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *webIdChar = (char *) sqlite3_column_text(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                char *descriptionChars = (char *) sqlite3_column_text(statement, 2);
                char *regularPriceChars = (char *) sqlite3_column_text(statement, 3);
                char *salePriceChars = (char *) sqlite3_column_text(statement, 4);
                char *productPhotoNameChars = (char *) sqlite3_column_text(statement, 5);
                NSString *webId = [[NSString alloc] initWithUTF8String:webIdChar];
                NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
                NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
                NSString *regularPrice = [[NSString alloc] initWithUTF8String:regularPriceChars];
                NSString *salePrice = [[NSString alloc] initWithUTF8String:salePriceChars];
                NSString *productPhotoName = [[NSString alloc] initWithUTF8String:productPhotoNameChars];
                TCSProduct *product = [[TCSProduct alloc] initWithWebId:webId
                                                                   name:name
                                                            description:description
                                                           regularPrice:[NSDecimalNumber decimalNumberWithString: regularPrice]
                                                              salePrice:[NSDecimalNumber decimalNumberWithString: salePrice]
                                                       productPhotoName:productPhotoName];
                
                [retval addObject:product];
            }
            sqlite3_finalize(statement);
        }
    }
    return retval;
}

@end
