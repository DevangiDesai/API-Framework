//
//  YokoSocialAPI.h
//  YokoAPI
//
//  Created by Devangi on 28/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import "AFHTTPRequestOperation.h"

extern NSString *const FBSessionStateChangedNotification;
typedef enum {
    kYokoLoginTypeSignIn,
    kYokoLoginTypeSignUp
} YokoLoginType;

@class YokoSocialAPI;

@protocol YokoSocialAPIClassDelegate

- (void)getTwitterAccountList:(NSArray *)twitterAccounts;

@end

/**
 * @brief This class contains information that represents authentication with twitter and facebook. It also sets cookies from YOKO.
 */
@interface YokoSocialAPI : NSObject
{
    ACAccountStore *accountStore;
    BOOL signUpFlag;
}
@property (nonatomic,strong) NSArray *arrayOfAccounts;
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSString *loginService;
@property (nonatomic, assign) YokoLoginType loginType;
@property (nonatomic, strong) NSString *loginSourceForTracking;
@property (nonatomic, strong) NSString *actionTypeForTracking;
@property (nonatomic, copy) void (^didLogoutBlock)(); /** This is called after logout. */

/**
 * @brief Initialize facebook login.
 */
- (void)initFacebookLogin;

/*
 * @abstract Gets the singleton instance.
 */
+ (id)sharedInstance;

/**
 * @brief log in with twitter.
 */
- (void)loginWithTwitter;

/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param accountIndex Integer value of selected account
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param needsInfoBlock A block object to be executed when the request operation needs extra execution.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void)loginToYokoWithTwitterAccount:(NSInteger)accountIndex
                              success:( void( ^) (id responseObject) ) successBlock
                  needsAdditionalInfo:( void( ^) (NSArray * infoNeeded) ) needsInfoBlock
                              failure:( void ( ^) (AFHTTPRequestOperation *operation, NSError *error, NSString *customErrorMsg) )failureBlock;

/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param emailAddress Email Address String
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void)signUpYokoTwitterLoginWithEmail:(NSString *)emailAddress
                                success:( void( ^) (id responseObject) ) successBlock
                                failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * This method will delete local Yoko authentication data. After then, this calls didLogoutBlock if exists.
 */
- (void)logout;

- (void) finishYokoTwitterLoginWithEmail:(NSString *)emailAddress
                                  success:( void ( ^)(id responseObject) )successBlock
                                  failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock;


@end
