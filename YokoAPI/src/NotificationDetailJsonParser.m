//
//  NotificationDetailParser.m
//  YokoMobile
//
//  Created by Devangi on 24/05/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "NotificationDetailJsonParser.h"
#import "NotificationBean.h"

@implementation NotificationDetailJsonParser

/**
 * @brief  This method is used to parse Data.
 *
 * @param data is used to dictionary object of response.
 */
+ (NSMutableArray *) parseJSON:(NSDictionary *)response
{
    NSArray *keys = [[NSArray alloc] initWithObjects:@"today",@"yesterday",@"thisweek",@"lastweek",@"thismonth",@"lastmonth",@"older", nil];
    NSMutableArray *notificationDetail = [[NSMutableArray alloc] init];
    NSMutableArray *notifications = nil;
    NSMutableDictionary *beans = nil;
    NSArray *chekResponse = [response objectForKey:@"notifications"];
    if ([chekResponse count] > 0)
    {
        for (int i = 0; i < [keys count]; i++)
        {
            NSArray *data = [[[response objectForKey:@"notifications"] objectForKey:[keys objectAtIndex:i]] valueForKey:@"list"];
            if ( [data count] > 0 && !([data objectAtIndex:0] == [NSNull null]) )
            {
                notifications = [[NSMutableArray alloc] init];
                beans = [[NSMutableDictionary alloc] init];
                NotificationBean *bean;
                for (NSDictionary *notificationDict in data)
                {
                    bean = [[NotificationBean alloc] initWithJson:notificationDict];
                    [notifications addObject:bean];
                }

                [beans setObject:notifications forKey:[keys objectAtIndex:i]];
                [notificationDetail addObject:beans];
            }
        }
    }

    return notificationDetail;
}


+ (NSMutableArray *) parseJSONForCannes:(NSDictionary *)response
{
    NSArray *data = [response objectForKey:@"notifications"];
    NSMutableArray *notifications = [[NSMutableArray alloc] init];
    if ( [data count] > 0 && !([data objectAtIndex:0] == [NSNull null]) )
    {
        NotificationBean *bean;
        for (NSDictionary *notificationDict in data)
        {
            bean = [[NotificationBean alloc] initWithJson:notificationDict];
            [notifications addObject:bean];
        }
    }

    return notifications;
}


@end
