//
//  YokoAFNetAPIClient.h
//
//  Created by Devangi on 20/11/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "Enum.h"

/**
 * @brief API client which is used to send network request and its response back to controller.
 */

@interface YokoAFNetAPIClient : AFHTTPClient

/**
 * @brief used to upload file data .
 *
 * @param dataToUpload: uploading data
 * @param delegate: delegate to whom response given back
 * @param params: request parameters
 * @param multipartData: multipartData dictionary
 * @param delegate: feedType type of feed ie. XML, JSON etc
 * @param headers: header params needs to send for  request headers
 */
- (id) getRequestOperationForFileUpload:(NSData *)dataToUpload delegate:(id)delegate parameters:(NSDictionary *)params multipartData:(NSDictionary *)multipartData forFeedType:(EFeedType)feedType headerParam:(NSDictionary *)headers path:(NSString *)path;

/**
 * @brief used to start the network operation .
 *
 * @param delegate: delegate to whom response given back
 * @param request: constructed of NSMutableURLRequest form parameters send
 * @param delegate: feedType type of feed ie. XML, JSON etc
 * @param headers: header params needs to send for  request headers

 */
- (id) getOperation:(id)delegate forFeedType:(EFeedType)feedType urlRequest:(NSMutableURLRequest *)request headerParam:(NSDictionary *)headers;

/**
 * @brief used to  constuct request from parameter sent and start the network operation .
 *
 * @param delegate: delegate to whom response given back
 * @param requestType: type of request like GET, POST
 * @param dataToPost: data for posting if it is POST request
 * @param headers: header params needs to send for request headers
 * @param params: request parameters
 * @param feedType: feedType type of feed ie. XML, JSON etc
 * @param path: path of the request
 */
- (id) hitRequest:(id)delegate requestType:(NSString *)requestType dataToPost:(NSString *)dataToPost headerParam:(NSDictionary *)headers parameters:(NSDictionary *)params path:(NSString *)path forFeedType:(EFeedType)feedType;

/**
 * @brief used to clear key-value from default headers
 *
 */
- (void) clearValueFromDefaultHeaders:(NSString *)keyValue;

@end
