//
//  DBManager.h
//  Docomo
//
//  Created by Vijaya Kamath on 13/02/15.
//  Copyright (c) 2015 Vijaya Kamath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveToMst:(NSString *)imei num:(NSString *)num serviceName:(NSString *)serviceName productName:(NSString *)productName
          buName:(NSString *)buName link_id:(int)link_id displayName:(NSString *)displayName circle:(NSString *)circle os:(NSString *)os status:(NSString *)status email:(NSString *)email;

-(BOOL)saveTOTempOtherMDNs:(NSString *)account_no other_mdn:(NSString *)other_mdn temp_mdn:(NSString *)temp_mdn
            temp_serv_type:(NSString *)temp_serv_type temp_status:(NSString *)temp_status temp_unique:(NSString *)temp_unique
            temp_prod_type:(NSString *)temp_prod_type temp_bu_type:(NSString *)temp_bu_type temp_email:(NSString *)temp_email;


-(BOOL)saveToOTA:(NSString *)ota num:(NSString *)num status:(NSString *)status;
-(BOOL)saveToBuMst:(NSString *)bu_type bu_desc:(NSString *)bu_desc bu_status:(NSString *)bu_status;
-(BOOL)saveToServiceMst:(NSString *)service_name service_desc:(NSString *)service_desc service_status:(NSString *)service_status;
-(BOOL)saveToProductMst:(NSString *)prod_name prod_desc:(NSString *)prod_desc prod_status:(NSString *)prod_status;
-(BOOL)saveToBuServProdMst:(int)bu_id service_id:(int)service_id product_id:(int)product_id
                   meaning:(NSString *)meaning status:(NSString *)status;

-(int)getBu_id:(NSString *)bu_type;
-(int)getService_id:(NSString *)service_type;
-(int)getProduct_id:(NSString *)product_type;
-(int)getLink_id:(int)bu_id service_id:(int)service_id product_id:(int)product_id;

-(NSString *)getOTA:(NSString *)num;
-(NSString *)getBuType:(NSString *)num;
-(NSString *)getServiceType:(NSString *)num;

-(NSString *)getBUFromOtherMDN:(NSString *)num;
-(NSString *)getServiceFromOtherMDN:(NSString *)num;

-(NSMutableArray *)getAllUserMst:(NSString *)num;

-(NSString *)getMDN;
-(NSString *)getName;
-(NSMutableArray *)getAllMdns:(NSString *)status;

-(BOOL)addAllDataToTblStore:(NSString *)city longi:(NSString *)longi lati:(NSString *)lati pin:(NSString *)pin add1:(NSString *)add1 add2:(NSString*)add2 circle:(NSString *)circle;

-(NSMutableArray *)getStates;
-(NSMutableArray *)getCities:(NSString *)state;
-(NSMutableArray *)getStoresData:(NSString *)city;
-(NSMutableArray *)getStoresList:(NSString *)pin;
-(BOOL)dataDeleted:(NSString *)tablename;
-(NSMutableArray *)getSelectedNos:(NSString *)status;
-(BOOL)saveToBalTbl:(NSString *)mdn bu:(NSString *)bu productType:(NSString *)productType servType:(NSString *)servType mainBal:(NSString *)mainBal
            mainVal:(NSString *)mainVal dataBal:(NSString *)dataBal dataVal:(NSString *)dataVal currentlyActv:(NSString *)currentlyActv availForActiv:(NSString *)availForActiv billCycle:(NSString *)billCycle billAmt:(NSString *)billAmt billDueDate:(NSString *)billDueDate unbilAmt:(NSString *)unbilAmt creditLimit:(NSString *)creditLimit dataConsumed:(NSString *)dataConsumed;

-(BOOL)delete_associated_num:(NSString *)mdn;
-(NSString *)getEmail;

-(NSString *)selectMdn;
-(BOOL)checkMDNexists:(NSString *)mdn status:(NSString *)status;
-(int)checkMDNcount:(NSString *)status;
-(NSMutableArray *)getAllOTA;
-(BOOL)deleteOtherMDNPending:(NSString *)statusVal;
-(NSMutableArray *)getSelectedNoDetails:(NSString *)selectedNo status:(NSString *)status;

-(NSString *)getProdTypeFromOther:(NSString *)otherMdn;

-(BOOL)saveToVASMst:(NSString *)category serv_id:(NSString *)serv_id type:(NSString *)type offerValidity:(NSString *)offerValidity
              price:(NSString *)price vendor:(NSString *)vendor vasName:(NSString *)vasName desc:(NSString *)desc mdn:(NSString *)mdn prodType:(NSString *)prodType;

-(NSMutableArray *)getCategoryData:(NSString *)category;
-(NSMutableArray *)getCategories;
-(BOOL)updateTempAcc:(NSString *)mdns status:(NSString *)status;

-(BOOL)updateName:(NSString *)name;
-(BOOL)updateMdnsdata:(NSString *)mdns service_type:(NSString *)service_type bu_type:(NSString *)bu ProductType:(NSString *)producttype;

-(NSMutableArray *)getCategoryDataAll:(NSString *)type;
-(BOOL)insertBannerDetails:(NSString *)bannerImagePath bannerName:(NSString *)bannerName bannerAction:(NSString *)bannerAction;
-(NSMutableArray *)getBannerDetails;

-(NSString *)getMDNEmail:(NSString *)mdn;

-(NSArray *)getprepaid;
-(NSMutableArray *)getallprepaid:(NSString *)bu;

-(NSMutableArray *)getpredatamobile:(NSString *)selectedNo status:(NSString *)status;

@end
