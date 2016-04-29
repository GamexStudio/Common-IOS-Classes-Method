//
//  WebAdapter.m
//  RPG
//
//  Created by Ashish Chauhan on 12/04/16.
//  Copyright © 2016 Ashish Chauhan. All rights reserved.
//

#import "WebAdapter.h"

@implementation WebAdapter



+(void)performHttpRequest:(NSDictionary *)postDict  uri:(NSString *)uri completion:(void (^)(NSDictionary *dictionary, NSError *error))completion
{



        NSString *escapedPath = [uri stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
        NSURL *verifyMDNURL = [NSURL URLWithString:escapedPath];
    
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:verifyMDNURL];
        request.HTTPMethod = @"POST";
        [request addValue:SOURCE forHTTPHeaderField:SOURCE_KEY];
        [request addValue:AUTHORIZATION forHTTPHeaderField:AUTHORIZATION_KEY];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    
    if ([postDict count]!=0) {
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        request.HTTPBody = jsonData;

        
    }
    
    
    
    
    
        __block NSHTTPURLResponse *responseObj = nil;
        __block NSError *error = nil;
    
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
//                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//    
//    
//                                   NSData *responseData = data;
//                                   
//                                   
//                                   responseObj = (NSHTTPURLResponse *)response;
//                                   
//                                   
//                                   error = connectionError;
//                                   
//                                   
//                                   NSString *postString = nil;
//                                   
//                                   
//                                   
//                                   if (responseData) {
//                                       postString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//                                       NSLog(@"%@",postString);
//                                   }
//                                   
//                                   
//                                   
//                                   if (error) {
//                                       completion(nil,error);
//                                   }
//                                   else
//                                   {
//                                   
//    
//                                   if (responseData && !error && ([responseObj statusCode] == 200)) {
//    
//                                       NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
//    
//                                       
//                                       completion(responseDict,nil);
//                                       
//                                       
//                                   }
//                                       else
//                                       {
//                                       
//                                       
//                                           completion(nil,nil);
//                                       
//                                       
//                                       }
//                                       
//                                   
//                                   }
//                                   
//                                   
//                                  
//                                  
//                               }
//         
//         
//         ];

    
    

    


    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
     
         
         
         NSData *responseData = data;
         
         
         responseObj = (NSHTTPURLResponse *)response;
         
         
         error = connectionError;
         
         
         NSString *postString = nil;
         
         
         
         if (responseData) {
             postString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
             NSLog(@"%@",postString);
         }
         
         
         
         if (error) {
             completion(nil,error);
         }
         else
         {
             
             
             if (responseData && !error && ([responseObj statusCode] == 200)) {
                 
                 NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                 
                 
                 completion(responseDict,nil);
                 
                 
             }
             else
             {
                 
                 
                 completion(nil,nil);
                 
                 
             }
         }

     
         
         
         
     }];

    
}











@end
