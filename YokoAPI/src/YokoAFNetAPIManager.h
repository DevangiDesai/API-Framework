//
//  YokoAFNetAPIManager.h
//  YokoMobile
//
//  Created by Devangi on 27/11/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum.h"

@interface YokoAFNetAPIManager : NSObject

/**
 * @brief used to get  self singleton object .
 *
 * @return YokoAFNetAPIManager singleton object
 */
+ (YokoAFNetAPIManager *)sharedInstance;

/**
 * @brief checks  API client created for sent base url if not created then create one and
    pass the sent params to API client

 * @param  baseURL: base url to initialize API client
 * @param  dataToUpload: uploading data
 * @param delegate: delegate to whom response given back
 * @param params: request parameters
 * @param multipartData: multipartData dictionary
 * @param delegate: feedType type of feed ie. XML, JSON etc
 * @param headers: header params needs to send for  request headers
 */
- (id)      getRequestOperationForFileUpload:(NSString *)baseURL dataToUpload:(NSData *)dataToUpload delegate:(id)delegate parameters:(NSDictionary *)params multipartData:(NSDictionary *)multipartData forFeedType:(EFeedType)
    feedType headerParam:(NSDictionary *)headers path:(NSString *)path;

/**
 * @brief checks  API client created for sent base url if not created then create one and
   pass the sent params to API client.
 *
 * @param  baseURL: base url to initialize API client
 * @param delegate: delegate to whom response given back
 * @param  requestType: type of request like GET, POST
 * @param  dataToPost: data for posting if it is POST request
 * @param headers: header params needs to send for request headers
 * @param params: request parameters
 * @param forFeedType: feedType type of feed ie. XML, JSON etc
 */
- (id)hitRequest:(NSString *)baseURL delegate:(id)delegate requestType:(NSString *)requestType dataToPost:(NSString *)dataToPost headerParam:(NSDictionary *)headers parameters:(NSDictionary *)params path:(NSString *)path forFeedType:(EFeedType)feedType;

/**
 * @brief clear key value from headers
 *
 * @param baseURL: base url to initialize API client
 * @param keyValue: remove key value from headers
 */
- (void)clearKeyValueFromHeaders:(NSString *)baseURL keyValue:(NSString *)keyValue;

@end
