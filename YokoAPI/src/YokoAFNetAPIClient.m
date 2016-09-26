//
//  YokoAFNetAPIClient.m
//
//  Created by Devangi on 20/11/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "YokoAFNetAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"
#import "AFXMLRequestOperation.h"
//#import "Utils.h"
//#import "Api.h"

#define YOKOAPI_TIMEOUT_DURATION 30

@implementation YokoAFNetAPIClient

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

- (id) getRequestOperationForFileUpload:(NSData *)dataToUpload delegate:(id)delegate parameters:(NSDictionary *)params multipartData:(NSDictionary *)multipartData forFeedType:(EFeedType)
    feedType                headerParam:(NSDictionary *)headers path:(NSString *)path
{
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:path parameters:params constructingBodyWithBlock: ^(id < AFMultipartFormData > formData)
    {
        [formData appendPartWithFileData:dataToUpload name:[multipartData objectForKey:@"avatar"] fileName:[multipartData objectForKey:@"fileName"] mimeType:[multipartData objectForKey:@"mimeType"]];
    }


                                   ];

    //NOTE: We can set timeout duration here. Unit is seconds.
    [request setTimeoutInterval:YOKOAPI_TIMEOUT_DURATION];

    AFHTTPRequestOperation *operation = [self getOperation:delegate forFeedType:feedType urlRequest:request headerParam:headers];

    return operation;
}


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
- (id) hitRequest:(id)delegate requestType:(NSString *)requestType dataToPost:(NSString *)dataToPost headerParam:(NSDictionary *)headers parameters:(NSDictionary *)params path:(NSString *)path forFeedType:(EFeedType)feedType
{
    [self setParameterEncoding:AFJSONParameterEncoding];

    if (headers)
    {
        NSArray *keys = [headers allKeys];

        for (id key in keys)
        {
            [self setDefaultHeader:key value:[headers objectForKey:key]];
        }
    }

    NSMutableURLRequest *request = [self requestWithMethod:requestType path:path parameters:params];
    if (dataToPost)
    {
        [request setHTTPBody:[dataToPost dataUsingEncoding:NSUTF8StringEncoding]];
    }

    //NOTE: We can set timeout duration here. Unit is seconds.
    [request setTimeoutInterval:YOKOAPI_TIMEOUT_DURATION];

    // Set User-Agent header.
    [request setValue:[self userAgent] forHTTPHeaderField:@"User-Agent"];

    AFHTTPRequestOperation *operation;

    if (feedType == EJSON)
    {
        operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    }
    else if (feedType == EXML)
    {
        operation = [[AFXMLRequestOperation alloc] initWithRequest:request];
    }
    else
    {
        operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    }

    return operation;
}


/**
 * @brief used to start the network operation .
 *
 * @param delegate: delegate to whom response given back
 * @param request: constructed of NSMutableURLRequest form parameters send
 * @param delegate: feedType type of feed ie. XML, JSON etc
 * @param headers: header params needs to send for  request headers

 */
- (id) getOperation:(id)delegate forFeedType:(EFeedType)feedType urlRequest:(NSMutableURLRequest *)request headerParam:(NSDictionary *)headers
{
    if (headers)
    {
        NSArray *keys = [headers allKeys];

        for (id key in keys)
        {
            [self setDefaultHeader:key value:[headers objectForKey:key]];
        }
    }

    // Set User-Agent header.
    [request setValue:[self userAgent] forHTTPHeaderField:@"User-Agent"];

    AFHTTPRequestOperation *operation;

    if (feedType == EJSON)
    {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    }
    else if (feedType == EXML)
    {
        operation = [[AFXMLRequestOperation alloc] initWithRequest:request];
    }
    else
    {
        operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    }

    return operation;
}


/**
 * @brief Standard User-Agent string with company name appended.
 *

 */
- (NSString *) userAgent
{
    // Hard-coded company name
    NSString *companyName = @"MediaCorp";
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f) %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ? :[[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ? :[[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f), companyName];

    return userAgent;
}


@end
