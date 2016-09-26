//
//  YokoAFNetAPIManager.m
//  YokoMobile
//
//  Created by Devangi on 27/11/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "YokoAFNetAPIManager.h"
#import "YokoAFNetAPIClient.h"

static YokoAFNetAPIManager *_instance = nil;
static NSMutableDictionary *_httpNetClient = nil;

@implementation YokoAFNetAPIManager

#pragma mark -
#pragma mark Singleton Methods

/**
 * @brief used to get  self singleton object .
 *
 * @return YokoAFNetAPIManager singleton object
 */

+ (YokoAFNetAPIManager *) sharedInstance
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            _instance = [[self alloc] init];
            _httpNetClient = [[NSMutableDictionary alloc] init];
        }
    }
    return _instance;
}


- (id) init
{
    self = [super init];
    if (self)
    {
    }

    return self;
}


/**
 * @brief used retrive YokoAFNetAPIClient from baseURL .
 *
 * @param  baseURL: base url act is key for dictionary
 *
 * @return YokoAFNetAPIClient object of network class to perform network operation
 */
- (YokoAFNetAPIClient *) getAFNetAPIClient:(NSString *)baseURL
{
    YokoAFNetAPIClient *client = nil;
    if ([_httpNetClient count] > 0)
    {
        client = [_httpNetClient objectForKey:baseURL];
    }

    if (!client)
    {
        client = [[YokoAFNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        [_httpNetClient setObject:client forKey:baseURL];
    }

    return client;
}


/**
 * @brief checks  API client created for sent base url if not created then create one and
   pass the sent params to API client.
 *
 * @param baseURL: base url to initialize API client
 * @param delegate: delegate to whom response given back
 * @param requestType: type of request like GET, POST
 * @param dataToPost: data for posting if it is POST request
 * @param headers: header params needs to send for request headers
 * @param params: request parameters
 * @param forFeedType: feedType type of feed ie. XML, JSON etc

 */
- (id) hitRequest:(NSString *)baseURL delegate:(id)delegate requestType:(NSString *)requestType dataToPost:(NSString *)dataToPost headerParam:(NSDictionary *)headers parameters:(NSDictionary *)params path:(NSString *)path forFeedType:(EFeedType)feedType
{
    NSLog(@" URL =>%@ path=>%@ dataToPost => %@ withParameter => %@",baseURL,path,dataToPost, params);
    YokoAFNetAPIClient *client = [self getAFNetAPIClient:baseURL];

    AFHTTPRequestOperation *operation = [client hitRequest:delegate requestType:requestType dataToPost:dataToPost headerParam:headers parameters:params path:path forFeedType:feedType];
    return operation;
}


/**
 * @brief checks  API client created for sent base url if not created then create one and
   pass the sent params to API client

 * @param baseURL: base url to initialize API client
 * @param dataToUpload: uploading data
 * @param delegate: delegate to whom response given back
 * @param params: request parameters
 * @param multipartData: multipartData dictionary
 * @param delegate: feedType type of feed ie. XML, JSON etc
 * @param headers: header params needs to send for  request headers
 */
- (id) getRequestOperationForFileUpload:(NSString *)baseURL dataToUpload:(NSData *)dataToUpload delegate:(id)delegate parameters:(NSDictionary *)params multipartData:(NSDictionary *)multipartData forFeedType:(EFeedType)
    feedType                headerParam:(NSDictionary *)headers path:(NSString *)path
{
    YokoAFNetAPIClient *client = [self getAFNetAPIClient:baseURL];
    AFHTTPRequestOperation *operation = [client getRequestOperationForFileUpload:dataToUpload delegate:delegate parameters:params multipartData:multipartData forFeedType:feedType headerParam:headers path:path];

    return operation;
}


/**
 * @brief clear key value from headers
 *
 * @param baseURL: base url to initialize API client
 * @param keyValue: remove key value from headers
 */
- (void) clearKeyValueFromHeaders:(NSString *)baseURL keyValue:(NSString *)keyValue
{
    YokoAFNetAPIClient *client = [self getAFNetAPIClient:baseURL];
    [client clearValueFromDefaultHeaders:keyValue];
}


@end
