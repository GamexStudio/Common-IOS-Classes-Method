//
//  DBManager.m
//  Docomo
//
//  Created by Vijaya Kamath on 13/02/15.
//  Copyright (c) 2015 Vijaya Kamath. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager *)getSharedInstance{
    if(!sharedInstance){
    
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
        
    }

    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"dirpath is : %@",dirPaths);
    docsDir = dirPaths[0];
    NSLog(@"docsDirectory is : %@",docsDir);
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"selfcare.db"]];
    NSLog(@"database path is :%@",databasePath);
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSLog(@"filemgr is : %@",filemgr.description);
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        NSLog(@"in file not exist");
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            NSLog(@"in sqlite open");
            char *errMsg;
            // const char *sql_stmt ="create table if not exists studentsDetail (regno integer primary key, name text, department text, year text)";
            
            const char *create_user_mst = "create table if not exists tbl_user_master (id_user integer primary key autoincrement,imei text not null ,primary_number text not null ,service_type text not null,product_type text not null ,bu_type text not null ,id_buservprod_link integer not null,display_name text,circle text not null,os text,status text,email text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_tbl_otp = "create table if not exists tbl_ota (id_ota integer primary key autoincrement,ota text not null,associated_number text not null,status text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_service_type = "create table if not exists tbl_service_type (id_service_type integer primary key autoincrement,service_type_name text not null,service_type_description text default null,service_type_status text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_tbl_product_type = "create table if not exists tbl_product_type(id_product_type integer primary key autoincrement,product_type_name text not null,product_type_description text default null,product_type_status text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_tbl_bu_type = "create table if not exists tbl_bu_type(id_bu_type integer primary key autoincrement, bu_name text not null,bu_description text default null,bu_status text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_tbl_buservprod_link = "create table if not exists tbl_buservprod_link(id_buservprod_link integer primary key autoincrement, id_bu_type integer not null,id_service_type integer not null,id_product_type integer not null,meaning text not null,status text not null,updated_date_time datetime not null default current_timestamp)";
            //this table is not available in server database
            const char *create_tbl_other_mdns = "create table if not exists tbl_other_mdns(id_other_mdns integer primary key autoincrement,temp_acc_number text not null,temp_other_mdns text not null,temp_mdn text not null,temp_service_type text not null,temp_status text not null,temp_unique text not null,temp_product_type text not null,temp_bu text not null,temp_emailId text not null)";
            
            const char *create_tbl_stores = "create table if not exists tbl_stores(id_stores integer primary key autoincrement,circle text not null,city text default null,latitude text default null,longitude text default null,address1 text default null,address2 text default null,pincode text default null,status text not null,updated_date_time datetime not null default current_timestamp)";
            
            const char *create_tbl_base_balance = "create table if not exists tbl_base_balance(id_balance integer primary key autoincrement,mdn text default null,bu text default null,product_type text default null,service_type text default null,main_balance text default null,main_validity text default null,data_balance text default null,data_validity text default null,currently_active text default null,available_for_activation text default null,bill_cycle text default null,bill_amount text default null,bill_due_date text default null,unbill_amount text default null,credit_limit text default null,data_consumed text default null)";
            
            const char *create_tbl_add_on_packs = "create table if not exists tbl_add_on_packs(id_addon integer primary key autoincrement,id_addon_type text not null,component text default null,display_name text default null,segment text default null,service_type text default null,network text default null)";
            
            const char *create_tbl_vas_offers = "create table if not exists tbl_vas_offers(id_vas_offers integer primary key autoincrement,category text default null,service_id text default null,offer_type text default null,offer_validity text default null,offer_price text default null,offer_vendor text default null,vasname text default null,desc text default null,mdn text default null,productType text defailt null)";
            
            const char *create_tbl_banner = "create table if not exists tbl_banner(id_banner integer primary key autoincrement,banner_image BLOB default null,banner_name text default null,banner_action text default null)";
            
            if (sqlite3_exec(database, create_user_mst, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table tbl_user_master %s",errMsg);
            }
            
            if(sqlite3_exec(database, create_tbl_otp, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table tbl_ota %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_service_type, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table service_type %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_product_type, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_product_type %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_bu_type, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_bu_type %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_buservprod_link, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_buservprod_link %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_other_mdns, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_other_mdns %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_stores, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_stores %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_base_balance, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_base_balance %s",errMsg);
                
            }
            if(sqlite3_exec(database, create_tbl_add_on_packs, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create_tbl_add_on_packs %s",errMsg);
                
            }
            
            if (sqlite3_exec(database, create_tbl_vas_offers, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table tbl_vas_offers %s",errMsg);
            }
            
            if (sqlite3_exec(database, create_tbl_banner, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table create_tbl_banner %s",errMsg);
            }

            
            NSLog(@"database created successfully");
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database ");
        }
    }
     sqlite3_close(database);
    return isSuccess;
}

-(BOOL)saveToMst:(NSString *)imei num:(NSString *)num serviceName:(NSString *)serviceName productName:(NSString *)productName
          buName:(NSString *)buName link_id:(int)link_id displayName:(NSString *)displayName circle:(NSString *)circle os:(NSString *)os status:(NSString *)status email:(NSString *)email;
{
    
    NSLog(@"imei is : %@",imei);
    NSLog(@"num is : %@",num);
    NSLog(@"servicename is :%@",serviceName);
    NSLog(@"productName is : %@",productName);
    NSLog(@"buName is : %@",buName);
    NSLog(@"link id is :%d",link_id);
    NSLog(@"displayName is : %@",displayName);
    NSLog(@"circle is :%@",circle);
    NSLog(@"os is :%@",os);
    NSLog(@"status is :%@",status);
    NSLog(@"email id : %@",email);

    sqlite3_close(database);
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into tbl_user_master(imei,primary_number, service_type, product_type,bu_type,id_buservprod_link,display_name,circle,os,status,email) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\")",imei,num, serviceName, productName, buName,link_id, displayName, circle, os, status, email];
        
        NSLog(@"insertQuery is :%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        
        NSLog(@"inserstatement  : %s",insert_stmt);
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            
            return YES;
        }
        else {
            NSLog(@"fail insertion in master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
        
    }
   
    NSLog(@"db closed");
    sqlite3_close(database);
    return NO;
}


-(BOOL)saveTOTempOtherMDNs:(NSString *)account_no other_mdn:(NSString *)other_mdn temp_mdn:(NSString *)temp_mdn
            temp_serv_type:(NSString *)temp_serv_type temp_status:(NSString *)temp_status temp_unique:(NSString *)temp_unique
            temp_prod_type:(NSString *)temp_prod_type temp_bu_type:(NSString *)temp_bu_type temp_email:(NSString *)temp_email;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertToTempMDN = [NSString stringWithFormat:@"insert into tbl_other_mdns(temp_acc_number,temp_other_mdns, temp_mdn, temp_service_type,temp_status,temp_unique,temp_product_type,temp_bu,temp_emailId) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",account_no,other_mdn, temp_mdn, temp_serv_type, temp_status,temp_unique, temp_prod_type, temp_bu_type,temp_email];
        
        NSLog(@"insertToTempMDN is :%@",insertToTempMDN);
        const char *query_insertToTempMDN = [insertToTempMDN UTF8String];
        
        NSLog(@"query_insertToTempMDN  : %s",query_insertToTempMDN);
        
        sqlite3_prepare_v2(database, query_insertToTempMDN,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;

}


-(BOOL)saveToOTA:(NSString *)ota num:(NSString *)num status:(NSString *)status;{
    
    NSLog(@"ota num is : %@",ota);
    NSLog(@"num is : %@",num);
    NSLog(@"status is : %@",status);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL2 = [NSString stringWithFormat:@"insert into tbl_ota (ota,associated_number, status) values(\"%@\",\"%@\", \"%@\")",ota,num, status];
        
        NSLog(@"insertQuery is :%@",insertSQL2);
        const char *insert_stmt2 = [insertSQL2 UTF8String];
        
        NSLog(@"inserstatement  : %s",insert_stmt2);
        
        sqlite3_prepare_v2(database, insert_stmt2,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to ota");
            return YES;
        }
        else {
            NSLog(@"fail insertion in ota %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
        
    }
    
    sqlite3_close(database);
    return NO;
}

-(BOOL)saveToBuMst:(NSString *)bu_type bu_desc:(NSString *)bu_desc bu_status:(NSString *)bu_status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insert_bu_mst = [NSString stringWithFormat:@"insert into tbl_bu_type (bu_name, bu_description, bu_status) values(\"%@\",\"%@\", \"%@\")", bu_type, bu_desc, bu_status];
        
        NSLog(@"insert_bu_mst is :%@",insert_bu_mst);
        const char *insert_query_bu_mst = [insert_bu_mst UTF8String];
        
        NSLog(@"insert_query_bu_mst  : %s",insert_query_bu_mst);
        
        sqlite3_prepare_v2(database, insert_query_bu_mst,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in master");
            return NO;
        }
        NSLog(@"in method reset");
        sqlite3_finalize(statement);
       
    }
    NSLog(@"in close");
    
    sqlite3_close(database);
    return NO;
}

-(BOOL)saveToServiceMst:(NSString *)service_name service_desc:(NSString *)service_desc service_status:(NSString *)service_status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insert_service_mst = [NSString stringWithFormat:@"insert into tbl_service_type (service_type_name, service_type_description, service_type_status) values(\"%@\",\"%@\", \"%@\")", service_name, service_desc, service_status];
        
        NSLog(@"insert_service_mst is :%@",insert_service_mst);
        const char *insert_query_service_mst = [insert_service_mst UTF8String];
        
        NSLog(@"insert_query_service_mst  : %s",insert_query_service_mst);
        
        sqlite3_prepare_v2(database, insert_query_service_mst,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in master");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;
    
}


-(BOOL)saveToProductMst:(NSString *)prod_name prod_desc:(NSString *)prod_desc prod_status:(NSString *)prod_status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insert_prod_mst = [NSString stringWithFormat:@"insert into tbl_product_type (product_type_name, product_type_description, product_type_status) values(\"%@\",\"%@\", \"%@\")", prod_name, prod_desc, prod_status];
        
        NSLog(@"insert_prod_mst is :%@",insert_prod_mst);
        const char *insert_query_prod_mst = [insert_prod_mst UTF8String];
        
        NSLog(@"insert_query_prod_mst  : %s",insert_query_prod_mst);
        
        sqlite3_prepare_v2(database, insert_query_prod_mst,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in master");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;
}

-(BOOL)saveToBuServProdMst:(int)bu_id service_id:(int)service_id product_id:(int)product_id
                   meaning:(NSString *)meaning status:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insert_buServProd_mst = [NSString stringWithFormat:@"insert into tbl_buservprod_link (id_bu_type, id_service_type, id_product_type, meaning, status) values(\"%d\",\"%d\",\"%d\",\"%@\",\"%@\")", bu_id, service_id, product_id, meaning, status];
        
        NSLog(@"insert_buServProd_mst is :%@",insert_buServProd_mst);
        const char *insert_query_buServProd_mst = [insert_buServProd_mst UTF8String];
        
        NSLog(@"insert_query_buServProd_mst  : %s",insert_query_buServProd_mst);
        
        sqlite3_prepare_v2(database, insert_query_buServProd_mst,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in master");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;
}

-(int)getBu_id:(NSString *)bu_type;
{
    NSLog(@"bu_type is :%@",bu_type);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getBuId = [NSString stringWithFormat:@"select id_bu_type from tbl_bu_type where bu_name=\"%@\"",bu_type];
        const char *query_getBuId = [getBuId UTF8String];
        if (sqlite3_prepare_v2(database,query_getBuId, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int bu_id =  sqlite3_column_int(statement, 0);
                
                NSLog(@"bu_id is : %d",bu_id);
                NSLog(@"bu_id value found");
                NSLog(@"db closed");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return bu_id;
            }
            else{
                NSLog(@"bu_id not found");
                return 0;
            }
            sqlite3_finalize(statement);
        }
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return 0;
    
    
}

-(int)getService_id:(NSString *)service_type;
{
    NSLog(@"service_type is :%@",service_type);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getServiceId = [NSString stringWithFormat:@"select id_service_type from tbl_service_type where service_type_name=\"%@\"",service_type];
        const char *query_getServiceId = [getServiceId UTF8String];
        if (sqlite3_prepare_v2(database,query_getServiceId, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int service_id =  sqlite3_column_int(statement, 0);
                
                NSLog(@"service_id is : %d",service_id);
                NSLog(@"service_id value found");
                NSLog(@"db closed");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return service_id;
            }
            else{
                NSLog(@"service_id not found");
                return 0;
            }
            sqlite3_finalize(statement);
            
        }
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return 0;
}



-(int)getProduct_id:(NSString *)product_type;
{
    NSLog(@"product_type is :%@",product_type);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getProductId = [NSString stringWithFormat:@"select id_product_type from tbl_product_type where product_type_name=\"%@\"",product_type];
        const char *query_getProductId = [getProductId UTF8String];
        if (sqlite3_prepare_v2(database,query_getProductId, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int product_id =  sqlite3_column_int(statement, 0);
                
                NSLog(@"product_id is : %d",product_id);
                NSLog(@"product_id value found");
                NSLog(@"db closed");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return product_id;
            }
            else{
                NSLog(@"product_id not found");
                return 0;
            }
            sqlite3_finalize(statement);
           
        }
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return 0;
}

-(int)getLink_id:(int)bu_id service_id:(int)service_id product_id:(int)product_id;
{
    NSLog(@"bu_id is :%d",bu_id);
    NSLog(@"service id is : %d",service_id);
    NSLog(@"product id is : %d",product_id);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getLinkId = [NSString stringWithFormat:@"select id_buservprod_link from tbl_buservprod_link where id_bu_type=\"%d\" and id_service_type = \"%d\" and id_product_type = \"%d\"",bu_id,service_id,product_id];

            NSLog(@"query for link is : %@",getLinkId);
        const char *query_getLinkId = [getLinkId UTF8String];
        if (sqlite3_prepare_v2(database,query_getLinkId, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int link_id =  sqlite3_column_int(statement, 0);
                
                NSLog(@"link_id is : %d",link_id);
                NSLog(@"link_id value found");
                NSLog(@"db closed");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return link_id;
            }
            else{
                NSLog(@"link_id not found");
                return 0;
            }
            sqlite3_finalize(statement);
        }
        
        NSLog(@"error is : %s",sqlite3_errmsg(database));
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return 0;
}

-(NSString *)getOTA:(NSString *)num;
{
    NSLog(@"number is :%@",num);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select ota from tbl_ota where associated_number=\"%@\"",num];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *otaVal = [[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"otp value found");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return otaVal;
            }
            else{
                NSLog(@"Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(NSString *)getBuType:(NSString *)num;
{
    NSLog(@"number is :%@",num);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getBuType = [NSString stringWithFormat:@"select bu_type from tbl_user_master where primary_number=\"%@\"",num];
        const char *query_getBuType = [getBuType UTF8String];
        if (sqlite3_prepare_v2(database,query_getBuType, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *buVal = [[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"buVal found %@",buVal);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return buVal;
            }
            else{
                NSLog(@"buVal Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(NSString *)getServiceType:(NSString *)num;
{
    NSLog(@"number is :%@",num);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getServiceType = [NSString stringWithFormat:@"select service_type from tbl_user_master where primary_number=\"%@\"",num];
        const char *query_getServiceType = [getServiceType UTF8String];
        if (sqlite3_prepare_v2(database,query_getServiceType, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *ServiceVal = [[NSString alloc] initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"ServiceVal found %@",ServiceVal);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return ServiceVal;
            }
            else{
                NSLog(@"ServiceVal Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(NSString *)getBUFromOtherMDN:(NSString *)num;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getBuTypeOther = [NSString stringWithFormat:@"select temp_bu from tbl_other_mdns where temp_other_mdns=\"%@\"",num];
        const char *query_getBuTypeOther = [getBuTypeOther UTF8String];
        if (sqlite3_prepare_v2(database,query_getBuTypeOther, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *buValOther = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                
                sqlite3_finalize(statement);
                sqlite3_close(database);
                NSLog(@"buValOther found %@",buValOther);
                return buValOther;
            }
            else{
                NSLog(@"buValOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSString *)getServiceFromOtherMDN:(NSString *)num;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getServiceTypeOther = [NSString stringWithFormat:@"select temp_service_type from tbl_other_mdns where temp_other_mdns=\"%@\"",num];
        const char *query_getServiceTypeOther = [getServiceTypeOther UTF8String];
        if (sqlite3_prepare_v2(database,query_getServiceTypeOther, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *serviceValOther = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"serviceValOther found %@",serviceValOther);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return serviceValOther;
            }
            else{
                NSLog(@"serviceValOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(NSMutableArray *)getAllUserMst:(NSString *)num;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllData = [NSString stringWithFormat:@"select * from tbl_user_master where primary_number=\"%@\"",num];
        const char *query_getAllData = [getAllData UTF8String];
        NSMutableArray *allData = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getAllData, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 0)]];
//
//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 1)]];
//
//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 2)]];
//
//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 3)]];
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 4)]];
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 5)]];
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 6)]];

//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 7)]];
//
//                [allData addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 8)]];

                sqlite3_finalize(statement);
                sqlite3_close(database);
                 return allData;
            }
            else{
                NSLog(@"serviceValOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
}



-(NSArray *)getprepaid;

{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getMDNVal = [NSString stringWithFormat:@"select * from tbl_user_master limit 1"];
        const char *query_getMDNVal = [getMDNVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSArray *mdn = [[NSString alloc] initWithUTF8String:
                                 (const char *) sqlite3_column_text(statement, 2)];
                
                NSLog(@"mdn found %@",mdn);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return mdn;
            }
            else{
                NSLog(@"mdn Not found");
                return nil;
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(database);
    return nil;
}







-(NSString *)getMDN;

{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getMDNVal = [NSString stringWithFormat:@"select * from tbl_user_master limit 1"];
        const char *query_getMDNVal = [getMDNVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *mdn = [[NSString alloc] initWithUTF8String:
                                             (const char *) sqlite3_column_text(statement, 2)];
                
                NSLog(@"mdn found %@",mdn);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return mdn;
            }
            else{
                NSLog(@"mdn Not found");
                return nil;
            }
            sqlite3_finalize(statement);
           
        }
    }
     sqlite3_close(database);
    return nil;
}

-(NSString *)getName;

{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getMDNVal = [NSString stringWithFormat:@"select display_name from tbl_user_master limit 1"];
        const char *query_getMDNVal = [getMDNVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *display_name = [[NSString alloc] initWithUTF8String:
                                 (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"display_name found %@",display_name);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return display_name;
            }
            else{
                NSLog(@"serviceValOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(database);
    return nil;
}

-(NSMutableArray *)getAllMdns:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllMdn = [NSString stringWithFormat:@"select temp_other_mdns from tbl_other_mdns where temp_status=\"%@\"",status];
        const char *query_getAllMdn = [getAllMdn UTF8String];
        NSMutableArray *allMdnData = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getAllMdn, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                [allMdnData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 0)]];
                
             sqlite3_finalize(statement);
            sqlite3_close(database);
            return allMdnData;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
}

-(BOOL)addAllDataToTblStore:(NSString *)city longi:(NSString *)longi lati:(NSString *)lati pin:(NSString *)pin add1:(NSString *)add1
                       add2:(NSString*)add2 circle:(NSString *)circle;
{
    sqlite3_close(database);
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *saveToStore = [NSString stringWithFormat:@"insert into tbl_stores(circle,city, latitude, longitude,address1,address2,pincode,status) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",circle,city, lati, longi, add1,add2, pin, @"A"];
        
        NSLog(@"saveToStore is :%@",saveToStore);
        const char *query_saveToStore = [saveToStore UTF8String];
        
        //NSLog(@"inserstatement  : %s",query_saveToStore);
        
        sqlite3_prepare_v2(database, query_saveToStore,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving data to store master");
            
            return YES;
        }
        else {
            NSLog(@"fail insertion in store master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
        
    }
    
    NSLog(@"db closed");
    sqlite3_close(database);
    return NO;

}

-(NSMutableArray *)getStates;
{
    NSMutableArray *allCircleData = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllCircle = [NSString stringWithFormat:@"select DISTINCT circle from tbl_stores ORDER BY circle"];
        const char *query_getAllCircle = [getAllCircle UTF8String];
        
        
        [allCircleData addObject:@"select circle"];
        if (sqlite3_prepare_v2(database,query_getAllCircle, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                [allCircleData addObject:[[NSString alloc] initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 0)]];
                
                
            }
            return allCircleData;
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSMutableArray *)getCities:(NSString *)state;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllCity = [NSString stringWithFormat:@"select DISTINCT city from tbl_stores where circle=\"%@\" order by city" ,state];
        const char *query_getAllCity = [getAllCity UTF8String];
        NSMutableArray *allCityData = [[NSMutableArray alloc] init];
        [allCityData addObject:@"select city"];
        if (sqlite3_prepare_v2(database,query_getAllCity, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                [allCityData addObject:[[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)]];
                
            }
            return allCityData;
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSMutableArray *)getStoresData:(NSString *)city;
{
    const char *dbpath = [databasePath UTF8String];
    NSString *lat;
    NSString *longi;
    NSString *add1;
    NSString *add2;
    NSString *pin;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllStore = [NSString stringWithFormat:@"select latitude,longitude,address1,address2,pincode from tbl_stores where city=\"%@\"" ,city];
        const char *query_getAllStore = [getAllStore UTF8String];
        NSMutableArray *allStoreData = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getAllStore, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                lat = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                longi =[[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 1)];
                add1 = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 2)];
                add2 = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 3)];
                pin = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 4)];
                [allStoreData addObject:lat];
                [allStoreData addObject:longi];
                [allStoreData addObject:add1];
                [allStoreData addObject:add2];
                [allStoreData addObject:pin];
                
            }
            return allStoreData;
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSMutableArray *)getStoresList:(NSString *)pin;
{
    
    NSLog(@"pin value is : %@",pin);
    
    const char *dbpath = [databasePath UTF8String];
    NSString *lat;
    NSString *longi;
    NSString *add1;
    NSString *add2;
    NSString *pincode;
    NSString *city;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllStoreData = [NSString stringWithFormat:@"select latitude,longitude,address1,address2,pincode,city from tbl_stores where pincode=\"%@\"" ,pin];
        const char *query_getAllStoreData = [getAllStoreData UTF8String];
        NSMutableArray *allStoreList = [[NSMutableArray alloc] init];

        if (sqlite3_prepare_v2(database,query_getAllStoreData, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSLog(@"in while");
                
                lat = [[NSString alloc] initWithUTF8String:
                       (const char *) sqlite3_column_text(statement, 0)];
                longi =[[NSString alloc] initWithUTF8String:
                        (const char *) sqlite3_column_text(statement, 1)];
                add1 = [[NSString alloc] initWithUTF8String:
                        (const char *) sqlite3_column_text(statement, 2)];
                add2 = [[NSString alloc] initWithUTF8String:
                        (const char *) sqlite3_column_text(statement, 3)];
                pincode = [[NSString alloc] initWithUTF8String:
                       (const char *) sqlite3_column_text(statement, 4)];
                city = [[NSString alloc] initWithUTF8String:
                        (const char *) sqlite3_column_text(statement, 5)];
                [allStoreList addObject:lat];
                [allStoreList addObject:longi];
                [allStoreList addObject:add1];
                [allStoreList addObject:add2];
                [allStoreList addObject:pin];
                [allStoreList addObject:city];
                
            }
            return allStoreList;
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(BOOL)dataDeleted:(NSString *)tablename;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *deleteTable = [NSString stringWithFormat:@"delete from \"%@\"",tablename];
        const char *query_deleteTable = [deleteTable UTF8String];
        sqlite3_prepare_v2(database, query_deleteTable,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
            {
                
                NSLog(@"TABLE DELETED");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return YES;
            }
            else{
                NSLog(@"TABLE Not found");
                return NO;
            }
            sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;
}


-(NSMutableArray *)getallprepaid:(NSString *)bu;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getOthrMDNVal = [NSString stringWithFormat:@"select * from tbl_other_mdns where temp_bu=\"%@\"",bu];
        const char *query_getOthrMDNVal = [getOthrMDNVal UTF8String];
        
        NSMutableArray *getMdns = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getOthrMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                //                                    (const char *) sqlite3_column_text(statement, 0)]];
                //
                //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                //                                    (const char *) sqlite3_column_text(statement, 1)]];
                //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                //                                    (const char *) sqlite3_column_text(statement, 2)]];
                
                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 2)]];
                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 4)]];
                
                
            }
            return getMdns;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;
}







-(NSMutableArray *)getSelectedNos:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getOthrMDNVal = [NSString stringWithFormat:@"select * from tbl_other_mdns where temp_status=\"%@\" LIMIT 5 " ,status];
        const char *query_getOthrMDNVal = [getOthrMDNVal UTF8String];
        
        NSMutableArray *getMdns = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getOthrMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
//                [getMdns addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 0)]];
//
//                [getMdns addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 1)]];
//                [getMdns addObject:[[NSString alloc] initWithUTF8String:
//                                    (const char *) sqlite3_column_text(statement, 2)]];

                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                                 (const char *) sqlite3_column_text(statement, 2)]];
                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 4)]];
                
            
            }
            return getMdns;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;
}

-(BOOL)saveToBalTbl:(NSString *)mdn bu:(NSString *)bu productType:(NSString *)productType servType:(NSString *)servType mainBal:(NSString *)mainBal
            mainVal:(NSString *)mainVal dataBal:(NSString *)dataBal dataVal:(NSString *)dataVal currentlyActv:(NSString *)currentlyActv availForActiv:(NSString *)availForActiv billCycle:(NSString *)billCycle billAmt:(NSString *)billAmt billDueDate:(NSString *)billDueDate unbilAmt:(NSString *)unbilAmt creditLimit:(NSString *)creditLimit dataConsumed:(NSString *)dataConsumed;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insert_bal_mst = [NSString stringWithFormat:@"insert into tbl_base_balance (mdn, bu, product_type,service_type,main_balance,main_validity,data_balance,data_validity,currently_active,available_for_activation,bill_cycle,bill_amount,bill_due_date,unbill_amount,credit_limit,data_consumed) values(\"%@\",\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", mdn, bu, productType,servType,mainBal,mainVal,dataBal,dataVal,currentlyActv,availForActiv,billCycle,billAmt,billDueDate,unbilAmt,creditLimit,dataConsumed];
        
        NSLog(@"insert_prod_mst is :%@",insert_bal_mst);
        const char *insert_query_bal_mst = [insert_bal_mst UTF8String];
        
        NSLog(@"insert_query_bal_mst  : %s",insert_query_bal_mst);
        
        sqlite3_prepare_v2(database, insert_query_bal_mst,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to bal master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in bal master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return NO;

}

-(BOOL)delete_associated_num:(NSString *)other_mdn;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *deleteTable = [NSString stringWithFormat:@"delete from tbl_other_mdns where temp_other_mdns=\"%@\"",other_mdn];
        const char *query_deleteTable = [deleteTable UTF8String];
        sqlite3_prepare_v2(database, query_deleteTable,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            NSLog(@"DATA FROM OTHER MDN DELETED");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"DATA FRM OTHER MDN not FOUND");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in finding other mdn");
    sqlite3_close(database);
    return NO;

}

-(NSString *)getEmail;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getEmailVal = [NSString stringWithFormat:@"select email from tbl_user_master limit 1"];
        const char *query_getEmailVal = [getEmailVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getEmailVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *emailId = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"display_name found %@",emailId);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return emailId;
            }
            else{
                NSLog(@"serviceValOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSString *)getMDNEmail:(NSString *)mdn;
{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getEmailVal = [NSString stringWithFormat:@"select temp_emailId from tbl_other_mdns where temp_other_mdns=\"%@\"",mdn];
        const char *query_getEmailVal = [getEmailVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getEmailVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *email = [[NSString alloc] initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 0)];
                
                NSLog(@"email found %@",email);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return email;
            }
            else{
                NSLog(@"mdnVal Not found");
                return nil;
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(database);
    return nil;
    
    
}


-(NSString *)selectMdn;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getMDNVal = [NSString stringWithFormat:@"select * from tbl_user_master limit 1"];
        const char *query_getMDNVal = [getMDNVal UTF8String];
        if (sqlite3_prepare_v2(database,query_getMDNVal, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *mdnVal = [[NSString alloc] initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 2)];
                
                NSLog(@"mdnVal found %@",mdnVal);
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return mdnVal;
            }
            else{
                NSLog(@"mdnVal Not found");
                return nil;
            }
            sqlite3_finalize(statement);
            
        }
    }
    sqlite3_close(database);
    return nil;
}

-(BOOL)checkMDNexists:(NSString *)mdn status:(NSString *)status;
{
    
    NSLog(@"other mdn value is :%@",mdn);
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *mdnExists = [NSString stringWithFormat:@"select * from tbl_other_mdns where temp_status=\"%@\" and temp_other_mdns=\"%@\"",status,mdn];
        
        NSLog(@"mdnExists is : %@",mdnExists);
        
        const char *query_mdnExists = [mdnExists UTF8String];
        sqlite3_prepare_v2(database, query_mdnExists,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
                    
            NSLog(@"SELECT ALL OTHER MDN");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"SELECT ALL OTHER MDN Not Found");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in SELECT ALL OTHER MDN");
    sqlite3_close(database);
    return NO;
}

-(int)checkMDNcount:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getCount = [NSString stringWithFormat:@"select count(*) from tbl_other_mdns where temp_status=\"%@\"",status];
        const char *query_getCount = [getCount UTF8String];
        if (sqlite3_prepare_v2(database,query_getCount, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int countVal =  sqlite3_column_int(statement, 0);
                
               
                NSLog(@"countVal value found");
                NSLog(@"db closed");
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return countVal;
            }
            else{
                NSLog(@"countVal not found");
                return 0;
            }
            sqlite3_finalize(statement);
        }
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return 0;

}


-(NSMutableArray *)getAllOTA;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getAllData = [NSString stringWithFormat:@"select * from tbl_ota"];
        const char *query_getAllData = [getAllData UTF8String];
        NSMutableArray *allData = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getAllData, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                                    (const char *) sqlite3_column_text(statement, 0)]];
                
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                                    (const char *) sqlite3_column_text(statement, 1)]];
                
                [allData addObject:[[NSString alloc] initWithUTF8String:
                                                    (const char *) sqlite3_column_text(statement, 2)]];
                
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return allData;
            }
            else{
                NSLog(@"All Ota Val Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;
}

-(BOOL)deleteOtherMDNPending:(NSString *)statusVal;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *deleteMDN = [NSString stringWithFormat:@"delete from tbl_other_mdns where temp_status=\"%@\"",statusVal];
        const char *query_deleteMDN = [deleteMDN UTF8String];
        sqlite3_prepare_v2(database, query_deleteMDN,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            NSLog(@"DATA FROM OTHER MDN PENDING STATUS DELETED");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"DATA FRM OTHER MDN PENDING STATUS not FOUND");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in finding other mdn pending status");
    sqlite3_close(database);
    return NO;

}

-(NSMutableArray *)getSelectedNoDetails:(NSString *)selectedNo status:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getDetail = [NSString stringWithFormat:@"select * from tbl_other_mdns where temp_other_mdns=\"%@\" and temp_status=\"%@\"",selectedNo,status];
        const char *query_getDetail = [getDetail UTF8String];
        
        NSMutableArray *getData = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getDetail, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                [getData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 8)]];
                [getData addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 4)]];
                
                
            }
            return getData;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSString *)getProdTypeFromOther:(NSString *)otherMdn;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getProdTypeOther = [NSString stringWithFormat:@"select temp_product_type from tbl_other_mdns where temp_other_mdns=\"%@\"",otherMdn];
        const char *query_getProdTypeOther = [getProdTypeOther UTF8String];
        if (sqlite3_prepare_v2(database,query_getProdTypeOther, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *prodTypeOther = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                
                sqlite3_finalize(statement);
                sqlite3_close(database);
                NSLog(@"prodTypeOther found %@",prodTypeOther);
                return prodTypeOther;
            }
            else{
                NSLog(@"prodTypeOther Not found");
                return nil;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    return nil;

}

-(BOOL)saveToVASMst:(NSString *)category serv_id:(NSString *)serv_id type:(NSString *)type offerValidity:(NSString *)offerValidity
          price:(NSString *)price vendor:(NSString *)vendor vasName:(NSString *)vasName desc:(NSString *)desc mdn:(NSString *)mdn prodType:(NSString *)prodType;
{
    
    sqlite3_close(database);
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertVASSQL = [NSString stringWithFormat:@"insert into tbl_vas_offers(category,service_id, offer_type, offer_validity,offer_price,offer_vendor,vasname,desc,mdn,productType) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\")",category,serv_id, type, offerValidity, price,vendor, vasName, desc, mdn, prodType];
        
        NSLog(@"insertQuery is :%@",insertVASSQL);
        const char *insert_category = [insertVASSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_category,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            
            return YES;
        }
        else {
            NSLog(@"fail insertion in master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
        
    }
    
    NSLog(@"db closed");
    sqlite3_close(database);
    return NO;
}

-(NSMutableArray *)getCategoryData:(NSString *)category;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getCategory = [NSString stringWithFormat:@"select * from tbl_vas_offers where category=\"%@\"",category];
        const char *query_getCategory = [getCategory UTF8String];
        
        NSMutableArray *getCategoryDetails = [[NSMutableArray alloc] init];
        
        if (sqlite3_prepare_v2(database,query_getCategory, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSLog(@"category is : %@",[[NSString alloc] initWithUTF8String:
                                           (const char *) sqlite3_column_text(statement, 1)]);
                
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 1)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 2)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 3)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 4)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 5)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 6)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 7)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 8)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 9)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 10)]];
                
                
            }
            
            NSLog(@"getcategorydetails is : %@",getCategoryDetails);
            return getCategoryDetails;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;

}

-(NSMutableArray *)getCategoryDataAll:(NSString *)type;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getCategory = [NSString stringWithFormat:@"select * from tbl_vas_offers where offer_type=\"%@\"",type];
        const char *query_getCategory = [getCategory UTF8String];
        
        NSMutableArray *getCategoryDetails = [[NSMutableArray alloc] init];
        
        if (sqlite3_prepare_v2(database,query_getCategory, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSLog(@"category is : %@",[[NSString alloc] initWithUTF8String:
                                           (const char *) sqlite3_column_text(statement, 1)]);
                
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 1)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 2)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 3)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 4)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 5)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 6)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 7)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 8)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 9)]];
                [getCategoryDetails addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 10)]];
                
                
            }
            
            NSLog(@"getcategorydetails is : %@",getCategoryDetails);
            return getCategoryDetails;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;
    
}

-(NSMutableArray *)getCategories;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getCategoryList = [NSString stringWithFormat:@"select DISTINCT category from tbl_vas_offers where offer_type=\"%@\"",@"A"];
        const char *query_getCategoryList = [getCategoryList UTF8String];
        
        NSMutableArray *getCategories = [[NSMutableArray alloc] init];
        [getCategories addObject:@"All"];
        if (sqlite3_prepare_v2(database,query_getCategoryList, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
            
                
                [getCategories addObject:[[NSString alloc] initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 0)]];
            }
            
            return getCategories;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;

}






-(BOOL)updateMdnsdata:(NSString *)mdns service_type:(NSString *)service_type bu_type:(NSString *)bu ProductType:(NSString *)producttype ;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *updateMDN = [NSString stringWithFormat:@"update tbl_other_mdns set temp_product_type=\"%@\", temp_bu=\"%@\", temp_service_type=\"%@\" where temp_other_mdns=\"%@\"",producttype,bu,service_type,mdns];
        const char *query_updateMDN = [updateMDN UTF8String];
        sqlite3_prepare_v2(database, query_updateMDN,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            NSLog(@"**********DATA FROM OTHER MDN STATUS UPDATED*************************");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"***********DATA FRM OTHER MDN STATUS not Updated**********");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in updating other mdn status");
    sqlite3_close(database);
    return NO;
    
}





-(BOOL)updateTempAcc:(NSString *)mdns status:(NSString *)status;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *updateMDN = [NSString stringWithFormat:@"update tbl_other_mdns set temp_status=\"%@\" where temp_other_mdns=\"%@\"",status,mdns];
        const char *query_updateMDN = [updateMDN UTF8String];
        sqlite3_prepare_v2(database, query_updateMDN,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            NSLog(@"DATA FROM OTHER MDN STATUS UPDATED");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"DATA FRM OTHER MDN STATUS not Updated");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in updating other mdn status");
    sqlite3_close(database);
    return NO;

}

-(BOOL)updateName:(NSString *)name;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *updateName = [NSString stringWithFormat:@"update tbl_user_master set display_name=\"%@\"",name];
        const char *query_updateName = [updateName UTF8String];
        sqlite3_prepare_v2(database, query_updateName,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            NSLog(@"NAME UPDATED");
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else{
            NSLog(@"NAME not Updated");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    NSLog(@"Error in updating other mdn status");
    sqlite3_close(database);
    return NO;

}


-(BOOL)insertBannerDetails:(NSString *)bannerImagePath bannerName:(NSString *)bannerName bannerAction:(NSString *)bannerAction;
{
    
    sqlite3_close(database);
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into tbl_banner(banner_image,banner_name, banner_action) values(\"%@\",\"%@\", \"%@\")",bannerImagePath, bannerName, bannerAction];
        
        NSLog(@"insertQuery is :%@",insertSQL);
        const char *insert_stmt_banner = [insertSQL UTF8String];
        
        NSLog(@"inserstatement  : %s",insert_stmt_banner);
        
        sqlite3_prepare_v2(database, insert_stmt_banner,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"success in saving to master");
            return YES;
        }
        else {
            NSLog(@"fail insertion in banner master %s",sqlite3_errmsg(database));
            return NO;
        }
        sqlite3_finalize(statement);
        
    }
    NSLog(@"db closed");
    sqlite3_close(database);
    return NO;
}

-(NSMutableArray *)getBannerDetails;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *getBannerDetails = [NSString stringWithFormat:@"select * from tbl_banner limit 1"];
        const char *query_getBannerDetails = [getBannerDetails UTF8String];
        
        NSMutableArray *getBanners = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database,query_getBannerDetails, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [getBanners addObject:[[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)]];
                [getBanners addObject:[[NSString alloc] initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 1)]];
                [getBanners addObject:[[NSString alloc] initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 2)]];
            }
            
            return getBanners;
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    sqlite3_close(database);
    return nil;
}

@end
