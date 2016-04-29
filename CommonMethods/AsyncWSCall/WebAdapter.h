//
//  WebAdapter.h
//  RPG
//
//  Created by Ashish Chauhan on 12/04/16.
//  Copyright © 2016 Ashish Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebAdapter : NSObject






+ (void)performHttpRequest:(NSDictionary *)postDict  uri:(NSString *)uri completion:(void (^)(NSDictionary *dictionary, NSError *error))completion;



@end
