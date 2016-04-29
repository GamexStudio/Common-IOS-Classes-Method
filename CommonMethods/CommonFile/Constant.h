//
//  Constant.h
//
//
//  Created by Gamex
//  Copyright © 2015 TTH. All rights reserved.
//


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 1;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

#define DEFAULT_COLOR [UIColor colorWithRed:0.09019607843 green:0.462745098 blue:0.7450980392 alpha:1]

#define SOURCE          @"b3JpZ2luYWwgU3RyaW5nIGJlZm9yZSBiYXNlNjQgZW5jb2RpbmcgaW4gSmF2YQ=="
#define AUTHORIZATION   @"b3JpZ2luYWwgU3RyaW5nIGJlZm9yZSBiYXNlNjQgZW5jb2RpbmcgaW4gSmF2YQ=="

#define SOURCE_KEY          @"Source"
#define AUTHORIZATION_KEY   @"Authorization"




#define IS_IPHONE4          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

///POST///
#define ROOT_URL_GET @"http:"
#define ROOT_URL @"http:"

#define ROOT_URL_BANNER_IMAGE @"http:"

#define USER_STATUS @"getUserStatus"

///GET///
#define GET_OFFERS          @"getOffers"
#define GET_DTH_STATES      @"http://180.179.50.55/numberdemo/WebService/listAllStates?api_key=448e4b049ae3d31a8484e48f8c439b85644b4665&page=1"

