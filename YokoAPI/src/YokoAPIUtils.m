//
//  Util.m
//  YokoAPI
//
//  Created by Devangi 17/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "YokoAPIUtils.h"
#import "API.h"
#import <YokoAPI/MMConstant.h>
#import <YokoAPI/YokoSocialAPI.h>
#import <ARAnalytics/ARAnalytics.h>
#import "YokoAPI.h"

@implementation YokoAPIUtils

+ (NSString *) stringCheckInDictionary:(NSDictionary *)dictionary key:(NSString *)key
{
    NSObject *str = nil;
    str = ([dictionary valueForKey:key] != nil) ? [dictionary valueForKey:key] : nil;
    if (str == nil)
    {
        return @"";
    }
    else if ([str isKindOfClass:[NSNumber class]])
    {
        return [( (NSNumber *)str )stringValue];
    }
    else if ([str isKindOfClass:[NSNull class]])
    {
        return @"";
    }

    return (NSString *)str;
}


+ (NSString *) checkNullValue:(NSString *)value
{
    if (!value || [value isEqualToString:@"<null>"] || [value isEqualToString:@"(null)"] || [value isEqualToString:@"null"])
    {
        // value = @"";
        return @"";
    }
    else
    {
        return value;
    }
}


+ (BOOL) checkNullArray:(id)object
{
    if ([object isKindOfClass:[NSArray class]] && object != nil && [object count])
    {
        return YES;
    }
    else
    {
        return FALSE;
    }
}


+ (BOOL) checkNullDictionary:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]] && object != nil)
    {
        //NSLog(@"dictinary ");
        return YES;
    }
    else
    {
        return FALSE;
    }
}


+ (void) setCookies
{
    NSUserDefaults *cookiesDefaults = [NSUserDefaults standardUserDefaults];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
    {
        //        NSLog(@"%@....%@",[cookie name],[cookie value]);
        [cookiesDefaults setValue:[cookie value] forKey:[cookie name]];
    }

    //previously we did not synchronize the user default
    //and that cause default never really stored the second time sign in
    [cookiesDefaults synchronize];
}


+ (NSString *) urlRequestToString:(NSURLRequest *)urlRequest
{
    NSString *requestPath = [[urlRequest URL] absoluteString];
    return requestPath;
}


+ (NSDictionary *) getYokoDefaultHeaders
{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:[YokoAPIUtils getYokoCookieDefault],@"Cookie",nil];

    return headers;
}


+ (NSDictionary *) getYokoCookieHeaders
{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:[YokoAPIUtils getYokoCookie],@"Cookie",nil];

    return headers;
}


+ (NSString *) getYokoCookie
{
    return [NSString stringWithFormat:@"%@=%@;%@=%@;%@=%@;",@"xg_ep",
            [[NSUserDefaults standardUserDefaults ] valueForKey:@"xg_ep"],
            @"xg_ep_iv",
            [[NSUserDefaults standardUserDefaults ] valueForKey:@"xg_ep_iv"],@"yoko_csrf_token",
            [[NSUserDefaults standardUserDefaults ] valueForKey:@"yoko_csrf_token"]];
}


+ (NSString *) getYokoCookieDefault
{
    NSString *str = [[NSUserDefaults standardUserDefaults ] valueForKey:[YokoAPI cookieIdentifier]];
    if ([str length] != 0)
    {
        return [NSString stringWithFormat:@"%@=%@",[YokoAPI cookieIdentifier],
                [[NSUserDefaults standardUserDefaults ] valueForKey:[YokoAPI cookieIdentifier]]];
    }
    else
    {
        return nil;
    }
}


+ (BOOL) isUserLoggedIn
{
    //user YOKO_LOGGEDINUSERID as flag instead of [YokoAPI cookieIdentifier] since we use this to distinguish whether signed in
    NSString *cookieDefault = [[NSUserDefaults standardUserDefaults ] valueForKey:YOKO_LOGGEDINUSERID];
    if ([cookieDefault length] != 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL) hasYokoCookie
{
    BOOL exist = NO;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    for (NSHTTPCookie *cookie in storage.cookies)
    {
        if ([cookie.name isEqualToString:[YokoAPI cookieIdentifier]])
        {
            if (cookie.expiresDate != nil && [cookie.expiresDate timeIntervalSinceNow] <= 0)
            {
                // Already expired. Delete to detect expiration with this cookie.
                [storage deleteCookie:cookie];
            }
            else
            {
                exist = YES;
            }

            break;
        }
    }

    return exist;
}


+ (void) clearCookies
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieJar = [storage cookies];

    for (NSHTTPCookie *cookie in cookieJar)
    {
        [storage deleteCookie:cookie];
    }
}


+ (void) resetDefaults
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs removeObjectForKey:[YokoAPI cookieIdentifier]];
    [defs removeObjectForKey:YOKO_LOGGEDINUSERID];
    [defs removeObjectForKey:YOKO_LOGGEDINUSER_SLUG];
    [defs removeObjectForKey:@"xg_ep"];
    [defs removeObjectForKey:@"xg_ep_iv"];
    [defs removeObjectForKey:@"yoko_csrf_token"];
    [defs removeObjectForKey:@"activitySegmentSelected"];
    [defs synchronize];
}


+ (void) removeSubViews:(UIView *)mainView
{
    NSArray *viewsToRemove = [mainView subviews];
    for (UIView *v in viewsToRemove)
    {
        [v removeFromSuperview];
    }
}


+ (void) setValueInNSUserDefault:(NSString *)val withKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:val forKey:key];
    [defaults synchronize];
}


+ (NSString *) getValueFromNSUserDefaultWithKey:(NSString *)key
{
    return ([[NSUserDefaults standardUserDefaults ] valueForKey:key]);
}


+ (BOOL) isNetworkError:(NSError *)error
{
    BOOL isNetwork = NO;

    if ([error.domain isEqualToString:NSURLErrorDomain])
    {
        switch (error.code)
        {
            case NSURLErrorTimedOut:
            // Operation timed out.

            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorNetworkConnectionLost:
            case NSURLErrorInternationalRoamingOff:
            // Connection failures.

            case NSURLErrorCannotFindHost:
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorDNSLookupFailed:
                // Host reachability problems.

                isNetwork = YES;
                break;

            default:
                break;
        } /* switch */
    }

    return isNetwork;
}


+ (void) logoutIfServerError:(NSError *)error
{
    if ([YokoAPIUtils isNetworkError:error])
    {
        // Nothing to do if error is network specific errors.
    }
    else
    {
        // Otherwise, we treat that as server side errors, and do loging out forcefully.
        [[YokoSocialAPI sharedInstance] logout];
    }
}


+ (void) logAPIErrorWithOperation:(AFHTTPRequestOperation *)operation andError:(NSError *)error
{
    NSMutableDictionary *details = [NSMutableDictionary dictionary];

    NSURLRequest *request = operation.request;
    if (request)
    {
        details[@"URL"] = [request.URL.absoluteString copy];
        details[@"Path"] = [request.URL.path copy];
        details[@"HTTPMethod"] = [request.HTTPMethod copy];
    }

    NSHTTPURLResponse *response = operation.response;
    if (response)
    {
        details[@"HTTPStatusCode"] = @(response.statusCode);
    }

    if (error)
    {
        details[@"ErrorDomain"] = [error.domain copy];
        details[@"ErrorCode"] = @(error.code);
        details[@"ErrorDescription"] = [error.localizedDescription copy];
    }

#if defined (DEBUG) || defined (ADHOC)
    NSLog(@"API Error occured.\n%@", error);
    NSLog(@"Flurry dictionary:\n%@", details);
#endif

    [ARAnalytics event:@"YokoAPI Diagnostics" withProperties:details];
}


@end
