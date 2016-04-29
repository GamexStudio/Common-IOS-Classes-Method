//
//  User.h

//
//  Created by Gamex
//  Copyright © 2015 TTH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>
//
//@property (nonatomic , assign) BOOL mpinValidty;
//@property (nonatomic, strong) NSString *userType;
//@property (nonatomic, strong) NSString *profilePicture;
//@property (nonatomic, strong) NSString *firstName;
//@property (nonatomic, strong) NSString *lastName;
//@property (nonatomic, assign) double walletBalance;
//@property (nonatomic, strong) NSString *emailId;
//@property (nonatomic, strong) NSString *kycstatus;
//@property (nonatomic, strong) NSString *account;

+ (void)setMpinValidty :(BOOL)mpin;
+ (void)setLoginStatus :(BOOL)status;

+ (void)setUserType :(NSString *)userType;
+ (void)setProfilePicture :(NSString *)profilePicture;
+ (void)setFirstName :(NSString *)firstName;
+ (void)setLastName :(NSString *)lastName;
+ (void)setEmailId :(NSString *)emailId;
+ (void)setKycstatus :(NSString *)kycstatus;
+ (void)setAccount :(NSString *)account;
+ (void)setWalletBalance :(double)walletBalance;
+ (void)setUserregistered :(BOOL)userregistered;
+ (void)setMobileNumber :(NSString *)mobileNumber;
+ (void)setCreditCardMsg :(NSString *)creditCardMsg;

+ (void)setMerchantBannerURL :(NSString *)mobileNumber;
+ (void)setLandingPageBannerURL :(NSString *)mobileNumber;
+ (void)setBillPaymentBannerURL :(NSString *)mobileNumber;
+ (void)setLoadMoneyBannerURL :(NSString *)mobileNumber;


+ (BOOL)mpinValidty;
+ (NSString *)userType;
+ (NSString *)profilePicture;
+ (NSString *)firstName;
+ (NSString *)lastName;
+ (double)walletBalance;
+ (NSString *)emailId;
+ (NSString *)kycstatus;
+ (NSString *)account;
+ (BOOL)userregistered;
+ (NSString *)mobileNumber;
+ (BOOL)loginStatus;
+ (NSString *)creditCardMsg;

+ (NSString *)merchantBannerURL;
+ (NSString *)landingPageBannerURL;
+ (NSString *)billPaymentBannerURL;
+ (NSString *)loadMoneyBannerURL;

@end