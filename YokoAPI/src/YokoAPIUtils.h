//
//  Util.h
//  YokoAPI
//
//  Created by Devangi 17/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

/**
 * @brief This class contains information that represents Utils for YOKO.
 */
@interface YokoAPIUtils : NSObject

/**
 * @brief  This method is for checking the null value assigned instead of Disctionary.
 *
 * @param  dictionary check key into some disctionary
 * @param  key check key in disctonary
 * @return returns string of checked value
 */
+ (NSString *) stringCheckInDictionary:(NSDictionary *)dictionary key:(NSString *)key;

/**
 * @brief  This method is for checking the null value assigned instead of Array.
 *
 * @param  object check object into some array
 * @return returns bool of checked value
 */
+ (BOOL) checkNullArray:(id)object;

/**
 * @brief  This method is for checking the null value assigned instead of Disctionary.
 *
 * @param  object check object into some Disctionary
 * @return returns bool of checked value
 */
+ (BOOL) checkNullDictionary:(id)object;

/**
 * @brief cookies to set after getting login into Yoko
 */
+ (void) setCookies;

/**
 * @brief  This method is for change url to string.
 *
 * @param  urlRequest request url for conversion
 * @return returns changed string from URL
 */
+ (NSString *) urlRequestToString:(NSURLRequest *)urlRequest;

/**
 * @brief  This method is for getting cookies.
 *
 * @return returns dictionary of YOKO
 */
+ (NSDictionary *) getYokoCookieHeaders;

/**
 * @brief This method is for clearing cookies from application
 */
+ (void) clearCookies;

/**
 * @brief This method is for resetting defaults into application
 */
+ (void) resetDefaults;

/**
 * @brief  This method is for getting defaults from application
 *
 * @return returns dictionary of YOKO defaults
 */
+ (NSDictionary *) getYokoDefaultHeaders;

/**
 * @brief This method is for removing views from main view
 *
 * @param mainView main view from subview will be removed
 */
//+ (void)removeSubViews:(UIView *)mainView;

/**
 * @brief This method is for setting values to user defaults
 *
 * @param val value of defauls
 * @param key key of defauls
 */
+ (void) setValueInNSUserDefault:(NSString *)val withKey:(NSString *)key;

/**
 * @brief  This method is for getting values from user defaults
 *
 * @param  key key of defauls
 *
 * @return returns string value of requested key
 */
+ (NSString *) getValueFromNSUserDefaultWithKey:(NSString *)key;

/**
 * @brief  This method is for checking that user is loggin or not
 *
 * @return returns bool value of check
 */
+ (BOOL) isUserLoggedIn;


/**
 * This method is for checking Yoko session cookie existence.
 *
 * @return YES if exists, otherwise NO.
 */
+ (BOOL) hasYokoCookie;


/**
 * This method is for checking the error cause is network errors or not. For example, reachability errors and timed out will return YES.
 *
 * @return YES if the error is network related, otherwise NO.
 */
+ (BOOL) isNetworkError:(NSError *)error;


/**
 * This will run logout process when network error is given. Otherwise, no operation for it.
 */
+ (void) logoutIfServerError:(NSError *)error;


/**
 * This logs error details on API calls with Flurry.
 *
 * @param operation The request operation that is used on API calls.
 * @param error The NSError object on API calls.
 */
+ (void) logAPIErrorWithOperation:(AFHTTPRequestOperation *)operation andError:(NSError *)error;

@end
