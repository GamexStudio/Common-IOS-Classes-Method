//
//  User.m

//
//  Created by Gamex.
//  Copyright © 2015 TTH. All rights reserved.
//

#import "User.h"

@implementation User


+ (void)setMpinValidty :(BOOL)mpin {
    [[NSUserDefaults standardUserDefaults] setBool:mpin forKey:@"mpinValidty"];
}

+ (void)setLoginStatus :(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"status"];
}

+ (void)setMobileNumber :(NSString *)mobileNumber {
    [[NSUserDefaults standardUserDefaults] setObject:mobileNumber forKey:@"mobileNumber"];
}

+ (void)setUserType :(NSString *)userType {
    [[NSUserDefaults standardUserDefaults] setObject:userType forKey:@"userType"];
}

+ (void)setProfilePicture :(NSString *)profilePicture {
    [[NSUserDefaults standardUserDefaults] setObject:profilePicture forKey:@"profilePicture"];
}

+ (void)setFirstName :(NSString *)firstName {
    [[NSUserDefaults standardUserDefaults] setObject:firstName forKey:@"firstName"];
}

+ (void)setLastName :(NSString *)lastName {
    [[NSUserDefaults standardUserDefaults] setObject:lastName forKey:@"lastName"];
}

+ (void)setEmailId :(NSString *)emailId {
    [[NSUserDefaults standardUserDefaults] setObject:emailId forKey:@"emailId"];
}

+ (void)setKycstatus :(NSString *)kycstatus {
    [[NSUserDefaults standardUserDefaults] setObject:kycstatus forKey:@"kycstatus"];
}

+ (void)setAccount :(NSString *)account {
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"account"];
}

+ (void)setUserregistered :(BOOL)userregistered {
    [[NSUserDefaults standardUserDefaults] setBool:userregistered forKey:@"userregistered"];
}

+ (void)setWalletBalance :(double)walletBalance {
    [[NSUserDefaults standardUserDefaults] setDouble:walletBalance forKey:@"walletBalance"];
}

+ (void)setMerchantBannerURL :(NSString *)merchantBannerURL {
    [[NSUserDefaults standardUserDefaults] setObject:merchantBannerURL forKey:@"merchantBannerURL"];

}

+ (void)setLandingPageBannerURL :(NSString *)landingPageBannerURL {
    [[NSUserDefaults standardUserDefaults] setObject:landingPageBannerURL forKey:@"landingPageBannerURL"];
}

+ (void)setBillPaymentBannerURL :(NSString *)billPaymentBannerURL {
    [[NSUserDefaults standardUserDefaults] setObject:billPaymentBannerURL forKey:@"billPaymentBannerURL"];
}

+ (void)setLoadMoneyBannerURL :(NSString *)loadMoneyBannerURL {
    [[NSUserDefaults standardUserDefaults] setObject:loadMoneyBannerURL forKey:@"loadMoneyBannerURL"];
}


+ (void)setCreditCardMsg :(NSString *)creditCardMsg {
    [[NSUserDefaults standardUserDefaults] setObject:creditCardMsg forKey:@"creditCardMsg"];
}




+ (NSString *)merchantBannerURL {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"merchantBannerURL"];
}

+ (NSString *)landingPageBannerURL {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"landingPageBannerURL"];
}

+ (NSString *)billPaymentBannerURL {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"billPaymentBannerURL"];
}

+ (NSString *)loadMoneyBannerURL {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"loadMoneyBannerURL"];
}

+ (BOOL)mpinValidty{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"mpinValidty"];
}

+ (NSString *)userType{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"userType"];
}

+ (NSString *)profilePicture{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"profilePicture"];
}

+ (NSString *)firstName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"firstName"];
}

+ (NSString *)lastName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"lastName"];
}

+ (double)walletBalance{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"walletBalance"];
}

+ (NSString *)emailId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"emailId"];
}

+ (NSString *)kycstatus{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"kycstatus"];
}

+ (NSString *)account{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
}

+ (NSString *)mobileNumber {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"mobileNumber"];
}

+ (BOOL)userregistered {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"userregistered"];
}

+ (BOOL)loginStatus {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"status"];
}

+ (NSString *)creditCardMsg {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"creditCardMsg"];
}

//- (id)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        self.mpinValidty = [decoder decodeBoolForKey:@"mpinValidty"];
//        self.userType = [decoder decodeObjectForKey:@"userType"];
//        self.profilePicture = [decoder decodeObjectForKey:@"profilePicture"];
//        self.firstName = [decoder decodeObjectForKey:@"firstName"];
//        self.lastName = [decoder decodeObjectForKey:@"lastName"];
//        self.walletBalance = [decoder decodeDoubleForKey:@"walletBalance"];
//        self.emailId = [decoder decodeObjectForKey:@"emailId"];
//        self.kycstatus = [decoder decodeObjectForKey:@"kycstatus"];
//        self.account = [decoder decodeObjectForKey:@"account"];
//    }
//    return self;
//}
//- (void)encodeWithCoder:(NSCoder *)encoder {
//    [encoder encodeBool:self.mpinValidty forKey:@"mpinValidty"];
//    [encoder encodeObject:self.userType forKey:@"userType"];
//    [encoder encodeObject:self.profilePicture forKey:@"profilePicture"];
//    [encoder encodeObject:self.firstName forKey:@"firstName"];
//    [encoder encodeObject:self.lastName forKey:@"lastName"];
//    [encoder encodeDouble:self.walletBalance forKey:@"walletBalance"];
//    [encoder encodeObject:self.emailId forKey:@"emailId"];
//    [encoder encodeObject:self.kycstatus forKey:@"kycstatus"];
//    [encoder encodeObject:self.account forKey:@"account"];
//}

@end
