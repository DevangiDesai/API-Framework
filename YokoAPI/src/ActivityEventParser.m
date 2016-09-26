//
//  ActivityEventParser.m
//  YokoAPI
//
//  Created by Devangi 26/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "ActivityEventParser.h"
#import "ActivityEventBean.h"
#import "ActivityBean.h"

@implementation ActivityEventParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @param type response type (profile, restaurant, recipe).
 * @param action - love, collect, didit.
 * @return returns array of objects.
 */
+ (NSArray *) parseJSON:(NSDictionary *)data type:(NSString *)type action:(NSString *)action
{
    NSMutableArray *beans = [[NSMutableArray alloc] init];
    //To-Do, change temporaily so that collection will return result, will need refactor in later feature branch
    if ([type isEqualToString:@"recipes"] || [type isEqualToString:@"restaurants"])
    {
        NSArray *activities = [data objectForKey:@"loves"] ? [data objectForKey:@"loves"] : [data objectForKey:@"collections"] ? [data objectForKey:@"collections"] : [data objectForKey:@"didits"];
        for (NSDictionary *activity in activities)
        {
            ActivityBean *bean = [[ActivityBean alloc] initWithJson:activity];
            [beans addObject:bean];
        }
    }
    else if ([type isEqualToString:@"profile"] || [action isEqualToString:@"love"] )
    {
        NSArray *activities = [data objectForKey:@"loves"] ? [data objectForKey:@"loves"] : [data objectForKey:@"collections"] ? [data objectForKey:@"collections"] : [data objectForKey:@"didits"];
        for (NSDictionary *activity in activities)
        {
            ActivityEventBean *bean = [[ActivityEventBean alloc] initWithJson:activity];
            [beans addObject:bean];
        }
    }
    else
    {
        NSDictionary *activities = [data objectForKey:@"loves"] ? [data objectForKey:@"loves"] : [data objectForKey:@"collections"] ? [data objectForKey:@"collections"] : [data objectForKey:@"didits"];

        if ([activities count] > 0)
        {
            NSEnumerator *enumerator = [activities keyEnumerator];
            id key;
            while ( (key = [enumerator nextObject]) )
            {
                NSDictionary *subDictionary = [activities objectForKey:key];
                ActivityEventBean *bean = [[ActivityEventBean alloc] initWithJson:subDictionary];
                [beans addObject:bean];
            }
        }
    }

    return beans;
}


@end
